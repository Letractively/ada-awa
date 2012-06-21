-----------------------------------------------------------------------
--  awa-events-queues-persistents -- AWA Event Queues
--  Copyright (C) 2012 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
-----------------------------------------------------------------------
with Ada.Calendar;
with Ada.Strings.Unbounded;

with Util.Log.Loggers;
with Util.Serialize.IO.XML;
with Util.Properties;
with Util.Streams.Texts;
with Util.Streams.Buffered;
with Util.Serialize.Tools;

with AWA.Services.Contexts;
with AWA.Users.Models;

with ADO;
with ADO.Queries;
with ADO.Sessions;
with ADO.SQL;
package body AWA.Events.Queues.Persistents is

   use Util.Log;

   Log : constant Loggers.Logger := Loggers.Create ("AWA.Events.Queues.Persistents");

   --  ------------------------------
   --  Get the queue name.
   --  ------------------------------
   overriding
   function Get_Name (From : in Persistent_Queue) return String is
   begin
      return From.Name;
   end Get_Name;

   --  ------------------------------
   --  Get the model queue reference object.
   --  Returns a null object if the queue is not persistent.
   --  ------------------------------
   overriding
   function Get_Queue (From : in Persistent_Queue) return AWA.Events.Models.Queue_Ref is
   begin
      return From.Queue;
   end Get_Queue;

   --  ------------------------------
   --  Queue the event.  The event is saved in the database with a relation to
   --  the user, the user session, the event queue and the event type.
   --  ------------------------------
   overriding
   procedure Enqueue (Into  : in out Persistent_Queue;
                      Event : in AWA.Events.Module_Event'Class) is
      use Ada.Strings.Unbounded;
      use Util.Streams;
      procedure Add_Property (Name, Value : in Util.Properties.Value);

      Ctx   : constant Services.Contexts.Service_Context_Access := AWA.Services.Contexts.Current;
      DB    : ADO.Sessions.Master_Session := AWA.Services.Contexts.Get_Master_Session (Ctx);
      Msg   : AWA.Events.Models.Message_Ref;

      Has_Param : Boolean := False;
      Output    : Util.Serialize.IO.XML.Output_Stream;

      procedure Add_Property (Name, Value : in Util.Properties.Value) is
      begin
         if not Has_Param then
            Output.Initialize (Size => 10000);
            Has_Param := True;
            Output.Start_Entity (Name => "params");
         end if;
         Output.Start_Entity (Name => "param");
         Output.Write_Attribute (Name  => "name",
                                 Value => Util.Beans.Objects.To_Object (Name));
         Output.Write_String (Value => To_String (Value));
         Output.End_Entity (Name => "param");
      end Add_Property;

   begin
      Ctx.Start;
      Msg.Set_Queue (Into.Queue);
      Msg.Set_User (Ctx.Get_User);
      Msg.Set_Session (Ctx.Get_User_Session);
      Msg.Set_Create_Date (Event.Get_Time);
      Msg.Set_Status (AWA.Events.Models.QUEUED);

      --  Collect the event parameters in a string and format the result in XML.
      --  If there is no parameter, avoid the overhead of allocating and formatting this.
      Event.Props.Iterate (Process => Add_Property'Access);
      if Has_Param then
         Output.End_Entity (Name => "params");
         Msg.Set_Parameters (Util.Streams.Texts.To_String (Buffered.Buffered_Stream (Output)));
      end if;

--        Msg.Set_Message_Type
      Msg.Save (DB);
      Ctx.Commit;

      Log.Info ("Event {0} created", ADO.Identifier'Image (Msg.Get_Id));
   end Enqueue;

   overriding
   procedure Dequeue (From : in out Persistent_Queue;
                      Process : access procedure (Event : in Module_Event'Class)) is
      Ctx      : constant AWA.Services.Contexts.Service_Context_Access := AWA.Services.Contexts.Current;
      DB       : ADO.Sessions.Master_Session := AWA.Services.Contexts.Get_Master_Session (Ctx);
      Messages : Models.Message_Vector;
      Query    : ADO.Queries.Context;
      Task_Id  : Integer := 0;

      --  Prepare the message by indicating in the database it is going to be processed
      --  by the given server and task.
      procedure Prepare_Message (Msg : in out Models.Message_Ref) is
      begin
         Msg.Set_Status (Models.PROCESSING);
         Msg.Set_Server_Id (From.Server_Id);
         Msg.Set_Task_Id (Task_Id);
         Msg.Set_Processing_Date (ADO.Nullable_Time '(Is_Null => False,
                                                      Value   => Ada.Calendar.Clock));
         Msg.Save (DB);
      end Prepare_Message;

      --  Dispatch the event.
      procedure Dispatch_Message (Msg : in out Models.Message_Ref) is
         User    : constant AWA.Users.Models.User_Ref'Class := Msg.Get_User;
         Session : constant AWA.Users.Models.Session_Ref'Class := Msg.Get_Session;
         Event   : Module_Event;
      begin

         Process (Event);
      end Dispatch_Message;

      --  Finish processing the message by marking it as being processed.
      procedure Finish_Message (Msg : in out Models.Message_Ref) is
      begin
         Ctx.Start;
         Msg.Set_Status (Models.PROCESSED);
         Msg.Set_Finish_Date (ADO.Nullable_Time '(Is_Null => False,
                                                  Value   => Ada.Calendar.Clock));
         Msg.Save (DB);
         Ctx.Commit;
      end Finish_Message;

      Count : Natural;
   begin
      Ctx.Start;
      Query.Set_Query (Models.Query_Queue_Pending_Message);
      Query.Bind_Param ("queue", From.Queue.Get_Id);
      Query.Bind_Param ("max", From.Max_Batch);
      Models.List (Messages, DB, Query);
      Count := Natural (Messages.Length);

      --  Prepare the event messages by marking them in the database.
      --  This makes sure that no other server or task (if any), will process them.
      if Count > 0 then
         for I in 1 .. Count loop
            Messages.Update_Element (Index   => I,
                                     Process => Prepare_Message'Access);
         end loop;
      end if;
      Ctx.Commit;

      if Count = 0 then
         return;
      end if;

      --  Dispatch each event.
      for I in 1 .. Count loop
         Messages.Update_Element (Index   => I,
                                  Process => Dispatch_Message'Access);
      end loop;

      --  After having dispatched the events, mark them as dispatched in the queue.
      Ctx.Start;
      for I in 1 .. Count loop
         Messages.Update_Element (Index   => I,
                                  Process => Finish_Message'Access);
      end loop;
      Ctx.Commit;
   end Dequeue;

   --  ------------------------------
   --  Create the queue associated with the given name and configure it by using
   --  the configuration properties.
   --  ------------------------------
   function Create_Queue (Name    : in String;
                          Props   : in EL.Beans.Param_Vectors.Vector;
                          Context : in EL.Contexts.ELContext'Class) return Queue_Access is
      package AC renames AWA.Services.Contexts;

      Ctx     : constant AC.Service_Context_Access := AC.Current;
      Session : ADO.Sessions.Master_Session := AC.Get_Master_Session (Ctx);
      Queue   : AWA.Events.Models.Queue_Ref;
      Query   : ADO.SQL.Query;
      Found   : Boolean;
   begin
      Session.Begin_Transaction;
      --  Find the queue instance which matches the name.
      Query.Set_Filter ("o.name = ?");
      Query.Add_Param (Name);
      Queue.Find (Session => Session,
                  Query   => Query,
                  Found   => Found);

      --  But create the queue instance if it does not exist.
      if not Found then
         Queue.Set_Name (Name);
         Queue.Save (Session);
      end if;
      Session.Commit;
      declare
         Result : constant Persistent_Queue_Access
           := new Persistent_Queue '(Name_Length  => Name'Length,
                                     Name         => Name,
                                     Queue        => Queue,
                                     others       => <>);
      begin
         return Result.all'Access;
      end;
   end Create_Queue;

end AWA.Events.Queues.Persistents;
