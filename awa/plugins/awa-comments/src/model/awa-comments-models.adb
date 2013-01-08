-----------------------------------------------------------------------
--  AWA.Comments.Models -- AWA.Comments.Models
-----------------------------------------------------------------------
--  File generated by ada-gen DO NOT MODIFY
--  Template used: templates/model/package-body.xhtml
--  Ada Generator: https://ada-gen.googlecode.com/svn/trunk Revision 1095
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
package body AWA.Comments.Models is

   use type ADO.Objects.Object_Record_Access;
   use type ADO.Objects.Object_Ref;
   use type ADO.Objects.Object_Record;

   function Comment_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => COMMENT_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Comment_Key;

   function Comment_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => COMMENT_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Comment_Key;

   function "=" (Left, Right : Comment_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out Comment_Ref'Class;
                        Impl   : out Comment_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := Comment_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   procedure Allocate (Object : in out Comment_Ref) is
      Impl : Comment_Access;
   begin
      Impl := new Comment_Impl;
      Impl.Date := ADO.DEFAULT_TIME;
      Impl.Entity_Id := ADO.NO_IDENTIFIER;
      Impl.Version := 0;
      Impl.Entity_Type := 0;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: Comment
   -- ----------------------------------------

   procedure Set_Date (Object : in out Comment_Ref;
                       Value  : in Ada.Calendar.Time) is
      Impl : Comment_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Time (Impl.all, 1, Impl.Date, Value);
   end Set_Date;

   function Get_Date (Object : in Comment_Ref)
                  return Ada.Calendar.Time is
      Impl : constant Comment_Access := Comment_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Date;
   end Get_Date;


   procedure Set_Message (Object : in out Comment_Ref;
                           Value : in String) is
      Impl : Comment_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_String (Impl.all, 2, Impl.Message, Value);
   end Set_Message;

   procedure Set_Message (Object : in out Comment_Ref;
                          Value  : in Ada.Strings.Unbounded.Unbounded_String) is
      Impl : Comment_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Unbounded_String (Impl.all, 2, Impl.Message, Value);
   end Set_Message;

   function Get_Message (Object : in Comment_Ref)
                 return String is
   begin
      return Ada.Strings.Unbounded.To_String (Object.Get_Message);
   end Get_Message;
   function Get_Message (Object : in Comment_Ref)
                  return Ada.Strings.Unbounded.Unbounded_String is
      Impl : constant Comment_Access := Comment_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Message;
   end Get_Message;


   procedure Set_Entity_Id (Object : in out Comment_Ref;
                            Value  : in ADO.Identifier) is
      Impl : Comment_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Identifier (Impl.all, 3, Impl.Entity_Id, Value);
   end Set_Entity_Id;

   function Get_Entity_Id (Object : in Comment_Ref)
                  return ADO.Identifier is
      Impl : constant Comment_Access := Comment_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Entity_Id;
   end Get_Entity_Id;


   procedure Set_Id (Object : in out Comment_Ref;
                     Value  : in ADO.Identifier) is
      Impl : Comment_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 4, Value);
   end Set_Id;

   function Get_Id (Object : in Comment_Ref)
                  return ADO.Identifier is
      Impl : constant Comment_Access := Comment_Impl (Object.Get_Object.all)'Access;
   begin
      return Impl.Get_Key_Value;
   end Get_Id;


   function Get_Version (Object : in Comment_Ref)
                  return Integer is
      Impl : constant Comment_Access := Comment_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Version;
   end Get_Version;


   procedure Set_Entity_Type (Object : in out Comment_Ref;
                              Value  : in ADO.Entity_Type) is
      Impl : Comment_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Entity_Type (Impl.all, 6, Impl.Entity_Type, Value);
   end Set_Entity_Type;

   function Get_Entity_Type (Object : in Comment_Ref)
                  return ADO.Entity_Type is
      Impl : constant Comment_Access := Comment_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Entity_Type;
   end Get_Entity_Type;


   procedure Set_Author (Object : in out Comment_Ref;
                         Value  : in AWA.Users.Models.User_Ref'Class) is
      Impl : Comment_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Object (Impl.all, 7, Impl.Author, Value);
   end Set_Author;

   function Get_Author (Object : in Comment_Ref)
                  return AWA.Users.Models.User_Ref'Class is
      Impl : constant Comment_Access := Comment_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Author;
   end Get_Author;

   --  Copy of the object.
   procedure Copy (Object : in Comment_Ref;
                   Into   : in out Comment_Ref) is
      Result : Comment_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant Comment_Access
              := Comment_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant Comment_Access
              := new Comment_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.Date := Impl.Date;
            Copy.Message := Impl.Message;
            Copy.Entity_Id := Impl.Entity_Id;
            Copy.Version := Impl.Version;
            Copy.Entity_Type := Impl.Entity_Type;
            Copy.Author := Impl.Author;
         end;
      end if;
      Into := Result;
   end Copy;

   procedure Find (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant Comment_Access := new Comment_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier) is
      Impl  : constant Comment_Access := new Comment_Impl;
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

   procedure Load (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean) is
      Impl  : constant Comment_Access := new Comment_Impl;
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

   procedure Save (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new Comment_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   procedure Delete (Object  : in out Comment_Ref;
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
   procedure Destroy (Object : access Comment_Impl) is
      type Comment_Impl_Ptr is access all Comment_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (Comment_Impl, Comment_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : Comment_Impl_Ptr := Comment_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   procedure Find (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, COMMENT_DEF'Access);
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
   procedure Load (Object  : in out Comment_Impl;
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

   procedure Save (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (COMMENT_DEF'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_1_NAME, --  date
                          Value => Object.Date);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (2) then
         Stmt.Save_Field (Name  => COL_1_1_NAME, --  message
                          Value => Object.Message);
         Object.Clear_Modified (2);
      end if;
      if Object.Is_Modified (3) then
         Stmt.Save_Field (Name  => COL_2_1_NAME, --  entity_id
                          Value => Object.Entity_Id);
         Object.Clear_Modified (3);
      end if;
      if Object.Is_Modified (4) then
         Stmt.Save_Field (Name  => COL_3_1_NAME, --  id
                          Value => Object.Get_Key);
         Object.Clear_Modified (4);
      end if;
      if Object.Is_Modified (6) then
         Stmt.Save_Field (Name  => COL_5_1_NAME, --  entity_type
                          Value => Object.Entity_Type);
         Object.Clear_Modified (6);
      end if;
      if Object.Is_Modified (7) then
         Stmt.Save_Field (Name  => COL_6_1_NAME, --  author_id
                          Value => Object.Author);
         Object.Clear_Modified (7);
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

   procedure Create (Object  : in out Comment_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (COMMENT_DEF'Access);
      Result : Integer;
   begin
      Object.Version := 1;
      Query.Save_Field (Name  => COL_0_1_NAME, --  date
                        Value => Object.Date);
      Query.Save_Field (Name  => COL_1_1_NAME, --  message
                        Value => Object.Message);
      Query.Save_Field (Name  => COL_2_1_NAME, --  entity_id
                        Value => Object.Entity_Id);
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_3_1_NAME, --  id
                        Value => Object.Get_Key);
      Query.Save_Field (Name  => COL_4_1_NAME, --  version
                        Value => Object.Version);
      Query.Save_Field (Name  => COL_5_1_NAME, --  entity_type
                        Value => Object.Entity_Type);
      Query.Save_Field (Name  => COL_6_1_NAME, --  author_id
                        Value => Object.Author);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   procedure Delete (Object  : in out Comment_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (COMMENT_DEF'Access);
   begin
      Stmt.Set_Filter (Filter => "id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   function Get_Value (From : in Comment_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : constant ADO.Objects.Object_Record_Access := From.Get_Load_Object;
      Impl : access Comment_Impl;
   begin
      if Obj = null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Impl := Comment_Impl (Obj.all)'Access;
      if Name = "date" then
         return Util.Beans.Objects.Time.To_Object (Impl.Date);
      elsif Name = "message" then
         return Util.Beans.Objects.To_Object (Impl.Message);
      elsif Name = "entity_id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Entity_Id));
      elsif Name = "id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      elsif Name = "entity_type" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Entity_Type));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;



   --  ------------------------------
   --  Load the object from current iterator position
   --  ------------------------------
   procedure Load (Object  : in out Comment_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
   begin
      Object.Date := Stmt.Get_Time (0);
      Object.Message := Stmt.Get_Unbounded_String (1);
      Object.Entity_Id := Stmt.Get_Identifier (2);
      Object.Set_Key_Value (Stmt.Get_Identifier (3));
      Object.Entity_Type := ADO.Entity_Type (Stmt.Get_Integer (5));
      if not Stmt.Is_Null (6) then
         Object.Author.Set_Key_Value (Stmt.Get_Identifier (6), Session);
      end if;
      Object.Version := Stmt.Get_Integer (4);
      ADO.Objects.Set_Created (Object);
   end Load;


end AWA.Comments.Models;
