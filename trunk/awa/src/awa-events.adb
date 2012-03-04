-----------------------------------------------------------------------
--  awa-events -- AWA Events
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

with Ada.Strings.Unbounded;
with Ada.Unchecked_Deallocation;

with Util.Log.Loggers;

with EL.Contexts;
with EL.Contexts.Default;
with EL.Variables;
with EL.Variables.Default;

with ASF.Beans;
with ASF.Requests;
with ASF.Sessions;

with ADO.SQL;

--  with AWA.Events.Action_Method;
with AWA.Applications;
package body AWA.Events is

   use Ada.Strings.Unbounded;
   use Util.Log;

   Log : constant Loggers.Logger := Loggers.Create ("AWA.Events");

   type Event_Name_Pair is record
      Name  : Util.Strings.Name_Access := null;
      Index : Event_Index              := 0;
   end record;

   type Event_Name_Pair_Array is array (Event_Index range <>) of Event_Name_Pair;
   type Event_Name_Pair_Array_Access is access all Event_Name_Pair_Array;

   --  A static list of event names.  This array is created during the elaboration
   --  of event definitions.  It is sorted on event names.
   Events     : Event_Name_Pair_Array_Access;

   --  ------------------------------
   --  Register an event by its name and allocate a unique runtime event index.
   --  ------------------------------
   procedure Add_Event (Name  : in Util.Strings.Name_Access;
                        Index : out Event_Index) is
      Left    : Event_Index := 1;
      Right   : Event_Index := Last_Event;
   begin
      --  Check the storage and allocate it if necessary.
      if Events = null then
         Events := new Event_Name_Pair_Array (1 .. 10);
      elsif Events'Last = Last_Event then
         declare
            N : Event_Name_Pair_Array_Access := new Event_Name_Pair_Array (1 .. Last_Event + 10);
         begin
            N (Events'Range) := Events.all;
         end;
      end if;

      --  Find the event position within the sorted table.
      --  If an event is already registered, bark and re-use the previous event identifier.
      while Left <= Right loop
         declare
            Pos  : constant Event_Index := (Left + Right + 1) / 2;
            Item : constant Util.Strings.Name_Access := Events (Pos).Name;
         begin
            if Name.all = Item.all then
               Log.Error ("Event {0} is already registered.", Name.all);
               Index := Events (Pos).Index;
               return;
            elsif Name.all < Item.all then
               Right := Pos - 1;
            else
               Left := Pos + 1;
            end if;
         end;
      end loop;

      --  Insert the new event at the good position now.
      if Left = 0 then
         Left := Left + 1;
      end if;
      if Left <= Last_Event then
         Events (Left + 1 .. Last_Event + 1) := Events (Left .. Last_Event);

      end if;
      Last_Event := Last_Event + 1;
      Events (Left).Name := Name;
      Events (Left).Index := Last_Event;
      Index := Last_Event;
--        for I in 1 .. Last_Event loop
--           Log.Info ("{0} -> {1}", Event_Index'Image (I), Events (I).Name.all);
--        end loop;
      Log.Debug ("Event {0} index is {1}", Name.all, Event_Index'Image (Index));
   end Add_Event;

   --  ------------------------------
   --  Event kind definition
   --  ------------------------------
   package body Definition is
      Event : Event_Index;

      Event_Name : aliased constant String := Name;

      function Kind return Event_Index is
      begin
         return Event;
      end Kind;

   begin
      Add_Event (Event_Name'Access, Event);
   end Definition;

   --  ------------------------------
   --  Find the event runtime index given the event name.
   --  Raises Not_Found exception if the event name is not recognized.
   --  ------------------------------
   function Find_Event_Index (Name : in String) return Event_Index is
      Left    : Event_Index := 1;
      Right   : Event_Index := Last_Event;
   begin
      while Left <= Right loop
         declare
            Pos  : constant Event_Index := (Left + Right + 1) / 2;
            Item : constant Util.Strings.Name_Access := Events (Pos).Name;
         begin
            if Name = Item.all then
               return Events (Pos).Index;
            elsif Name < Item.all then
               Right := Pos - 1;
            else
               Left := Pos + 1;
            end if;
         end;
      end loop;
      Log.Error ("Event {0} not recognized.", Name);
      raise Not_Found with "Event " & Name & " not found";
   end Find_Event_Index;

   --  ------------------------------
   --  Set the event type which identifies the event.
   --  ------------------------------
   procedure Set_Event_Kind (Event : in out Module_Event;
                             Kind  : in Event_Index) is
   begin
      Event.Kind := Kind;
   end Set_Event_Kind;

   --  ------------------------------
   --  Get the event type which identifies the event.
   --  ------------------------------
   function Get_Event_Kind (Event : in Module_Event) return Event_Index is
   begin
      return Event.Kind;
   end Get_Event_Kind;

   --  ------------------------------
   --  Set a parameter on the message.
   --  ------------------------------
   procedure Set_Parameter (Event  : in out Module_Event;
                            Name   : in String;
                            Value  : in String) is
   begin
      Event.Props.Set (Name, Value);
   end Set_Parameter;

   --  ------------------------------
   --  Get the parameter with the given name.
   --  ------------------------------
   function Get_Parameter (Event : in Module_Event;
                           Name  : in String) return String is
   begin
      return Event.Props.Get (Name, "");
   end Get_Parameter;

   --  ------------------------------
   --  Get the value that corresponds to the parameter with the given name.
   --  ------------------------------
   function Get_Value (Event : in Module_Event;
                       Name  : in String) return Util.Beans.Objects.Object is
   begin
      if Event.Props.Exists (Name) then
         return Util.Beans.Objects.To_Object (Event.Get_Parameter (Name));
      else
         return Util.Beans.Objects.Null_Object;
      end if;
   end Get_Value;

   --  ------------------------------
   --  Get the event type name.
   --  ------------------------------
   function Get_Event_Type_Name (Index : in Event_Index) return Util.Strings.Name_Access is
   begin
      return Events (Index).Name;
   end Get_Event_Type_Name;

end AWA.Events;
