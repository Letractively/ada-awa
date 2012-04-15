-----------------------------------------------------------------------
--  AWA.Comments.Models -- AWA.Comments.Models
-----------------------------------------------------------------------
--  File generated by ada-gen DO NOT MODIFY
--  Template used: templates/model/package-spec.xhtml
--  Ada Generator: https://ada-gen.googlecode.com/svn/trunk Revision 166
-----------------------------------------------------------------------
--  Copyright (C) 2011 Stephane Carrez
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
pragma Warnings (Off, "unit * is not referenced");
with ADO.Sessions;
with ADO.Objects;
with ADO.Statements;
with ADO.SQL;
with ADO.Schemas;
with Ada.Calendar;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Util.Beans.Objects;
with Util.Beans.Basic.Lists;
with AWA.Users.Models;
pragma Warnings (On, "unit * is not referenced");
package AWA.Comments.Models is
   --  Create an object key for Comment.
   function Comment_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Comment from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Comment_Key (Id : in String) return ADO.Objects.Object_Key;

   type Comment_Ref is new ADO.Objects.Object_Ref with null record;

   Null_Comment : constant Comment_Ref;
   function "=" (Left, Right : Comment_Ref'Class) return Boolean;

   --  Set 
   procedure Set_Id (Object : in out Comment_Ref;
                     Value  : in ADO.Identifier);

   --  Get 
   function Get_Id (Object : in Comment_Ref)
                 return ADO.Identifier;
   --  Get 
   function Get_Version (Object : in Comment_Ref)
                 return Integer;

   --  Set 
   procedure Set_Date (Object : in out Comment_Ref;
                       Value  : in Ada.Calendar.Time);

   --  Get 
   function Get_Date (Object : in Comment_Ref)
                 return Ada.Calendar.Time;

   --  Set 
   procedure Set_Message (Object : in out Comment_Ref;
                          Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Message (Object : in out Comment_Ref;
                          Value : in String);

   --  Get 
   function Get_Message (Object : in Comment_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Message (Object : in Comment_Ref)
                 return String;

   --  Set 
   procedure Set_Entity_Id (Object : in out Comment_Ref;
                            Value  : in ADO.Identifier);

   --  Get 
   function Get_Entity_Id (Object : in Comment_Ref)
                 return ADO.Identifier;

   --  Set 
   procedure Set_User (Object : in out Comment_Ref;
                       Value  : in AWA.Users.Models.User_Ref'Class);

   --  Get 
   function Get_User (Object : in Comment_Ref)
                 return AWA.Users.Models.User_Ref'Class;

   --  Set 
   procedure Set_Entity_Type (Object : in out Comment_Ref;
                              Value  : in ADO.Entity_Type);

   --  Get 
   function Get_Entity_Type (Object : in Comment_Ref)
                 return ADO.Entity_Type;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Comment_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (Item : in Comment_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   COMMENT_TABLE : aliased constant ADO.Schemas.Class_Mapping;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Comment_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Comment_Ref;
                   Into   : in out Comment_Ref);

   package Comment_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Natural,
                                  Element_Type => Comment_Ref,
                                  "="          => "=");
   subtype Comment_Vector is Comment_Vectors.Vector;

   procedure List (Object  : in out Comment_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);


private
   COMMENT_NAME : aliased constant String := "comments";
   COL_0_1_NAME : aliased constant String := "id";
   COL_1_1_NAME : aliased constant String := "version";
   COL_2_1_NAME : aliased constant String := "date";
   COL_3_1_NAME : aliased constant String := "message";
   COL_4_1_NAME : aliased constant String := "entity_id";
   COL_5_1_NAME : aliased constant String := "user_fk";
   COL_6_1_NAME : aliased constant String := "entity__type_fk";
   COMMENT_TABLE : aliased constant ADO.Schemas.Class_Mapping :=
     (Count => 7,
      Table => COMMENT_NAME'Access,
      Members => (
         COL_0_1_NAME'Access,
         COL_1_1_NAME'Access,
         COL_2_1_NAME'Access,
         COL_3_1_NAME'Access,
         COL_4_1_NAME'Access,
         COL_5_1_NAME'Access,
         COL_6_1_NAME'Access
)
     );
   Null_Comment : constant Comment_Ref
      := Comment_Ref'(ADO.Objects.Object_Ref with others => <>);
   type Comment_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => COMMENT_TABLE'Access)
   with record
       Version : Integer;
       Date : Ada.Calendar.Time;
       Message : Ada.Strings.Unbounded.Unbounded_String;
       Entity_Id : ADO.Identifier;
       User : AWA.Users.Models.User_Ref;
       Entity_Type : ADO.Entity_Type;
   end record;
   type Comment_Access is access all Comment_Impl;
   overriding
   procedure Destroy (Object : access Comment_Impl);
   overriding
   procedure Find (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);
   overriding
   procedure Load (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Comment_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);
   overriding
   procedure Save (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);
   procedure Create (Object  : in out Comment_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);
   overriding
   procedure Delete (Object  : in out Comment_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);
   procedure Set_Field (Object : in out Comment_Ref'Class;
                        Impl   : out Comment_Access);
end AWA.Comments.Models;
