-----------------------------------------------------------------------
--  Atlas.Microblog.Models -- Atlas.Microblog.Models
-----------------------------------------------------------------------
--  File generated by ada-gen DO NOT MODIFY
--  Template used: templates/model/package-spec.xhtml
--  Ada Generator: https://ada-gen.googlecode.com/svn/trunk Revision 313
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
package Atlas.Microblog.Models is
   --  --------------------
   --  The mblog table.
   --  --------------------
   --  Create an object key for Mblog.
   function Mblog_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Mblog from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Mblog_Key (Id : in String) return ADO.Objects.Object_Key;

   type Mblog_Ref is new ADO.Objects.Object_Ref with null record;

   Null_Mblog : constant Mblog_Ref;
   function "=" (Left, Right : Mblog_Ref'Class) return Boolean;

   --  Set the mblog id
   procedure Set_Id (Object : in out Mblog_Ref;
                     Value  : in ADO.Identifier);

   --  Get the mblog id
   function Get_Id (Object : in Mblog_Ref)
                 return ADO.Identifier;
   --  Get the mblog version
   function Get_Version (Object : in Mblog_Ref)
                 return Integer;

   --  Set the mblog message
   procedure Set_Message (Object : in out Mblog_Ref;
                          Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Message (Object : in out Mblog_Ref;
                          Value : in String);

   --  Get the mblog message
   function Get_Message (Object : in Mblog_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Message (Object : in Mblog_Ref)
                 return String;

   --  Set the mblog creation date
   procedure Set_Create_Date (Object : in out Mblog_Ref;
                              Value  : in Ada.Calendar.Time);

   --  Get the mblog creation date
   function Get_Create_Date (Object : in Mblog_Ref)
                 return Ada.Calendar.Time;

   --  Set the post author
   procedure Set_Author (Object : in out Mblog_Ref;
                         Value  : in AWA.Users.Models.User_Ref'Class);

   --  Get the post author
   function Get_Author (Object : in Mblog_Ref)
                 return AWA.Users.Models.User_Ref'Class;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Mblog_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Mblog_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Mblog_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Mblog_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Mblog_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (Item : in Mblog_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   MBLOG_TABLE : aliased constant ADO.Schemas.Class_Mapping;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Mblog_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Mblog_Ref;
                   Into   : in out Mblog_Ref);

   package Mblog_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Natural,
                                  Element_Type => Mblog_Ref,
                                  "="          => "=");
   subtype Mblog_Vector is Mblog_Vectors.Vector;

   procedure List (Object  : in out Mblog_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);


private
   MBLOG_NAME : aliased constant String := "mblog";
   COL_0_1_NAME : aliased constant String := "id";
   COL_1_1_NAME : aliased constant String := "version";
   COL_2_1_NAME : aliased constant String := "message";
   COL_3_1_NAME : aliased constant String := "create_date";
   COL_4_1_NAME : aliased constant String := "author_id";
   MBLOG_TABLE : aliased constant ADO.Schemas.Class_Mapping :=
     (Count => 5,
      Table => MBLOG_NAME'Access,
      Members => (
         COL_0_1_NAME'Access,
         COL_1_1_NAME'Access,
         COL_2_1_NAME'Access,
         COL_3_1_NAME'Access,
         COL_4_1_NAME'Access
)
     );
   Null_Mblog : constant Mblog_Ref
      := Mblog_Ref'(ADO.Objects.Object_Ref with others => <>);
   type Mblog_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => MBLOG_TABLE'Access)
   with record
       Version : Integer;
       Message : Ada.Strings.Unbounded.Unbounded_String;
       Create_Date : Ada.Calendar.Time;
       Author : AWA.Users.Models.User_Ref;
   end record;
   type Mblog_Access is access all Mblog_Impl;
   overriding
   procedure Destroy (Object : access Mblog_Impl);
   overriding
   procedure Find (Object  : in out Mblog_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);
   overriding
   procedure Load (Object  : in out Mblog_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Mblog_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);
   overriding
   procedure Save (Object  : in out Mblog_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);
   procedure Create (Object  : in out Mblog_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);
   overriding
   procedure Delete (Object  : in out Mblog_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);
   procedure Set_Field (Object : in out Mblog_Ref'Class;
                        Impl   : out Mblog_Access);
end Atlas.Microblog.Models;
