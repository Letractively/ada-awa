-----------------------------------------------------------------------
--  AWA.Jobs.Models -- AWA.Jobs.Models
-----------------------------------------------------------------------
--  File generated by ada-gen DO NOT MODIFY
--  Template used: templates/model/package-body.xhtml
--  Ada Generator: https://ada-gen.googlecode.com/svn/trunk Revision 1017
-----------------------------------------------------------------------
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
with Ada.Unchecked_Deallocation;
with Util.Beans.Objects.Time;
package body AWA.Jobs.Models is

   use type ADO.Objects.Object_Record_Access;
   use type ADO.Objects.Object_Ref;
   use type ADO.Objects.Object_Record;

   function Job_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_STRING,
                                       Of_Class => JOB_TABLE'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Job_Key;

   function Job_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_STRING,
                                       Of_Class => JOB_TABLE'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Job_Key;

   function "=" (Left, Right : Job_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out Job_Ref'Class;
                        Impl   : out Job_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := Job_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   procedure Allocate (Object : in out Job_Ref) is
      Impl : Job_Access;
   begin
      Impl := new Job_Impl;
      Impl.Status := Job_Status_Type'First;
      Impl.Start_Date.Is_Null := True;
      Impl.Create_Date := ADO.DEFAULT_TIME;
      Impl.Finish_Date.Is_Null := True;
      Impl.Progress := 0;
      Impl.Server_Id := 0;
      Impl.Task_Id := 0;
      Impl.Version := 0;
      Impl.Priority := 0;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: Job
   -- ----------------------------------------

   procedure Set_Id (Object : in out Job_Ref;
                     Value  : in ADO.Identifier) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 1, Value);
   end Set_Id;

   function Get_Id (Object : in Job_Ref)
                  return ADO.Identifier is
      Impl : constant Job_Access := Job_Impl (Object.Get_Object.all)'Access;
   begin
      return Impl.Get_Key_Value;
   end Get_Id;


   procedure Set_Status (Object : in out Job_Ref;
                         Value  : in Job_Status_Type) is
      procedure Set_Field_Enum is
         new ADO.Objects.Set_Field_Operation (Job_Status_Type);
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      Set_Field_Enum (Impl.all, 2, Impl.Status, Value);
   end Set_Status;

   function Get_Status (Object : in Job_Ref)
                  return Job_Status_Type is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Status;
   end Get_Status;


   procedure Set_Name (Object : in out Job_Ref;
                        Value : in String) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_String (Impl.all, 3, Impl.Name, Value);
   end Set_Name;

   procedure Set_Name (Object : in out Job_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Unbounded_String (Impl.all, 3, Impl.Name, Value);
   end Set_Name;

   function Get_Name (Object : in Job_Ref)
                 return String is
   begin
      return Ada.Strings.Unbounded.To_String (Object.Get_Name);
   end Get_Name;
   function Get_Name (Object : in Job_Ref)
                  return Ada.Strings.Unbounded.Unbounded_String is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Name;
   end Get_Name;


   procedure Set_Start_Date (Object : in out Job_Ref;
                             Value  : in ADO.Nullable_Time) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Time (Impl.all, 4, Impl.Start_Date, Value);
   end Set_Start_Date;

   function Get_Start_Date (Object : in Job_Ref)
                  return ADO.Nullable_Time is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Start_Date;
   end Get_Start_Date;


   procedure Set_Create_Date (Object : in out Job_Ref;
                              Value  : in Ada.Calendar.Time) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Time (Impl.all, 5, Impl.Create_Date, Value);
   end Set_Create_Date;

   function Get_Create_Date (Object : in Job_Ref)
                  return Ada.Calendar.Time is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Create_Date;
   end Get_Create_Date;


   procedure Set_Finish_Date (Object : in out Job_Ref;
                              Value  : in ADO.Nullable_Time) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Time (Impl.all, 6, Impl.Finish_Date, Value);
   end Set_Finish_Date;

   function Get_Finish_Date (Object : in Job_Ref)
                  return ADO.Nullable_Time is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Finish_Date;
   end Get_Finish_Date;


   procedure Set_Progress (Object : in out Job_Ref;
                           Value  : in Integer) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 7, Impl.Progress, Value);
      ADO.Objects.Set_Field_Integer (Impl.all, 7, Impl.Progress, Value);
   end Set_Progress;

   function Get_Progress (Object : in Job_Ref)
                  return Integer is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Progress;
   end Get_Progress;


   procedure Set_Parameters (Object : in out Job_Ref;
                              Value : in String) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_String (Impl.all, 8, Impl.Parameters, Value);
   end Set_Parameters;

   procedure Set_Parameters (Object : in out Job_Ref;
                             Value  : in Ada.Strings.Unbounded.Unbounded_String) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Unbounded_String (Impl.all, 8, Impl.Parameters, Value);
   end Set_Parameters;

   function Get_Parameters (Object : in Job_Ref)
                 return String is
   begin
      return Ada.Strings.Unbounded.To_String (Object.Get_Parameters);
   end Get_Parameters;
   function Get_Parameters (Object : in Job_Ref)
                  return Ada.Strings.Unbounded.Unbounded_String is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Parameters;
   end Get_Parameters;


   procedure Set_Results (Object : in out Job_Ref;
                           Value : in String) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_String (Impl.all, 9, Impl.Results, Value);
   end Set_Results;

   procedure Set_Results (Object : in out Job_Ref;
                          Value  : in Ada.Strings.Unbounded.Unbounded_String) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Unbounded_String (Impl.all, 9, Impl.Results, Value);
   end Set_Results;

   function Get_Results (Object : in Job_Ref)
                 return String is
   begin
      return Ada.Strings.Unbounded.To_String (Object.Get_Results);
   end Get_Results;
   function Get_Results (Object : in Job_Ref)
                  return Ada.Strings.Unbounded.Unbounded_String is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Results;
   end Get_Results;


   procedure Set_Server_Id (Object : in out Job_Ref;
                            Value  : in Integer) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 10, Impl.Server_Id, Value);
      ADO.Objects.Set_Field_Integer (Impl.all, 10, Impl.Server_Id, Value);
   end Set_Server_Id;

   function Get_Server_Id (Object : in Job_Ref)
                  return Integer is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Server_Id;
   end Get_Server_Id;


   procedure Set_Task_Id (Object : in out Job_Ref;
                          Value  : in Integer) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 11, Impl.Task_Id, Value);
      ADO.Objects.Set_Field_Integer (Impl.all, 11, Impl.Task_Id, Value);
   end Set_Task_Id;

   function Get_Task_Id (Object : in Job_Ref)
                  return Integer is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Task_Id;
   end Get_Task_Id;


   function Get_Version (Object : in Job_Ref)
                  return Integer is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Version;
   end Get_Version;


   procedure Set_Priority (Object : in out Job_Ref;
                           Value  : in Integer) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 13, Impl.Priority, Value);
      ADO.Objects.Set_Field_Integer (Impl.all, 13, Impl.Priority, Value);
   end Set_Priority;

   function Get_Priority (Object : in Job_Ref)
                  return Integer is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Priority;
   end Get_Priority;


   procedure Set_Event (Object : in out Job_Ref;
                        Value  : in AWA.Events.Models.Message_Ref'Class) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Object (Impl.all, 14, Impl.Event, Value);
   end Set_Event;

   function Get_Event (Object : in Job_Ref)
                  return AWA.Events.Models.Message_Ref'Class is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Event;
   end Get_Event;


   procedure Set_User (Object : in out Job_Ref;
                       Value  : in AWA.Users.Models.User_Ref'Class) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Object (Impl.all, 15, Impl.User, Value);
   end Set_User;

   function Get_User (Object : in Job_Ref)
                  return AWA.Users.Models.User_Ref'Class is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.User;
   end Get_User;


   procedure Set_Job_Queue (Object : in out Job_Ref;
                            Value  : in AWA.Events.Models.Queue_Ref'Class) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Object (Impl.all, 16, Impl.Job_Queue, Value);
   end Set_Job_Queue;

   function Get_Job_Queue (Object : in Job_Ref)
                  return AWA.Events.Models.Queue_Ref'Class is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Job_Queue;
   end Get_Job_Queue;


   procedure Set_Session (Object : in out Job_Ref;
                          Value  : in AWA.Users.Models.Session_Ref'Class) is
      Impl : Job_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Object (Impl.all, 17, Impl.Session, Value);
   end Set_Session;

   function Get_Session (Object : in Job_Ref)
                  return AWA.Users.Models.Session_Ref'Class is
      Impl : constant Job_Access := Job_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Session;
   end Get_Session;

   --  Copy of the object.
   procedure Copy (Object : in Job_Ref;
                   Into   : in out Job_Ref) is
      Result : Job_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant Job_Access
              := Job_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant Job_Access
              := new Job_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.Status := Impl.Status;
            Copy.Name := Impl.Name;
            Copy.Start_Date := Impl.Start_Date;
            Copy.Create_Date := Impl.Create_Date;
            Copy.Finish_Date := Impl.Finish_Date;
            Copy.Progress := Impl.Progress;
            Copy.Parameters := Impl.Parameters;
            Copy.Results := Impl.Results;
            Copy.Server_Id := Impl.Server_Id;
            Copy.Task_Id := Impl.Task_Id;
            Copy.Version := Impl.Version;
            Copy.Priority := Impl.Priority;
            Copy.Event := Impl.Event;
            Copy.User := Impl.User;
            Copy.Job_Queue := Impl.Job_Queue;
            Copy.Session := Impl.Session;
         end;
      end if;
      Into := Result;
   end Copy;

   procedure Find (Object  : in out Job_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant Job_Access := new Job_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out Job_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier) is
      Impl  : constant Job_Access := new Job_Impl;
      Found : Boolean;
      Query : ADO.SQL.Query;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("id = ?");
      Impl.Find (Session, Query, Found);
      if not Found then
         Destroy (Impl);
         raise ADO.Objects.NOT_FOUND;
      end if;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Load;

   procedure Load (Object  : in out Job_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean) is
      Impl  : constant Job_Access := new Job_Impl;
      Query : ADO.SQL.Query;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("id = ?");
      Impl.Find (Session, Query, Found);
      if not Found then
         Destroy (Impl);
      else
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      end if;
   end Load;

   procedure Save (Object  : in out Job_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new Job_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   procedure Delete (Object  : in out Job_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : constant ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl /= null then
         Impl.Delete (Session);
      end if;
   end Delete;

   --  --------------------
   --  Free the object
   --  --------------------
   procedure Destroy (Object : access Job_Impl) is
      type Job_Impl_Ptr is access all Job_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (Job_Impl, Job_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : Job_Impl_Ptr := Job_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   procedure Find (Object  : in out Job_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, JOB_TABLE'Access);
   begin
      Stmt.Execute;
      if Stmt.Has_Elements then
         Object.Load (Stmt, Session);
         Stmt.Next;
         Found := not Stmt.Has_Elements;
      else
         Found := False;
      end if;
   end Find;

   overriding
   procedure Load (Object  : in out Job_Impl;
                   Session : in out ADO.Sessions.Session'Class) is
      Found : Boolean;
      Query : ADO.SQL.Query;
      Id    : constant ADO.Identifier := Object.Get_Key_Value;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("id = ?");
      Object.Find (Session, Query, Found);
      if not Found then
         raise ADO.Objects.NOT_FOUND;
      end if;
   end Load;

   procedure Save (Object  : in out Job_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (JOB_TABLE'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_1_NAME, --  id
                          Value => Object.Get_Key);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (2) then
         Stmt.Save_Field (Name  => COL_1_1_NAME, --  status
                          Value => Integer (Job_Status_Type'Pos (Object.Status)));
         Object.Clear_Modified (2);
      end if;
      if Object.Is_Modified (3) then
         Stmt.Save_Field (Name  => COL_2_1_NAME, --  name
                          Value => Object.Name);
         Object.Clear_Modified (3);
      end if;
      if Object.Is_Modified (4) then
         Stmt.Save_Field (Name  => COL_3_1_NAME, --  start_date
                          Value => Object.Start_Date);
         Object.Clear_Modified (4);
      end if;
      if Object.Is_Modified (5) then
         Stmt.Save_Field (Name  => COL_4_1_NAME, --  create_date
                          Value => Object.Create_Date);
         Object.Clear_Modified (5);
      end if;
      if Object.Is_Modified (6) then
         Stmt.Save_Field (Name  => COL_5_1_NAME, --  finish_date
                          Value => Object.Finish_Date);
         Object.Clear_Modified (6);
      end if;
      if Object.Is_Modified (7) then
         Stmt.Save_Field (Name  => COL_6_1_NAME, --  progress
                          Value => Object.Progress);
         Object.Clear_Modified (7);
      end if;
      if Object.Is_Modified (8) then
         Stmt.Save_Field (Name  => COL_7_1_NAME, --  parameters
                          Value => Object.Parameters);
         Object.Clear_Modified (8);
      end if;
      if Object.Is_Modified (9) then
         Stmt.Save_Field (Name  => COL_8_1_NAME, --  results
                          Value => Object.Results);
         Object.Clear_Modified (9);
      end if;
      if Object.Is_Modified (10) then
         Stmt.Save_Field (Name  => COL_9_1_NAME, --  server_id
                          Value => Object.Server_Id);
         Object.Clear_Modified (10);
      end if;
      if Object.Is_Modified (11) then
         Stmt.Save_Field (Name  => COL_10_1_NAME, --  task_id
                          Value => Object.Task_Id);
         Object.Clear_Modified (11);
      end if;
      if Object.Is_Modified (13) then
         Stmt.Save_Field (Name  => COL_12_1_NAME, --  priority
                          Value => Object.Priority);
         Object.Clear_Modified (13);
      end if;
      if Object.Is_Modified (14) then
         Stmt.Save_Field (Name  => COL_13_1_NAME, --  event_id
                          Value => Object.Event);
         Object.Clear_Modified (14);
      end if;
      if Object.Is_Modified (15) then
         Stmt.Save_Field (Name  => COL_14_1_NAME, --  user_id
                          Value => Object.User);
         Object.Clear_Modified (15);
      end if;
      if Object.Is_Modified (16) then
         Stmt.Save_Field (Name  => COL_15_1_NAME, --  job_queue_id
                          Value => Object.Job_Queue);
         Object.Clear_Modified (16);
      end if;
      if Object.Is_Modified (17) then
         Stmt.Save_Field (Name  => COL_16_1_NAME, --  session_id
                          Value => Object.Session);
         Object.Clear_Modified (17);
      end if;
      if Stmt.Has_Save_Fields then
         Object.Version := Object.Version + 1;
         Stmt.Save_Field (Name  => "version",
                          Value => Object.Version);
         Stmt.Set_Filter (Filter => "id = ? and version = ?");
         Stmt.Add_Param (Value => Object.Get_Key);
         Stmt.Add_Param (Value => Object.Version - 1);
         declare
            Result : Integer;
         begin
            Stmt.Execute (Result);
            if Result /= 1 then
               if Result /= 0 then
                  raise ADO.Objects.UPDATE_ERROR;
               else
                  raise ADO.Objects.LAZY_LOCK;
               end if;
            end if;
         end;
      end if;
   end Save;

   procedure Create (Object  : in out Job_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (JOB_TABLE'Access);
      Result : Integer;
   begin
      Object.Version := 1;
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_0_1_NAME, --  id
                        Value => Object.Get_Key);
      Query.Save_Field (Name  => COL_11_1_NAME, --  version
                        Value => Object.Version);
      Query.Save_Field (Name  => COL_13_1_NAME, --  event_id
                        Value => Object.Event);
      Query.Save_Field (Name  => COL_14_1_NAME, --  user_id
                        Value => Object.User);
      Query.Save_Field (Name  => COL_15_1_NAME, --  job_queue_id
                        Value => Object.Job_Queue);
      Query.Save_Field (Name  => COL_16_1_NAME, --  session_id
                        Value => Object.Session);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   procedure Delete (Object  : in out Job_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (JOB_TABLE'Access);
   begin
      Stmt.Set_Filter (Filter => "id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   function Get_Value (From : in Job_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : constant ADO.Objects.Object_Record_Access := From.Get_Load_Object;
      Impl : access Job_Impl;
   begin
      if Obj = null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Impl := Job_Impl (Obj.all)'Access;
      if Name = "id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      end if;
      if Name = "status" then
         return Job_Status_Type_Objects.To_Object (Impl.Status);
      end if;
      if Name = "name" then
         return Util.Beans.Objects.To_Object (Impl.Name);
      end if;
      if Name = "start_date" then
         if Impl.Start_Date.Is_Null then
            return Util.Beans.Objects.Null_Object;
         else
            return Util.Beans.Objects.Time.To_Object (Impl.Start_Date.Value);
         end if;
      end if;
      if Name = "create_date" then
         return Util.Beans.Objects.Time.To_Object (Impl.Create_Date);
      end if;
      if Name = "finish_date" then
         if Impl.Finish_Date.Is_Null then
            return Util.Beans.Objects.Null_Object;
         else
            return Util.Beans.Objects.Time.To_Object (Impl.Finish_Date.Value);
         end if;
      end if;
      if Name = "progress" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Progress));
      end if;
      if Name = "parameters" then
         return Util.Beans.Objects.To_Object (Impl.Parameters);
      end if;
      if Name = "results" then
         return Util.Beans.Objects.To_Object (Impl.Results);
      end if;
      if Name = "server_id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Server_Id));
      end if;
      if Name = "task_id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Task_Id));
      end if;
      if Name = "priority" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Priority));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;



   --  ------------------------------
   --  Load the object from current iterator position
   --  ------------------------------
   procedure Load (Object  : in out Job_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
   begin
      Object.Set_Key_Value (Stmt.Get_Identifier (0));
      Object.Status := Job_Status_Type'Val (Stmt.Get_Integer (1));
      Object.Name := Stmt.Get_Unbounded_String (2);
      Object.Start_Date := Stmt.Get_Time (3);
      Object.Create_Date := Stmt.Get_Time (4);
      Object.Finish_Date := Stmt.Get_Time (5);
      Object.Progress := Stmt.Get_Integer (6);
      Object.Parameters := Stmt.Get_Unbounded_String (7);
      Object.Results := Stmt.Get_Unbounded_String (8);
      Object.Server_Id := Stmt.Get_Integer (9);
      Object.Task_Id := Stmt.Get_Integer (10);
      Object.Priority := Stmt.Get_Integer (12);
      if not Stmt.Is_Null (13) then
         Object.Event.Set_Key_Value (Stmt.Get_Identifier (13), Session);
      end if;
      if not Stmt.Is_Null (14) then
         Object.User.Set_Key_Value (Stmt.Get_Identifier (14), Session);
      end if;
      if not Stmt.Is_Null (15) then
         Object.Job_Queue.Set_Key_Value (Stmt.Get_Identifier (15), Session);
      end if;
      if not Stmt.Is_Null (16) then
         Object.Session.Set_Key_Value (Stmt.Get_Identifier (16), Session);
      end if;
      Object.Version := Stmt.Get_Integer (11);
      ADO.Objects.Set_Created (Object);
   end Load;


end AWA.Jobs.Models;
