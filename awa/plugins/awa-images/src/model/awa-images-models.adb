-----------------------------------------------------------------------
--  AWA.Images.Models -- AWA.Images.Models
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
package body AWA.Images.Models is

   use type ADO.Objects.Object_Record_Access;
   use type ADO.Objects.Object_Ref;
   use type ADO.Objects.Object_Record;

   function Image_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => IMAGE_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Image_Key;

   function Image_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => IMAGE_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Image_Key;

   function "=" (Left, Right : Image_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out Image_Ref'Class;
                        Impl   : out Image_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := Image_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   procedure Allocate (Object : in out Image_Ref) is
      Impl : Image_Access;
   begin
      Impl := new Image_Impl;
      Impl.Version := 0;
      Impl.Width := 0;
      Impl.Height := 0;
      Impl.Thumb_Height := 0;
      Impl.Thumb_Width := 0;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: Image
   -- ----------------------------------------

   procedure Set_Id (Object : in out Image_Ref;
                     Value  : in ADO.Identifier) is
      Impl : Image_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 1, Value);
   end Set_Id;

   function Get_Id (Object : in Image_Ref)
                  return ADO.Identifier is
      Impl : constant Image_Access := Image_Impl (Object.Get_Object.all)'Access;
   begin
      return Impl.Get_Key_Value;
   end Get_Id;


   function Get_Version (Object : in Image_Ref)
                  return Integer is
      Impl : constant Image_Access := Image_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Version;
   end Get_Version;


   procedure Set_Width (Object : in out Image_Ref;
                        Value  : in Natural) is
      Impl : Image_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 3, Impl.Width, Value);
   end Set_Width;

   function Get_Width (Object : in Image_Ref)
                  return Natural is
      Impl : constant Image_Access := Image_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Width;
   end Get_Width;


   procedure Set_Height (Object : in out Image_Ref;
                         Value  : in Natural) is
      Impl : Image_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 4, Impl.Height, Value);
   end Set_Height;

   function Get_Height (Object : in Image_Ref)
                  return Natural is
      Impl : constant Image_Access := Image_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Height;
   end Get_Height;


   procedure Set_Thumb_Height (Object : in out Image_Ref;
                               Value  : in Natural) is
      Impl : Image_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 5, Impl.Thumb_Height, Value);
   end Set_Thumb_Height;

   function Get_Thumb_Height (Object : in Image_Ref)
                  return Natural is
      Impl : constant Image_Access := Image_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Thumb_Height;
   end Get_Thumb_Height;


   procedure Set_Thumb_Width (Object : in out Image_Ref;
                              Value  : in Natural) is
      Impl : Image_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 6, Impl.Thumb_Width, Value);
   end Set_Thumb_Width;

   function Get_Thumb_Width (Object : in Image_Ref)
                  return Natural is
      Impl : constant Image_Access := Image_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Thumb_Width;
   end Get_Thumb_Width;


   procedure Set_Thumbnail (Object : in out Image_Ref;
                            Value  : in AWA.Storages.Models.Storage_Ref'Class) is
      Impl : Image_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Object (Impl.all, 7, Impl.Thumbnail, Value);
   end Set_Thumbnail;

   function Get_Thumbnail (Object : in Image_Ref)
                  return AWA.Storages.Models.Storage_Ref'Class is
      Impl : constant Image_Access := Image_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Thumbnail;
   end Get_Thumbnail;


   procedure Set_Storage (Object : in out Image_Ref;
                          Value  : in AWA.Storages.Models.Storage_Ref'Class) is
      Impl : Image_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Object (Impl.all, 8, Impl.Storage, Value);
   end Set_Storage;

   function Get_Storage (Object : in Image_Ref)
                  return AWA.Storages.Models.Storage_Ref'Class is
      Impl : constant Image_Access := Image_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Storage;
   end Get_Storage;

   --  Copy of the object.
   procedure Copy (Object : in Image_Ref;
                   Into   : in out Image_Ref) is
      Result : Image_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant Image_Access
              := Image_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant Image_Access
              := new Image_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.Version := Impl.Version;
            Copy.Width := Impl.Width;
            Copy.Height := Impl.Height;
            Copy.Thumb_Height := Impl.Thumb_Height;
            Copy.Thumb_Width := Impl.Thumb_Width;
            Copy.Thumbnail := Impl.Thumbnail;
            Copy.Storage := Impl.Storage;
         end;
      end if;
      Into := Result;
   end Copy;

   procedure Find (Object  : in out Image_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant Image_Access := new Image_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out Image_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier) is
      Impl  : constant Image_Access := new Image_Impl;
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

   procedure Load (Object  : in out Image_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean) is
      Impl  : constant Image_Access := new Image_Impl;
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

   procedure Save (Object  : in out Image_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new Image_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   procedure Delete (Object  : in out Image_Ref;
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
   procedure Destroy (Object : access Image_Impl) is
      type Image_Impl_Ptr is access all Image_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (Image_Impl, Image_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : Image_Impl_Ptr := Image_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   procedure Find (Object  : in out Image_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, IMAGE_DEF'Access);
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
   procedure Load (Object  : in out Image_Impl;
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

   procedure Save (Object  : in out Image_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (IMAGE_DEF'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_1_NAME, --  id
                          Value => Object.Get_Key);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (3) then
         Stmt.Save_Field (Name  => COL_2_1_NAME, --  width
                          Value => Object.Width);
         Object.Clear_Modified (3);
      end if;
      if Object.Is_Modified (4) then
         Stmt.Save_Field (Name  => COL_3_1_NAME, --  height
                          Value => Object.Height);
         Object.Clear_Modified (4);
      end if;
      if Object.Is_Modified (5) then
         Stmt.Save_Field (Name  => COL_4_1_NAME, --  thumb_height
                          Value => Object.Thumb_Height);
         Object.Clear_Modified (5);
      end if;
      if Object.Is_Modified (6) then
         Stmt.Save_Field (Name  => COL_5_1_NAME, --  thumb_width
                          Value => Object.Thumb_Width);
         Object.Clear_Modified (6);
      end if;
      if Object.Is_Modified (7) then
         Stmt.Save_Field (Name  => COL_6_1_NAME, --  thumbnail_id
                          Value => Object.Thumbnail);
         Object.Clear_Modified (7);
      end if;
      if Object.Is_Modified (8) then
         Stmt.Save_Field (Name  => COL_7_1_NAME, --  storage_id
                          Value => Object.Storage);
         Object.Clear_Modified (8);
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

   procedure Create (Object  : in out Image_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (IMAGE_DEF'Access);
      Result : Integer;
   begin
      Object.Version := 1;
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_0_1_NAME, --  id
                        Value => Object.Get_Key);
      Query.Save_Field (Name  => COL_1_1_NAME, --  version
                        Value => Object.Version);
      Query.Save_Field (Name  => COL_2_1_NAME, --  width
                        Value => Object.Width);
      Query.Save_Field (Name  => COL_3_1_NAME, --  height
                        Value => Object.Height);
      Query.Save_Field (Name  => COL_4_1_NAME, --  thumb_height
                        Value => Object.Thumb_Height);
      Query.Save_Field (Name  => COL_5_1_NAME, --  thumb_width
                        Value => Object.Thumb_Width);
      Query.Save_Field (Name  => COL_6_1_NAME, --  thumbnail_id
                        Value => Object.Thumbnail);
      Query.Save_Field (Name  => COL_7_1_NAME, --  storage_id
                        Value => Object.Storage);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   procedure Delete (Object  : in out Image_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (IMAGE_DEF'Access);
   begin
      Stmt.Set_Filter (Filter => "id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   function Get_Value (From : in Image_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : constant ADO.Objects.Object_Record_Access := From.Get_Load_Object;
      Impl : access Image_Impl;
   begin
      if Obj = null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Impl := Image_Impl (Obj.all)'Access;
      if Name = "id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      elsif Name = "width" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Width));
      elsif Name = "height" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Height));
      elsif Name = "thumb_height" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Thumb_Height));
      elsif Name = "thumb_width" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Thumb_Width));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;



   procedure List (Object  : in out Image_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class) is
      Stmt : ADO.Statements.Query_Statement
        := Session.Create_Statement (Query, IMAGE_DEF'Access);
   begin
      Stmt.Execute;
      Image_Vectors.Clear (Object);
      while Stmt.Has_Elements loop
         declare
            Item : Image_Ref;
            Impl : constant Image_Access := new Image_Impl;
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
   procedure Load (Object  : in out Image_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
   begin
      Object.Set_Key_Value (Stmt.Get_Identifier (0));
      Object.Width := Stmt.Get_Natural (2);
      Object.Height := Stmt.Get_Natural (3);
      Object.Thumb_Height := Stmt.Get_Natural (4);
      Object.Thumb_Width := Stmt.Get_Natural (5);
      if not Stmt.Is_Null (6) then
         Object.Thumbnail.Set_Key_Value (Stmt.Get_Identifier (6), Session);
      end if;
      if not Stmt.Is_Null (7) then
         Object.Storage.Set_Key_Value (Stmt.Get_Identifier (7), Session);
      end if;
      Object.Version := Stmt.Get_Integer (1);
      ADO.Objects.Set_Created (Object);
   end Load;

   --  --------------------
   --  Get the bean attribute identified by the given name.
   --  --------------------
   overriding
   function Get_Value (From : in Image_Info;
                       Name : in String) return Util.Beans.Objects.Object is
   begin
      if Name = "id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Id));
      end if;
      if Name = "name" then
         return Util.Beans.Objects.To_Object (From.Name);
      end if;
      if Name = "create_date" then
         return Util.Beans.Objects.Time.To_Object (From.Create_Date);
      end if;
      if Name = "uri" then
         return Util.Beans.Objects.To_Object (From.Uri);
      end if;
      if Name = "storage" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Storage));
      end if;
      if Name = "mime_type" then
         return Util.Beans.Objects.To_Object (From.Mime_Type);
      end if;
      if Name = "file_size" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.File_Size));
      end if;
      if Name = "width" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Width));
      end if;
      if Name = "height" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Height));
      end if;
      if Name = "thumb_width" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Thumb_Width));
      end if;
      if Name = "thumb_height" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Thumb_Height));
      end if;
      if Name = "thumbnail_id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Thumbnail_Id));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;

   --  --------------------
   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   --  --------------------
   procedure List (Object  : in out Image_Info_List_Bean'Class;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class) is
   begin
      List (Object.List, Session, Context);
   end List;
   --  --------------------
   --  The list of images for a given folder.
   --  --------------------
   procedure List (Object  : in out Image_Info_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class) is
      procedure Read (Into : in out Image_Info);

      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Context);
      Pos  : Natural := 0;
      procedure Read (Into : in out Image_Info) is
      begin
         Into.Id := Stmt.Get_Identifier (0);
         Into.Name := Stmt.Get_Unbounded_String (1);
         Into.Create_Date := Stmt.Get_Time (2);
         Into.Uri := Stmt.Get_Unbounded_String (3);
         Into.Storage := Stmt.Get_Integer (4);
         Into.Mime_Type := Stmt.Get_Unbounded_String (5);
         Into.File_Size := Stmt.Get_Integer (6);
         Into.Width := Stmt.Get_Integer (7);
         Into.Height := Stmt.Get_Integer (8);
         Into.Thumb_Width := Stmt.Get_Integer (9);
         Into.Thumb_Height := Stmt.Get_Integer (10);
         Into.Thumbnail_Id := Stmt.Get_Identifier (11);
      end Read;
   begin
      Stmt.Execute;
      Image_Info_Vectors.Clear (Object);
      while Stmt.Has_Elements loop
         Object.Insert_Space (Before => Pos);
         Object.Update_Element (Index => Pos, Process => Read'Access);
         Pos := Pos + 1;
         Stmt.Next;
      end loop;
   end List;



end AWA.Images.Models;
