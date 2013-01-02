-----------------------------------------------------------------------
--  AWA.Permissions.Models -- AWA.Permissions.Models
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
package body AWA.Permissions.Models is

   use type ADO.Objects.Object_Record_Access;
   use type ADO.Objects.Object_Ref;
   use type ADO.Objects.Object_Record;

   function ACL_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_STRING,
                                       Of_Class => ACL_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end ACL_Key;

   function ACL_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_STRING,
                                       Of_Class => ACL_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end ACL_Key;

   function "=" (Left, Right : ACL_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out Acl_Ref'Class;
                        Impl   : out Acl_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := Acl_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   procedure Allocate (Object : in out Acl_Ref) is
      Impl : Acl_Access;
   begin
      Impl := new Acl_Impl;
      Impl.Entity_Id := ADO.NO_IDENTIFIER;
      Impl.Writeable := False;
      Impl.User_Id := ADO.NO_IDENTIFIER;
      Impl.Entity_Type := 0;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: Acl
   -- ----------------------------------------

   procedure Set_Id (Object : in out Acl_Ref;
                     Value  : in ADO.Identifier) is
      Impl : Acl_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 1, Value);
   end Set_Id;

   function Get_Id (Object : in Acl_Ref)
                  return ADO.Identifier is
      Impl : constant Acl_Access := Acl_Impl (Object.Get_Object.all)'Access;
   begin
      return Impl.Get_Key_Value;
   end Get_Id;


   procedure Set_Entity_Id (Object : in out Acl_Ref;
                            Value  : in ADO.Identifier) is
      Impl : Acl_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Identifier (Impl.all, 2, Impl.Entity_Id, Value);
   end Set_Entity_Id;

   function Get_Entity_Id (Object : in Acl_Ref)
                  return ADO.Identifier is
      Impl : constant Acl_Access := Acl_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Entity_Id;
   end Get_Entity_Id;


   procedure Set_Writeable (Object : in out Acl_Ref;
                            Value  : in Boolean) is
      Impl : Acl_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Boolean (Impl.all, 3, Impl.Writeable, Value);
      ADO.Objects.Set_Field_Boolean (Impl.all, 3, Impl.Writeable, Value);
   end Set_Writeable;

   function Get_Writeable (Object : in Acl_Ref)
                  return Boolean is
      Impl : constant Acl_Access := Acl_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Writeable;
   end Get_Writeable;


   procedure Set_User_Id (Object : in out Acl_Ref;
                          Value  : in ADO.Identifier) is
      Impl : Acl_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Identifier (Impl.all, 4, Impl.User_Id, Value);
   end Set_User_Id;

   function Get_User_Id (Object : in Acl_Ref)
                  return ADO.Identifier is
      Impl : constant Acl_Access := Acl_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.User_Id;
   end Get_User_Id;


   procedure Set_Entity_Type (Object : in out Acl_Ref;
                              Value  : in ADO.Entity_Type) is
      Impl : Acl_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Entity_Type (Impl.all, 5, Impl.Entity_Type, Value);
   end Set_Entity_Type;

   function Get_Entity_Type (Object : in Acl_Ref)
                  return ADO.Entity_Type is
      Impl : constant Acl_Access := Acl_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Entity_Type;
   end Get_Entity_Type;

   --  Copy of the object.
   procedure Copy (Object : in Acl_Ref;
                   Into   : in out Acl_Ref) is
      Result : Acl_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant Acl_Access
              := Acl_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant Acl_Access
              := new Acl_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.Entity_Id := Impl.Entity_Id;
            Copy.Writeable := Impl.Writeable;
            Copy.User_Id := Impl.User_Id;
            Copy.Entity_Type := Impl.Entity_Type;
         end;
      end if;
      Into := Result;
   end Copy;

   procedure Find (Object  : in out Acl_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant Acl_Access := new Acl_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out Acl_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier) is
      Impl  : constant Acl_Access := new Acl_Impl;
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

   procedure Load (Object  : in out Acl_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean) is
      Impl  : constant Acl_Access := new Acl_Impl;
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

   procedure Save (Object  : in out Acl_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new Acl_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   procedure Delete (Object  : in out Acl_Ref;
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
   procedure Destroy (Object : access Acl_Impl) is
      type Acl_Impl_Ptr is access all Acl_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (Acl_Impl, Acl_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : Acl_Impl_Ptr := Acl_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   procedure Find (Object  : in out Acl_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, ACL_DEF'Access);
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
   procedure Load (Object  : in out Acl_Impl;
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

   procedure Save (Object  : in out Acl_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (ACL_DEF'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_1_NAME, --  id
                          Value => Object.Get_Key);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (2) then
         Stmt.Save_Field (Name  => COL_1_1_NAME, --  entity_id
                          Value => Object.Entity_Id);
         Object.Clear_Modified (2);
      end if;
      if Object.Is_Modified (3) then
         Stmt.Save_Field (Name  => COL_2_1_NAME, --  writeable
                          Value => Object.Writeable);
         Object.Clear_Modified (3);
      end if;
      if Object.Is_Modified (4) then
         Stmt.Save_Field (Name  => COL_3_1_NAME, --  user_id
                          Value => Object.User_Id);
         Object.Clear_Modified (4);
      end if;
      if Object.Is_Modified (5) then
         Stmt.Save_Field (Name  => COL_4_1_NAME, --  entity_type
                          Value => Object.Entity_Type);
         Object.Clear_Modified (5);
      end if;
      if Stmt.Has_Save_Fields then
         Stmt.Set_Filter (Filter => "id = ?");
         Stmt.Add_Param (Value => Object.Get_Key);
         declare
            Result : Integer;
         begin
            Stmt.Execute (Result);
            if Result /= 1 then
               if Result /= 0 then
                  raise ADO.Objects.UPDATE_ERROR;
               end if;
            end if;
         end;
      end if;
   end Save;

   procedure Create (Object  : in out Acl_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (ACL_DEF'Access);
      Result : Integer;
   begin
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_0_1_NAME, --  id
                        Value => Object.Get_Key);
      Query.Save_Field (Name  => COL_1_1_NAME, --  entity_id
                        Value => Object.Entity_Id);
      Query.Save_Field (Name  => COL_2_1_NAME, --  writeable
                        Value => Object.Writeable);
      Query.Save_Field (Name  => COL_3_1_NAME, --  user_id
                        Value => Object.User_Id);
      Query.Save_Field (Name  => COL_4_1_NAME, --  entity_type
                        Value => Object.Entity_Type);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   procedure Delete (Object  : in out Acl_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (ACL_DEF'Access);
   begin
      Stmt.Set_Filter (Filter => "id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   function Get_Value (From : in Acl_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : constant ADO.Objects.Object_Record_Access := From.Get_Load_Object;
      Impl : access Acl_Impl;
   begin
      if Obj = null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Impl := Acl_Impl (Obj.all)'Access;
      if Name = "id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      elsif Name = "entity_id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Entity_Id));
      elsif Name = "writeable" then
         return Util.Beans.Objects.To_Object (Impl.Writeable);
      elsif Name = "user_id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.User_Id));
      elsif Name = "entity_type" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Entity_Type));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;



   --  ------------------------------
   --  Load the object from current iterator position
   --  ------------------------------
   procedure Load (Object  : in out Acl_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
   begin
      Object.Set_Key_Value (Stmt.Get_Identifier (0));
      Object.Entity_Id := Stmt.Get_Identifier (1);
      Object.Writeable := Stmt.Get_Boolean (2);
      Object.Writeable := Stmt.Get_Boolean (2);
      Object.User_Id := Stmt.Get_Identifier (3);
      Object.Entity_Type := ADO.Entity_Type (Stmt.Get_Integer (4));
      ADO.Objects.Set_Created (Object);
   end Load;



end AWA.Permissions.Models;
