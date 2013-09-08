-----------------------------------------------------------------------
--  AWA.Tags.Models -- AWA.Tags.Models
-----------------------------------------------------------------------
--  File generated by ada-gen DO NOT MODIFY
--  Template used: templates/model/package-body.xhtml
--  Ada Generator: https://ada-gen.googlecode.com/svn/trunk Revision 1095
-----------------------------------------------------------------------
--  Copyright (C) 2013 Stephane Carrez
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
package body AWA.Tags.Models is

   use type ADO.Objects.Object_Record_Access;
   use type ADO.Objects.Object_Ref;
   use type ADO.Objects.Object_Record;

   function Tag_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => TAG_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Tag_Key;

   function Tag_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => TAG_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Tag_Key;

   function "=" (Left, Right : Tag_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out Tag_Ref'Class;
                        Impl   : out Tag_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := Tag_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   procedure Allocate (Object : in out Tag_Ref) is
      Impl : Tag_Access;
   begin
      Impl := new Tag_Impl;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: Tag
   -- ----------------------------------------

   procedure Set_Id (Object : in out Tag_Ref;
                     Value  : in ADO.Identifier) is
      Impl : Tag_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 1, Value);
   end Set_Id;

   function Get_Id (Object : in Tag_Ref)
                  return ADO.Identifier is
      Impl : constant Tag_Access
         := Tag_Impl (Object.Get_Object.all)'Access;
   begin
      return Impl.Get_Key_Value;
   end Get_Id;


   procedure Set_Name (Object : in out Tag_Ref;
                        Value : in String) is
      Impl : Tag_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_String (Impl.all, 2, Impl.Name, Value);
   end Set_Name;

   procedure Set_Name (Object : in out Tag_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String) is
      Impl : Tag_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Unbounded_String (Impl.all, 2, Impl.Name, Value);
   end Set_Name;

   function Get_Name (Object : in Tag_Ref)
                 return String is
   begin
      return Ada.Strings.Unbounded.To_String (Object.Get_Name);
   end Get_Name;
   function Get_Name (Object : in Tag_Ref)
                  return Ada.Strings.Unbounded.Unbounded_String is
      Impl : constant Tag_Access
         := Tag_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Name;
   end Get_Name;

   --  Copy of the object.
   procedure Copy (Object : in Tag_Ref;
                   Into   : in out Tag_Ref) is
      Result : Tag_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant Tag_Access
              := Tag_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant Tag_Access
              := new Tag_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.Name := Impl.Name;
         end;
      end if;
      Into := Result;
   end Copy;

   procedure Find (Object  : in out Tag_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant Tag_Access := new Tag_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out Tag_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier) is
      Impl  : constant Tag_Access := new Tag_Impl;
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

   procedure Load (Object  : in out Tag_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean) is
      Impl  : constant Tag_Access := new Tag_Impl;
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

   procedure Save (Object  : in out Tag_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new Tag_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   procedure Delete (Object  : in out Tag_Ref;
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
   procedure Destroy (Object : access Tag_Impl) is
      type Tag_Impl_Ptr is access all Tag_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (Tag_Impl, Tag_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : Tag_Impl_Ptr := Tag_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   procedure Find (Object  : in out Tag_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, TAG_DEF'Access);
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
   procedure Load (Object  : in out Tag_Impl;
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

   procedure Save (Object  : in out Tag_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (TAG_DEF'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_1_NAME, --  id
                          Value => Object.Get_Key);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (2) then
         Stmt.Save_Field (Name  => COL_1_1_NAME, --  name
                          Value => Object.Name);
         Object.Clear_Modified (2);
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

   procedure Create (Object  : in out Tag_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (TAG_DEF'Access);
      Result : Integer;
   begin
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_0_1_NAME, --  id
                        Value => Object.Get_Key);
      Query.Save_Field (Name  => COL_1_1_NAME, --  name
                        Value => Object.Name);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   procedure Delete (Object  : in out Tag_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (TAG_DEF'Access);
   begin
      Stmt.Set_Filter (Filter => "id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   function Get_Value (From : in Tag_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : constant ADO.Objects.Object_Record_Access := From.Get_Load_Object;
      Impl : access Tag_Impl;
   begin
      if Obj = null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Impl := Tag_Impl (Obj.all)'Access;
      if Name = "id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      elsif Name = "name" then
         return Util.Beans.Objects.To_Object (Impl.Name);
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;



   procedure List (Object  : in out Tag_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class) is
      Stmt : ADO.Statements.Query_Statement
        := Session.Create_Statement (Query, TAG_DEF'Access);
   begin
      Stmt.Execute;
      Tag_Vectors.Clear (Object);
      while Stmt.Has_Elements loop
         declare
            Item : Tag_Ref;
            Impl : constant Tag_Access := new Tag_Impl;
         begin
            Impl.Load (Stmt, Session);
            ADO.Objects.Set_Object (Item, Impl.all'Access);
            Object.Append (Item);
         end;
         Stmt.Next;
      end loop;
   end List;

   --  ------------------------------
   --  Load the object from current iterator position
   --  ------------------------------
   procedure Load (Object  : in out Tag_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
      pragma Unreferenced (Session);
   begin
      Object.Set_Key_Value (Stmt.Get_Identifier (0));
      Object.Name := Stmt.Get_Unbounded_String (1);
      ADO.Objects.Set_Created (Object);
   end Load;
   function Tagged_Entity_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => TAGGED_ENTITY_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Tagged_Entity_Key;

   function Tagged_Entity_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => TAGGED_ENTITY_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Tagged_Entity_Key;

   function "=" (Left, Right : Tagged_Entity_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out Tagged_Entity_Ref'Class;
                        Impl   : out Tagged_Entity_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := Tagged_Entity_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   procedure Allocate (Object : in out Tagged_Entity_Ref) is
      Impl : Tagged_Entity_Access;
   begin
      Impl := new Tagged_Entity_Impl;
      Impl.For_Entity_Id := ADO.NO_IDENTIFIER;
      Impl.Entity_Type := 0;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: Tagged_Entity
   -- ----------------------------------------

   procedure Set_Id (Object : in out Tagged_Entity_Ref;
                     Value  : in ADO.Identifier) is
      Impl : Tagged_Entity_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 1, Value);
   end Set_Id;

   function Get_Id (Object : in Tagged_Entity_Ref)
                  return ADO.Identifier is
      Impl : constant Tagged_Entity_Access
         := Tagged_Entity_Impl (Object.Get_Object.all)'Access;
   begin
      return Impl.Get_Key_Value;
   end Get_Id;


   procedure Set_For_Entity_Id (Object : in out Tagged_Entity_Ref;
                                Value  : in ADO.Identifier) is
      Impl : Tagged_Entity_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Identifier (Impl.all, 2, Impl.For_Entity_Id, Value);
   end Set_For_Entity_Id;

   function Get_For_Entity_Id (Object : in Tagged_Entity_Ref)
                  return ADO.Identifier is
      Impl : constant Tagged_Entity_Access
         := Tagged_Entity_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.For_Entity_Id;
   end Get_For_Entity_Id;


   procedure Set_Entity_Type (Object : in out Tagged_Entity_Ref;
                              Value  : in ADO.Entity_Type) is
      Impl : Tagged_Entity_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Entity_Type (Impl.all, 3, Impl.Entity_Type, Value);
   end Set_Entity_Type;

   function Get_Entity_Type (Object : in Tagged_Entity_Ref)
                  return ADO.Entity_Type is
      Impl : constant Tagged_Entity_Access
         := Tagged_Entity_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Entity_Type;
   end Get_Entity_Type;


   procedure Set_Tag (Object : in out Tagged_Entity_Ref;
                      Value  : in AWA.Tags.Models.Tag_Ref'Class) is
      Impl : Tagged_Entity_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Object (Impl.all, 4, Impl.Tag, Value);
   end Set_Tag;

   function Get_Tag (Object : in Tagged_Entity_Ref)
                  return AWA.Tags.Models.Tag_Ref'Class is
      Impl : constant Tagged_Entity_Access
         := Tagged_Entity_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Tag;
   end Get_Tag;

   --  Copy of the object.
   procedure Copy (Object : in Tagged_Entity_Ref;
                   Into   : in out Tagged_Entity_Ref) is
      Result : Tagged_Entity_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant Tagged_Entity_Access
              := Tagged_Entity_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant Tagged_Entity_Access
              := new Tagged_Entity_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.For_Entity_Id := Impl.For_Entity_Id;
            Copy.Entity_Type := Impl.Entity_Type;
            Copy.Tag := Impl.Tag;
         end;
      end if;
      Into := Result;
   end Copy;

   procedure Find (Object  : in out Tagged_Entity_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant Tagged_Entity_Access := new Tagged_Entity_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out Tagged_Entity_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier) is
      Impl  : constant Tagged_Entity_Access := new Tagged_Entity_Impl;
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

   procedure Load (Object  : in out Tagged_Entity_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean) is
      Impl  : constant Tagged_Entity_Access := new Tagged_Entity_Impl;
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

   procedure Save (Object  : in out Tagged_Entity_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new Tagged_Entity_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   procedure Delete (Object  : in out Tagged_Entity_Ref;
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
   procedure Destroy (Object : access Tagged_Entity_Impl) is
      type Tagged_Entity_Impl_Ptr is access all Tagged_Entity_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (Tagged_Entity_Impl, Tagged_Entity_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : Tagged_Entity_Impl_Ptr := Tagged_Entity_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   procedure Find (Object  : in out Tagged_Entity_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, TAGGED_ENTITY_DEF'Access);
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
   procedure Load (Object  : in out Tagged_Entity_Impl;
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

   procedure Save (Object  : in out Tagged_Entity_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (TAGGED_ENTITY_DEF'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_2_NAME, --  id
                          Value => Object.Get_Key);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (2) then
         Stmt.Save_Field (Name  => COL_1_2_NAME, --  for_entity_id
                          Value => Object.For_Entity_Id);
         Object.Clear_Modified (2);
      end if;
      if Object.Is_Modified (3) then
         Stmt.Save_Field (Name  => COL_2_2_NAME, --  entity_type
                          Value => Object.Entity_Type);
         Object.Clear_Modified (3);
      end if;
      if Object.Is_Modified (4) then
         Stmt.Save_Field (Name  => COL_3_2_NAME, --  tag_id
                          Value => Object.Tag);
         Object.Clear_Modified (4);
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

   procedure Create (Object  : in out Tagged_Entity_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (TAGGED_ENTITY_DEF'Access);
      Result : Integer;
   begin
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_0_2_NAME, --  id
                        Value => Object.Get_Key);
      Query.Save_Field (Name  => COL_1_2_NAME, --  for_entity_id
                        Value => Object.For_Entity_Id);
      Query.Save_Field (Name  => COL_2_2_NAME, --  entity_type
                        Value => Object.Entity_Type);
      Query.Save_Field (Name  => COL_3_2_NAME, --  tag_id
                        Value => Object.Tag);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   procedure Delete (Object  : in out Tagged_Entity_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (TAGGED_ENTITY_DEF'Access);
   begin
      Stmt.Set_Filter (Filter => "id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   function Get_Value (From : in Tagged_Entity_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : constant ADO.Objects.Object_Record_Access := From.Get_Load_Object;
      Impl : access Tagged_Entity_Impl;
   begin
      if Obj = null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Impl := Tagged_Entity_Impl (Obj.all)'Access;
      if Name = "id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      elsif Name = "for_entity_id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.For_Entity_Id));
      elsif Name = "entity_type" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Entity_Type));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;



   procedure List (Object  : in out Tagged_Entity_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class) is
      Stmt : ADO.Statements.Query_Statement
        := Session.Create_Statement (Query, TAGGED_ENTITY_DEF'Access);
   begin
      Stmt.Execute;
      Tagged_Entity_Vectors.Clear (Object);
      while Stmt.Has_Elements loop
         declare
            Item : Tagged_Entity_Ref;
            Impl : constant Tagged_Entity_Access := new Tagged_Entity_Impl;
         begin
            Impl.Load (Stmt, Session);
            ADO.Objects.Set_Object (Item, Impl.all'Access);
            Object.Append (Item);
         end;
         Stmt.Next;
      end loop;
   end List;

   --  ------------------------------
   --  Load the object from current iterator position
   --  ------------------------------
   procedure Load (Object  : in out Tagged_Entity_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
   begin
      Object.Set_Key_Value (Stmt.Get_Identifier (0));
      Object.For_Entity_Id := Stmt.Get_Identifier (1);
      Object.Entity_Type := ADO.Entity_Type (Stmt.Get_Integer (2));
      if not Stmt.Is_Null (3) then
         Object.Tag.Set_Key_Value (Stmt.Get_Identifier (3), Session);
      end if;
      ADO.Objects.Set_Created (Object);
   end Load;

   --  --------------------
   --  Get the bean attribute identified by the given name.
   --  --------------------
   overriding
   function Get_Value (From : in Tag_Info;
                       Name : in String) return Util.Beans.Objects.Object is
   begin
      if Name = "tag" then
         return Util.Beans.Objects.To_Object (From.Tag);
      end if;
      if Name = "count" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Count));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;

   --  --------------------
   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   --  --------------------
   procedure List (Object  : in out Tag_Info_List_Bean'Class;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class) is
   begin
      List (Object.List, Session, Context);
   end List;
   --  --------------------
   --  The tag information.
   --  --------------------
   procedure List (Object  : in out Tag_Info_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class) is
      procedure Read (Into : in out Tag_Info);

      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Context);
      Pos  : Natural := 0;
      procedure Read (Into : in out Tag_Info) is
      begin
         Into.Tag := Stmt.Get_Unbounded_String (0);
         Into.Count := Stmt.Get_Natural (1);
      end Read;
   begin
      Stmt.Execute;
      Tag_Info_Vectors.Clear (Object);
      while Stmt.Has_Elements loop
         Object.Insert_Space (Before => Pos);
         Object.Update_Element (Index => Pos, Process => Read'Access);
         Pos := Pos + 1;
         Stmt.Next;
      end loop;
   end List;



end AWA.Tags.Models;