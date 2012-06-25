-----------------------------------------------------------------------
--  awa-jobs -- AWA Jobs
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
with Util.Serialize.Tools;
with Util.Log.Loggers;

with Ada.Tags;
with Ada.Calendar;
with Ada.Unchecked_Deallocation;

with ADO.Sessions.Entities;
with ADO.Statements;

with AWA.Users.Models;
with AWA.Events.Models;
with AWA.Services.Contexts;
with AWA.Jobs.Modules;
with AWA.Applications;
with AWA.Events.Services;
with AWA.Modules;
package body AWA.Jobs.Services is

   package ASC renames AWA.Services.Contexts;

   Log : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("AWA.Jobs.Services");

   --  ------------------------------
   --  Get the job status.
   --  ------------------------------
   function Get_Job_Status (Id : in ADO.Identifier) return AWA.Jobs.Models.Job_Status_Type is
      Ctx  : constant ASC.Service_Context_Access := ASC.Current;
      DB   : constant ADO.Sessions.Session := ASC.Get_Session (Ctx);
      Stmt : ADO.Statements.Query_Statement
        := DB.Create_Statement ("select status from awa_jobs where id = ?");
   begin
      Stmt.Add_Param (Id);
      Stmt.Execute;
      return Models.Job_Status_Type'Val (Stmt.Get_Result_Integer);
   end Get_Job_Status;

   --  ------------------------------
   --  Set the job parameter identified by the <b>Name</b> to the value given in <b>Value</b>.
   --  ------------------------------
   procedure Set_Parameter (Job   : in out Abstract_Job_Type;
                            Name  : in String;
                            Value : in String) is
   begin
      Job.Set_Parameter (Name, Util.Beans.Objects.To_Object (Value));
   end Set_Parameter;

   --  ------------------------------
   --  Set the job parameter identified by the <b>Name</b> to the value given in <b>Value</b>.
   --  ------------------------------
   procedure Set_Parameter (Job   : in out Abstract_Job_Type;
                            Name  : in String;
                            Value : in Integer) is
   begin
      Job.Set_Parameter (Name, Util.Beans.Objects.To_Object (Value));
   end Set_Parameter;

   --  ------------------------------
   --  Set the job parameter identified by the <b>Name</b> to the value given in <b>Value</b>.
   --  The value object can hold any kind of basic value type (integer, enum, date, strings).
   --  If the value represents a bean, the <tt>Invalid_Value</tt> exception is raised.
   --  ------------------------------
   procedure Set_Parameter (Job   : in out Abstract_Job_Type;
                            Name  : in String;
                            Value : in Util.Beans.Objects.Object) is
   begin
      Job.Props.Include (Name, Value);
      Job.Props_Modified := True;
   end Set_Parameter;

   --  ------------------------------
   --  Get the job parameter identified by the <b>Name</b> and convert the value into a string.
   --  ------------------------------
   function Get_Parameter (Job  : in Abstract_Job_Type;
                           Name : in String) return String is
      Value : constant Util.Beans.Objects.Object := Job.Get_Parameter (Name);
   begin
      return Util.Beans.Objects.To_String (Value);
   end Get_Parameter;

   --  ------------------------------
   --  Get the job parameter identified by the <b>Name</b> and convert the value as an integer.
   --  If the parameter is not defined, return the default value passed in <b>Default</b>.
   --  ------------------------------
   function Get_Parameter (Job     : in Abstract_Job_Type;
                           Name    : in String;
                           Default : in Integer) return Integer is
      Pos : constant Util.Beans.Objects.Maps.Cursor := Job.Props.Find (Name);
   begin
      if Util.Beans.Objects.Maps.Has_Element (Pos) then
         declare
            Value : constant Util.Beans.Objects.Object := Util.Beans.Objects.Maps.Element (Pos);
         begin
            if Util.Beans.Objects.Is_Null (Value) then
               return Default;
            else
               return Util.Beans.Objects.To_Integer (Value);
            end if;
         end;
      else
         return Default;
      end if;
   end Get_Parameter;

   --  ------------------------------
   --  Get the job parameter identified by the <b>Name</b> and return it as a typed object.
   --  ------------------------------
   function Get_Parameter (Job  : in Abstract_Job_Type;
                           Name : in String) return Util.Beans.Objects.Object is
   begin
      return Job.Props.Element (Name);
   end Get_Parameter;

   --  ------------------------------
   --  Get the job status.
   --  ------------------------------
   function Get_Status (Job : in Abstract_Job_Type) return AWA.Jobs.Models.Job_Status_Type is
   begin
      return Job.Job.Get_Status;
   end Get_Status;

   --  ------------------------------
   --  Get the job identifier once the job was scheduled.  The job identifier allows to
   --  retrieve the job and check its execution and completion status later on.
   --  ------------------------------
   function Get_Identifier (Job : in Abstract_Job_Type) return ADO.Identifier is
   begin
      return Job.Job.Get_Id;
   end Get_Identifier;

   --  ------------------------------
   --  Set the job status.
   --  When the job is terminated, it is closed and the job parameters or results cannot be
   --  changed.
   --  ------------------------------
   procedure Set_Status (Job    : in out Abstract_Job_Type;
                         Status : in AWA.Jobs.Models.Job_Status_Type) is
   begin
      case Job.Job.Get_Status is
         when AWA.Jobs.Models.CANCELED | Models.FAILED | Models.TERMINATED =>
            raise Closed_Error;

         when Models.SCHEDULED | Models.RUNNING =>
            Job.Job.Set_Status (Status);

      end case;
   end Set_Status;

   --  ------------------------------
   --  Save the job information in the database.  Use the database session defined by <b>DB</b>
   --  to save the job.
   --  ------------------------------
   procedure Save (Job : in out Abstract_Job_Type;
                   DB  : in out ADO.Sessions.Master_Session'Class) is
   begin
      if Job.Results_Modified then
         Job.Job.Set_Results (Util.Serialize.Tools.To_JSON (Job.Results));
         Job.Results_Modified := False;
      end if;
      Job.Job.Save (DB);
   end Save;

   --  Schedule the job.
   procedure Schedule (Job        : in out Abstract_Job_Type;
                       Definition : in Job_Factory'Class) is

      procedure Set_Event (Manager : in out AWA.Events.Services.Event_Manager);

      Ctx : constant ASC.Service_Context_Access := ASC.Current;
      DB   : ADO.Sessions.Master_Session := ASC.Get_Master_Session (Ctx);
      Msg  : AWA.Events.Models.Message_Ref;
      User : constant AWA.Users.Models.User_Ref := Ctx.Get_User;
      Sess : constant AWA.Users.Models.Session_Ref := Ctx.Get_User_Session;
      App  : constant AWA.Applications.Application_Access := Ctx.Get_Application;

      procedure Set_Event (Manager : in out AWA.Events.Services.Event_Manager) is
      begin
         Manager.Set_Message_Type (Msg, Job_Create_Event.Kind);
         Manager.Set_Event_Queue (Msg, "job-queue");
      end Set_Event;

   begin
      if Job.Job.Is_Inserted then
         Log.Error ("Job is already scheduled");
         raise Schedule_Error with "The job is already scheduled.";
      end if;
      AWA.Jobs.Modules.Create_Event (Msg);
      Job.Job.Set_Create_Date (Msg.Get_Create_Date);

      DB.Begin_Transaction;
      Job.Job.Set_Name (Definition.Get_Name);
      Job.Job.Set_User (User);
      Job.Job.Set_Session (Sess);
      Job.Save (DB);

      --  Create the event
      Msg.Set_Parameters (Util.Serialize.Tools.To_JSON (Job.Props));
      App.Do_Event_Manager (Process => Set_Event'Access);
      Msg.Set_User (User);
      Msg.Set_Session (Sess);
      Msg.Set_Entity_Id (Job.Job.Get_Id);
      Msg.Set_Entity_Type (ADO.Sessions.Entities.Find_Entity_Type (Session => DB,
                                                                   Object  => Job.Job.Get_Key));
      Msg.Save (DB);

      Job.Job.Set_Event (Msg);
      Job.Job.Save (DB);
      DB.Commit;
   end Schedule;

   --  ------------------------------
   --  Execute the job and save the job information in the database.
   --  ------------------------------
   procedure Execute (Job : in out Abstract_Job_Type'Class;
                      DB  : in out ADO.Sessions.Master_Session'Class) is
      use type AWA.Jobs.Models.Job_Status_Type;
   begin
      --  Execute the job with an exception guard.
      begin
         Job.Execute;

      exception
         when E : others =>
            Log.Error ("Exception when executing job {0}", Job.Job.Get_Name);
            Log.Error ("Exception:", E, True);
            Job.Job.Set_Status (Models.FAILED);
      end;

      --  If the job did not set a completion status, mark it as terminated.
      if Job.Job.Get_Status = Models.SCHEDULED or Job.Job.Get_Status = Models.RUNNING then
         Job.Job.Set_Status (Models.TERMINATED);
      end if;

      --  And save the job.
      DB.Begin_Transaction;
      Job.Job.Set_Finish_Date (ADO.Nullable_Time '(Is_Null => False,
                                                   Value   => Ada.Calendar.Clock));
      Job.Save (DB);
      DB.Commit;
   end Execute;

   --  ------------------------------
   --  Execute the job associated with the given event.
   --  ------------------------------
   procedure Execute (Event : in AWA.Events.Module_Event'Class) is
      use AWA.Jobs.Modules;
      use type AWA.Modules.Module_Access;

      procedure Free is
         new Ada.Unchecked_Deallocation (Object => Abstract_Job_Type'Class,
                                         Name   => Abstract_Job_Access);

      Ctx    : constant ASC.Service_Context_Access := ASC.Current;
      App    : constant AWA.Applications.Application_Access := Ctx.Get_Application;
      Module : constant AWA.Modules.Module_Access := App.Find_Module (AWA.Jobs.Modules.NAME);
      DB     : ADO.Sessions.Master_Session := ASC.Get_Master_Session (Ctx);
      Job    : AWA.Jobs.Models.Job_Ref;
   begin
      if Module = null then
         Log.Warn ("There is no Job module to execute a job");
         raise Execute_Error;
      end if;
      if not (Module.all in AWA.Jobs.Modules.Job_Module'Class) then
         Log.Warn ("The 'job' module is not a valid module for job execution");
         raise Execute_Error;
      end if;

      DB.Begin_Transaction;
      Job.Load (Session => DB,
                Id      => Event.Get_Entity_Identifier);
      Job.Set_Start_Date (ADO.Nullable_Time '(Is_Null => False, Value => Ada.Calendar.Clock));
      Job.Set_Status (AWA.Jobs.Models.RUNNING);
      Job.Save (Session => DB);
      DB.Commit;

      declare
         Name : constant String := Job.Get_Name;
      begin
         Log.Info ("Restoring job '{0}'", Name);
         declare
            Plugin  : constant Job_Module_Access := Job_Module'Class (Module.all)'Access;
            Factory : constant Job_Factory_Access := Plugin.Find_Factory (Name);
            Work    : AWA.Jobs.Services.Abstract_Job_Access := null;
         begin
            if Factory /= null then
               Work := Factory.Create;
               Work.Job := Job;
               Event.Copy (Work.Props);
               Work.Execute (DB);
               Free (Work);
            else
               Log.Error ("There is no factory to execute job '{0}'", Name);
               Job.Set_Status (AWA.Jobs.Models.FAILED);
               Job.Set_Finish_Date (ADO.Nullable_Time '(Is_Null => False,
                                                        Value   => Ada.Calendar.Clock));
               DB.Begin_Transaction;
               Job.Save (Session => DB);
               DB.Commit;
            end if;
         end;
      end;
   end Execute;

   function Get_Name (Factory : in Job_Factory'Class) return String is
   begin
      return Ada.Tags.Expanded_Name (Factory'Tag);
   end Get_Name;

   procedure Set_Work (Job  : in out Job_Type;
                       Work : in Work_Factory'Class) is
   begin
      Job.Work := Work.Work;
      Job.Job.Set_Name (Work.Get_Name);
   end Set_Work;

   procedure Execute (Job : in out Job_Type) is
   begin
      Job.Work (Job);
   end Execute;

   overriding
   function Create (Factory : in Work_Factory) return Abstract_Job_Access is
   begin
      return new Job_Type '(Ada.Finalization.Limited_Controlled with
                              Work => Factory.Work,
                              others => <>);
   end Create;

   --  ------------------------------
   --  Job Declaration
   --  ------------------------------
   --  The <tt>Definition</tt> package must be instantiated with a given job type to
   --  register the new job definition.
   package body Definition is

      function Create (Factory : in Job_Type_Factory) return Abstract_Job_Access is
         pragma Unreferenced (Factory);
      begin
         return new T;
      end Create;

   end Definition;

end AWA.Jobs.Services;
