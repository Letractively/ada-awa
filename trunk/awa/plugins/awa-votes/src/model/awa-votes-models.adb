-----------------------------------------------------------------------
--  AWA.Votes.Models -- AWA.Votes.Models
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
with ASF.Events.Faces.Actions;
package body AWA.Votes.Models is

   use type ADO.Objects.Object_Record_Access;
   use type ADO.Objects.Object_Ref;
   use type ADO.Objects.Object_Record;

   function Rating_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => RATING_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Rating_Key;

   function Rating_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => RATING_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Rating_Key;

   function "=" (Left, Right : Rating_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out Rating_Ref'Class;
                        Impl   : out Rating_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := Rating_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   procedure Allocate (Object : in out Rating_Ref) is
      Impl : Rating_Access;
   begin
      Impl := new Rating_Impl;
      Impl.Rating := 0;
      Impl.Vote_Count := 0;
      Impl.For_Entity_Id := ADO.NO_IDENTIFIER;
      Impl.For_Entity_Type := 0;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: Rating
   -- ----------------------------------------

   procedure Set_Id (Object : in out Rating_Ref;
                     Value  : in ADO.Identifier) is
      Impl : Rating_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 1, Value);
   end Set_Id;

   function Get_Id (Object : in Rating_Ref)
                  return ADO.Identifier is
      Impl : constant Rating_Access := Rating_Impl (Object.Get_Object.all)'Access;
   begin
      return Impl.Get_Key_Value;
   end Get_Id;


   procedure Set_Rating (Object : in out Rating_Ref;
                         Value  : in Integer) is
      Impl : Rating_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 2, Impl.Rating, Value);
   end Set_Rating;

   function Get_Rating (Object : in Rating_Ref)
                  return Integer is
      Impl : constant Rating_Access := Rating_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Rating;
   end Get_Rating;


   procedure Set_Vote_Count (Object : in out Rating_Ref;
                             Value  : in Integer) is
      Impl : Rating_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 3, Impl.Vote_Count, Value);
   end Set_Vote_Count;

   function Get_Vote_Count (Object : in Rating_Ref)
                  return Integer is
      Impl : constant Rating_Access := Rating_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Vote_Count;
   end Get_Vote_Count;


   procedure Set_For_Entity_Id (Object : in out Rating_Ref;
                                Value  : in ADO.Identifier) is
      Impl : Rating_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Identifier (Impl.all, 4, Impl.For_Entity_Id, Value);
   end Set_For_Entity_Id;

   function Get_For_Entity_Id (Object : in Rating_Ref)
                  return ADO.Identifier is
      Impl : constant Rating_Access := Rating_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.For_Entity_Id;
   end Get_For_Entity_Id;


   procedure Set_For_Entity_Type (Object : in out Rating_Ref;
                                  Value  : in ADO.Entity_Type) is
      Impl : Rating_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Entity_Type (Impl.all, 5, Impl.For_Entity_Type, Value);
   end Set_For_Entity_Type;

   function Get_For_Entity_Type (Object : in Rating_Ref)
                  return ADO.Entity_Type is
      Impl : constant Rating_Access := Rating_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.For_Entity_Type;
   end Get_For_Entity_Type;

   --  Copy of the object.
   procedure Copy (Object : in Rating_Ref;
                   Into   : in out Rating_Ref) is
      Result : Rating_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant Rating_Access
              := Rating_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant Rating_Access
              := new Rating_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.Rating := Impl.Rating;
            Copy.Vote_Count := Impl.Vote_Count;
            Copy.For_Entity_Id := Impl.For_Entity_Id;
            Copy.For_Entity_Type := Impl.For_Entity_Type;
         end;
      end if;
      Into := Result;
   end Copy;

   procedure Find (Object  : in out Rating_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant Rating_Access := new Rating_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out Rating_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier) is
      Impl  : constant Rating_Access := new Rating_Impl;
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

   procedure Load (Object  : in out Rating_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean) is
      Impl  : constant Rating_Access := new Rating_Impl;
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

   procedure Save (Object  : in out Rating_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new Rating_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   procedure Delete (Object  : in out Rating_Ref;
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
   procedure Destroy (Object : access Rating_Impl) is
      type Rating_Impl_Ptr is access all Rating_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (Rating_Impl, Rating_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : Rating_Impl_Ptr := Rating_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   procedure Find (Object  : in out Rating_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, RATING_DEF'Access);
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
   procedure Load (Object  : in out Rating_Impl;
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

   procedure Save (Object  : in out Rating_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (RATING_DEF'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_1_NAME, --  id
                          Value => Object.Get_Key);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (2) then
         Stmt.Save_Field (Name  => COL_1_1_NAME, --  rating
                          Value => Object.Rating);
         Object.Clear_Modified (2);
      end if;
      if Object.Is_Modified (3) then
         Stmt.Save_Field (Name  => COL_2_1_NAME, --  vote_count
                          Value => Object.Vote_Count);
         Object.Clear_Modified (3);
      end if;
      if Object.Is_Modified (4) then
         Stmt.Save_Field (Name  => COL_3_1_NAME, --  for_entity_id
                          Value => Object.For_Entity_Id);
         Object.Clear_Modified (4);
      end if;
      if Object.Is_Modified (5) then
         Stmt.Save_Field (Name  => COL_4_1_NAME, --  for_entity_type
                          Value => Object.For_Entity_Type);
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

   procedure Create (Object  : in out Rating_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (RATING_DEF'Access);
      Result : Integer;
   begin
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_0_1_NAME, --  id
                        Value => Object.Get_Key);
      Query.Save_Field (Name  => COL_1_1_NAME, --  rating
                        Value => Object.Rating);
      Query.Save_Field (Name  => COL_2_1_NAME, --  vote_count
                        Value => Object.Vote_Count);
      Query.Save_Field (Name  => COL_3_1_NAME, --  for_entity_id
                        Value => Object.For_Entity_Id);
      Query.Save_Field (Name  => COL_4_1_NAME, --  for_entity_type
                        Value => Object.For_Entity_Type);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   procedure Delete (Object  : in out Rating_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (RATING_DEF'Access);
   begin
      Stmt.Set_Filter (Filter => "id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   function Get_Value (From : in Rating_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : constant ADO.Objects.Object_Record_Access := From.Get_Load_Object;
      Impl : access Rating_Impl;
   begin
      if Obj = null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Impl := Rating_Impl (Obj.all)'Access;
      if Name = "id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      elsif Name = "rating" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Rating));
      elsif Name = "vote_count" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Vote_Count));
      elsif Name = "for_entity_id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.For_Entity_Id));
      elsif Name = "for_entity_type" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.For_Entity_Type));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;



   --  ------------------------------
   --  Load the object from current iterator position
   --  ------------------------------
   procedure Load (Object  : in out Rating_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
   begin
      Object.Set_Key_Value (Stmt.Get_Identifier (0));
      Object.Rating := Stmt.Get_Integer (1);
      Object.Vote_Count := Stmt.Get_Integer (2);
      Object.For_Entity_Id := Stmt.Get_Identifier (3);
      Object.For_Entity_Type := ADO.Entity_Type (Stmt.Get_Integer (4));
      ADO.Objects.Set_Created (Object);
   end Load;
   function Vote_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => VOTE_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Vote_Key;

   function Vote_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => VOTE_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end Vote_Key;

   function "=" (Left, Right : Vote_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out Vote_Ref'Class;
                        Impl   : out Vote_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := Vote_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   procedure Allocate (Object : in out Vote_Ref) is
      Impl : Vote_Access;
   begin
      Impl := new Vote_Impl;
      Impl.Rating := 0;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: Vote
   -- ----------------------------------------

   procedure Set_Rating (Object : in out Vote_Ref;
                         Value  : in Integer) is
      Impl : Vote_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 1, Impl.Rating, Value);
   end Set_Rating;

   function Get_Rating (Object : in Vote_Ref)
                  return Integer is
      Impl : constant Vote_Access := Vote_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Rating;
   end Get_Rating;


   procedure Set_Id (Object : in out Vote_Ref;
                     Value  : in ADO.Identifier) is
      Impl : Vote_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 2, Value);
   end Set_Id;

   function Get_Id (Object : in Vote_Ref)
                  return ADO.Identifier is
      Impl : constant Vote_Access := Vote_Impl (Object.Get_Object.all)'Access;
   begin
      return Impl.Get_Key_Value;
   end Get_Id;


   procedure Set_Entity (Object : in out Vote_Ref;
                         Value  : in AWA.Votes.Models.Rating_Ref'Class) is
      Impl : Vote_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Object (Impl.all, 3, Impl.Entity, Value);
   end Set_Entity;

   function Get_Entity (Object : in Vote_Ref)
                  return AWA.Votes.Models.Rating_Ref'Class is
      Impl : constant Vote_Access := Vote_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Entity;
   end Get_Entity;


   procedure Set_User (Object : in out Vote_Ref;
                       Value  : in AWA.Users.Models.User_Ref'Class) is
      Impl : Vote_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Object (Impl.all, 4, Impl.User, Value);
   end Set_User;

   function Get_User (Object : in Vote_Ref)
                  return AWA.Users.Models.User_Ref'Class is
      Impl : constant Vote_Access := Vote_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.User;
   end Get_User;

   --  Copy of the object.
   procedure Copy (Object : in Vote_Ref;
                   Into   : in out Vote_Ref) is
      Result : Vote_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant Vote_Access
              := Vote_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant Vote_Access
              := new Vote_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.Rating := Impl.Rating;
            Copy.Entity := Impl.Entity;
            Copy.User := Impl.User;
         end;
      end if;
      Into := Result;
   end Copy;

   procedure Find (Object  : in out Vote_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant Vote_Access := new Vote_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out Vote_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier) is
      Impl  : constant Vote_Access := new Vote_Impl;
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

   procedure Load (Object  : in out Vote_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean) is
      Impl  : constant Vote_Access := new Vote_Impl;
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

   procedure Save (Object  : in out Vote_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new Vote_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   procedure Delete (Object  : in out Vote_Ref;
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
   procedure Destroy (Object : access Vote_Impl) is
      type Vote_Impl_Ptr is access all Vote_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (Vote_Impl, Vote_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : Vote_Impl_Ptr := Vote_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   procedure Find (Object  : in out Vote_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, VOTE_DEF'Access);
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
   procedure Load (Object  : in out Vote_Impl;
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

   procedure Save (Object  : in out Vote_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (VOTE_DEF'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_2_NAME, --  rating
                          Value => Object.Rating);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (2) then
         Stmt.Save_Field (Name  => COL_1_2_NAME, --  id
                          Value => Object.Get_Key);
         Object.Clear_Modified (2);
      end if;
      if Object.Is_Modified (3) then
         Stmt.Save_Field (Name  => COL_2_2_NAME, --  entity_id
                          Value => Object.Entity);
         Object.Clear_Modified (3);
      end if;
      if Object.Is_Modified (4) then
         Stmt.Save_Field (Name  => COL_3_2_NAME, --  user_id
                          Value => Object.User);
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

   procedure Create (Object  : in out Vote_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (VOTE_DEF'Access);
      Result : Integer;
   begin
      Query.Save_Field (Name  => COL_0_2_NAME, --  rating
                        Value => Object.Rating);
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_1_2_NAME, --  id
                        Value => Object.Get_Key);
      Query.Save_Field (Name  => COL_2_2_NAME, --  entity_id
                        Value => Object.Entity);
      Query.Save_Field (Name  => COL_3_2_NAME, --  user_id
                        Value => Object.User);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   procedure Delete (Object  : in out Vote_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (VOTE_DEF'Access);
   begin
      Stmt.Set_Filter (Filter => "id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   function Get_Value (From : in Vote_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : constant ADO.Objects.Object_Record_Access := From.Get_Load_Object;
      Impl : access Vote_Impl;
   begin
      if Obj = null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Impl := Vote_Impl (Obj.all)'Access;
      if Name = "rating" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Rating));
      elsif Name = "id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;



   --  ------------------------------
   --  Load the object from current iterator position
   --  ------------------------------
   procedure Load (Object  : in out Vote_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
   begin
      Object.Rating := Stmt.Get_Integer (0);
      Object.Set_Key_Value (Stmt.Get_Identifier (1));
      if not Stmt.Is_Null (2) then
         Object.Entity.Set_Key_Value (Stmt.Get_Identifier (2), Session);
      end if;
      if not Stmt.Is_Null (3) then
         Object.User.Set_Key_Value (Stmt.Get_Identifier (3), Session);
      end if;
      ADO.Objects.Set_Created (Object);
   end Load;

   procedure Op_Vote_Up (Bean    : in out Vote_Bean;
                         Outcome : in out Ada.Strings.Unbounded.Unbounded_String);
   procedure Op_Vote_Up (Bean    : in out Vote_Bean;
                         Outcome : in out Ada.Strings.Unbounded.Unbounded_String) is
   begin
      Vote_Bean'Class (Bean).Vote_Up (Outcome);
   end Op_Vote_Up;
   package Binding_Vote_Bean_1 is
     new ASF.Events.Faces.Actions.Action_Method.Bind (Bean   => Vote_Bean,
                                                      Method => Op_Vote_Up,
                                                      Name   => "vote_up");
   procedure Op_Vote_Down (Bean    : in out Vote_Bean;
                           Outcome : in out Ada.Strings.Unbounded.Unbounded_String);
   procedure Op_Vote_Down (Bean    : in out Vote_Bean;
                           Outcome : in out Ada.Strings.Unbounded.Unbounded_String) is
   begin
      Vote_Bean'Class (Bean).Vote_Down (Outcome);
   end Op_Vote_Down;
   package Binding_Vote_Bean_2 is
     new ASF.Events.Faces.Actions.Action_Method.Bind (Bean   => Vote_Bean,
                                                      Method => Op_Vote_Down,
                                                      Name   => "vote_down");

   Binding_Vote_Bean_Array : aliased constant Util.Beans.Methods.Method_Binding_Array
     := (1 => Binding_Vote_Bean_1.Proxy'Access,
         2 => Binding_Vote_Bean_2.Proxy'Access
     );

   --  This bean provides some methods that can be used in a Method_Expression.
   overriding
   function Get_Method_Bindings (From : in Vote_Bean)
                                 return Util.Beans.Methods.Method_Binding_Array_Access is
   begin
      return Binding_Vote_Bean_Array'Access;
   end Get_Method_Bindings;

   function Get_Value (From : in Vote_Bean;
                       Name : in String) return Util.Beans.Objects.Object is
   begin
      if Name = "permission" then
         return Util.Beans.Objects.To_Object (From.Permission);
      elsif Name = "entity_id" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Entity_Id));
      elsif Name = "rating" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Rating));
      elsif Name = "entity_type" then
         return Util.Beans.Objects.To_Object (From.Entity_Type);
      elsif Name = "total" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (From.Total));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;


   --  Set the value identified by the name
   overriding 
   procedure Set_Value (Item  : in out Vote_Bean;
                        Name  : in String;
                        Value : in Util.Beans.Objects.Object) is
   begin
      if Name = "permission" then
         Item.Permission := Util.Beans.Objects.To_Unbounded_String (Value);
      elsif Name = "entity_id" then
         Item.Entity_Id := ADO.Identifier (Util.Beans.Objects.To_Long_Long_Integer (Value));
      elsif Name = "rating" then
         Item.Rating := Util.Beans.Objects.To_Integer (Value);
      elsif Name = "entity_type" then
         Item.Entity_Type := Util.Beans.Objects.To_Unbounded_String (Value);
      elsif Name = "total" then
         Item.Total := Util.Beans.Objects.To_Integer (Value);
      end if;
   end Set_Value;




end AWA.Votes.Models;
