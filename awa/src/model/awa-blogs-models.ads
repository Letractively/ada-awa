-----------------------------------------------------------------------
--  AWA.Blogs.Models -- AWA.Blogs.Models
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
with ADO.Sessions;
with ADO.Objects;
with ADO.Statements;
with ADO.SQL;
with ADO.Schemas;
with ADO.Queries;
with ADO.Queries.Loaders;
with Ada.Calendar;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Util.Beans.Objects;
with Util.Beans.Objects.Enums;
with Util.Beans.Basic.Lists;
with AWA.Users.Models;
with AWA.Workspaces.Models;
package AWA.Blogs.Models is
   type Post_Status_Type is (POST_DRAFT, POST_PUBLISHED, POST_SCHEDULED);
   for Post_Status_Type use (POST_DRAFT => 0, POST_PUBLISHED => 1, POST_SCHEDULED => 2);
   package Post_Status_Type_Objects is
      new Util.Beans.Objects.Enums (Post_Status_Type);

   --  --------------------
   --  Blog 
   --  --------------------
   --  Create an object key for Blog.
   function Blog_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Blog from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Blog_Key (Id : in String) return ADO.Objects.Object_Key;

   type Blog_Ref is new ADO.Objects.Object_Ref with null record;

   Null_Blog : constant Blog_Ref;
   function "=" (Left, Right : Blog_Ref'Class) return Boolean;

   --  Set the blog identifier
   procedure Set_Id (Object : in out Blog_Ref;
                     Value  : in ADO.Identifier);

   --  Get the blog identifier
   function Get_Id (Object : in Blog_Ref)
                 return ADO.Identifier;
   --  Get 
   function Get_Version (Object : in Blog_Ref)
                 return Integer;

   --  Set the blog name
   procedure Set_Name (Object : in out Blog_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Name (Object : in out Blog_Ref;
                       Value : in String);

   --  Get the blog name
   function Get_Name (Object : in Blog_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Name (Object : in Blog_Ref)
                 return String;

   --  Set the blog uuid
   procedure Set_Uid (Object : in out Blog_Ref;
                      Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Uid (Object : in out Blog_Ref;
                      Value : in String);

   --  Get the blog uuid
   function Get_Uid (Object : in Blog_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Uid (Object : in Blog_Ref)
                 return String;

   --  Set the blog creation date
   procedure Set_Create_Date (Object : in out Blog_Ref;
                              Value  : in Ada.Calendar.Time);

   --  Get the blog creation date
   function Get_Create_Date (Object : in Blog_Ref)
                 return Ada.Calendar.Time;

   --  Set 
   procedure Set_Workspace (Object : in out Blog_Ref;
                            Value  : in AWA.Workspaces.Models.Workspace_Ref'Class);

   --  Get 
   function Get_Workspace (Object : in Blog_Ref)
                 return AWA.Workspaces.Models.Workspace_Ref'Class;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Blog_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Blog_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Blog_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Blog_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Blog_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (Item : in Blog_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   BLOG_TABLE : aliased constant ADO.Schemas.Class_Mapping;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Blog_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Blog_Ref;
                   Into   : in out Blog_Ref);

   package Blog_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Natural,
                                  Element_Type => Blog_Ref,
                                  "="          => "=");
   subtype Blog_Vector is Blog_Vectors.Vector;

   procedure List (Object  : in out Blog_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);
   --  --------------------
   --  Post in a blog
   --  --------------------
   --  Create an object key for Post.
   function Post_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Post from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Post_Key (Id : in String) return ADO.Objects.Object_Key;

   type Post_Ref is new ADO.Objects.Object_Ref with null record;

   Null_Post : constant Post_Ref;
   function "=" (Left, Right : Post_Ref'Class) return Boolean;

   --  Set the post identifier
   procedure Set_Id (Object : in out Post_Ref;
                     Value  : in ADO.Identifier);

   --  Get the post identifier
   function Get_Id (Object : in Post_Ref)
                 return ADO.Identifier;
   --  Get 
   function Get_Version (Object : in Post_Ref)
                 return Integer;

   --  Set the post title
   procedure Set_Title (Object : in out Post_Ref;
                        Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Title (Object : in out Post_Ref;
                        Value : in String);

   --  Get the post title
   function Get_Title (Object : in Post_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Title (Object : in Post_Ref)
                 return String;

   --  Set the uri
   procedure Set_Uri (Object : in out Post_Ref;
                      Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Uri (Object : in out Post_Ref;
                      Value : in String);

   --  Get the uri
   function Get_Uri (Object : in Post_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Uri (Object : in Post_Ref)
                 return String;

   --  Set the blog text content
   procedure Set_Text (Object : in out Post_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Text (Object : in out Post_Ref;
                       Value : in String);

   --  Get the blog text content
   function Get_Text (Object : in Post_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Text (Object : in Post_Ref)
                 return String;

   --  Set the post creation date
   procedure Set_Create_Date (Object : in out Post_Ref;
                              Value  : in Ada.Calendar.Time);

   --  Get the post creation date
   function Get_Create_Date (Object : in Post_Ref)
                 return Ada.Calendar.Time;

   --  Set the post publication date
   procedure Set_Publish_Date (Object : in out Post_Ref;
                               Value  : in ADO.Nullable_Time);

   --  Get the post publication date
   function Get_Publish_Date (Object : in Post_Ref)
                 return ADO.Nullable_Time;

   --  Set the post status
   procedure Set_Status (Object : in out Post_Ref;
                         Value  : in Post_Status_Type);

   --  Get the post status
   function Get_Status (Object : in Post_Ref)
                 return Post_Status_Type;

   --  Set 
   procedure Set_Author (Object : in out Post_Ref;
                         Value  : in AWA.Users.Models.User_Ref'Class);

   --  Get 
   function Get_Author (Object : in Post_Ref)
                 return AWA.Users.Models.User_Ref'Class;

   --  Set 
   procedure Set_Blog (Object : in out Post_Ref;
                       Value  : in Blog_Ref'Class);

   --  Get 
   function Get_Blog (Object : in Post_Ref)
                 return Blog_Ref'Class;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Post_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Post_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Post_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Post_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Post_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (Item : in Post_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   POST_TABLE : aliased constant ADO.Schemas.Class_Mapping;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Post_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Post_Ref;
                   Into   : in out Post_Ref);

   package Post_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Natural,
                                  Element_Type => Post_Ref,
                                  "="          => "=");
   subtype Post_Vector is Post_Vectors.Vector;

   procedure List (Object  : in out Post_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);

   --  --------------------
   --  
   --  --------------------
   type Admin_Post_Info is new Util.Beans.Basic.Readonly_Bean with record
      --  the post identifier.
      Id : ADO.Identifier;

      --  the post title.
      Title : Ada.Strings.Unbounded.Unbounded_String;

      --  the post uri.
      Uri : Ada.Strings.Unbounded.Unbounded_String;

      --  the post publish date.
      Date : Ada.Calendar.Time;

      --  the user name.
      Username : Ada.Strings.Unbounded.Unbounded_String;

   end record;

   --  Get the bean attribute identified by the given name.
   overriding
   function Get_Value (From : in Admin_Post_Info;
                       Name : in String) return Util.Beans.Objects.Object;

   package Admin_Post_Info_Beans is
      new Util.Beans.Basic.Lists (Element_Type => Admin_Post_Info);
   package Admin_Post_Info_Vectors renames Admin_Post_Info_Beans.Vectors;
   subtype Admin_Post_Info_List_Bean is Admin_Post_Info_Beans.List_Bean;

   type Admin_Post_Info_List_Bean_Access is access all Admin_Post_Info_List_Bean;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out Admin_Post_Info_List_Bean;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   subtype Admin_Post_Info_Vector is Admin_Post_Info_Vectors.Vector;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out Admin_Post_Info_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   Query_Blog_Admin_Post_List : constant ADO.Queries.Query_Definition_Access;

   --  --------------------
   --  
   --  --------------------
   type Post_Info is new Util.Beans.Basic.Readonly_Bean with record
      --  the post identifier.
      Id : ADO.Identifier;

      --  the post title.
      Title : Ada.Strings.Unbounded.Unbounded_String;

      --  the post uri.
      Uri : Ada.Strings.Unbounded.Unbounded_String;

      --  the post publish date.
      Date : Ada.Calendar.Time;

      --  the user name.
      Username : Ada.Strings.Unbounded.Unbounded_String;

      --  the post text.
      Text : Ada.Strings.Unbounded.Unbounded_String;

   end record;

   --  Get the bean attribute identified by the given name.
   overriding
   function Get_Value (From : in Post_Info;
                       Name : in String) return Util.Beans.Objects.Object;

   package Post_Info_Beans is
      new Util.Beans.Basic.Lists (Element_Type => Post_Info);
   package Post_Info_Vectors renames Post_Info_Beans.Vectors;
   subtype Post_Info_List_Bean is Post_Info_Beans.List_Bean;

   type Post_Info_List_Bean_Access is access all Post_Info_List_Bean;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out Post_Info_List_Bean;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   subtype Post_Info_Vector is Post_Info_Vectors.Vector;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out Post_Info_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   Query_Blog_Post_List : constant ADO.Queries.Query_Definition_Access;

   --  --------------------
   --  
   --  --------------------
   type Blog_Info is new Util.Beans.Basic.Readonly_Bean with record
      --  the blog identifier.
      Id : ADO.Identifier;

      --  the blog title.
      Title : Ada.Strings.Unbounded.Unbounded_String;

      --  the blog uuid.
      Uid : Ada.Strings.Unbounded.Unbounded_String;

      --  the blog creation date.
      Create_Date : Ada.Calendar.Time;

   end record;

   --  Get the bean attribute identified by the given name.
   overriding
   function Get_Value (From : in Blog_Info;
                       Name : in String) return Util.Beans.Objects.Object;

   package Blog_Info_Beans is
      new Util.Beans.Basic.Lists (Element_Type => Blog_Info);
   package Blog_Info_Vectors renames Blog_Info_Beans.Vectors;
   subtype Blog_Info_List_Bean is Blog_Info_Beans.List_Bean;

   type Blog_Info_List_Bean_Access is access all Blog_Info_List_Bean;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out Blog_Info_List_Bean;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   subtype Blog_Info_Vector is Blog_Info_Vectors.Vector;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out Blog_Info_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   Query_Blog_List : constant ADO.Queries.Query_Definition_Access;


private
   BLOG_NAME : aliased constant String := "blog";
   COL_0_1_NAME : aliased constant String := "id";
   COL_1_1_NAME : aliased constant String := "version";
   COL_2_1_NAME : aliased constant String := "name";
   COL_3_1_NAME : aliased constant String := "uid";
   COL_4_1_NAME : aliased constant String := "create_date";
   COL_5_1_NAME : aliased constant String := "workspace_id";
   BLOG_TABLE : aliased constant ADO.Schemas.Class_Mapping :=
     (Count => 6,
      Table => BLOG_NAME'Access,
      Members => (
         COL_0_1_NAME'Access,
         COL_1_1_NAME'Access,
         COL_2_1_NAME'Access,
         COL_3_1_NAME'Access,
         COL_4_1_NAME'Access,
         COL_5_1_NAME'Access
)
     );
   Null_Blog : constant Blog_Ref
      := Blog_Ref'(ADO.Objects.Object_Ref with others => <>);
   type Blog_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => BLOG_TABLE'Access)
   with record
       Version : Integer;
       Name : Ada.Strings.Unbounded.Unbounded_String;
       Uid : Ada.Strings.Unbounded.Unbounded_String;
       Create_Date : Ada.Calendar.Time;
       Workspace : AWA.Workspaces.Models.Workspace_Ref;
   end record;
   type Blog_Access is access all Blog_Impl;
   overriding
   procedure Destroy (Object : access Blog_Impl);
   overriding
   procedure Find (Object  : in out Blog_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);
   overriding
   procedure Load (Object  : in out Blog_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Blog_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);
   overriding
   procedure Save (Object  : in out Blog_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);
   procedure Create (Object  : in out Blog_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);
   overriding
   procedure Delete (Object  : in out Blog_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);
   procedure Set_Field (Object : in out Blog_Ref'Class;
                        Impl   : out Blog_Access);
   POST_NAME : aliased constant String := "blog_post";
   COL_0_2_NAME : aliased constant String := "id";
   COL_1_2_NAME : aliased constant String := "version";
   COL_2_2_NAME : aliased constant String := "title";
   COL_3_2_NAME : aliased constant String := "uri";
   COL_4_2_NAME : aliased constant String := "text";
   COL_5_2_NAME : aliased constant String := "create_date";
   COL_6_2_NAME : aliased constant String := "publish_date";
   COL_7_2_NAME : aliased constant String := "status";
   COL_8_2_NAME : aliased constant String := "author_id";
   COL_9_2_NAME : aliased constant String := "blog_id";
   POST_TABLE : aliased constant ADO.Schemas.Class_Mapping :=
     (Count => 10,
      Table => POST_NAME'Access,
      Members => (
         COL_0_2_NAME'Access,
         COL_1_2_NAME'Access,
         COL_2_2_NAME'Access,
         COL_3_2_NAME'Access,
         COL_4_2_NAME'Access,
         COL_5_2_NAME'Access,
         COL_6_2_NAME'Access,
         COL_7_2_NAME'Access,
         COL_8_2_NAME'Access,
         COL_9_2_NAME'Access
)
     );
   Null_Post : constant Post_Ref
      := Post_Ref'(ADO.Objects.Object_Ref with others => <>);
   type Post_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => POST_TABLE'Access)
   with record
       Version : Integer;
       Title : Ada.Strings.Unbounded.Unbounded_String;
       Uri : Ada.Strings.Unbounded.Unbounded_String;
       Text : Ada.Strings.Unbounded.Unbounded_String;
       Create_Date : Ada.Calendar.Time;
       Publish_Date : ADO.Nullable_Time;
       Status : Post_Status_Type;
       Author : AWA.Users.Models.User_Ref;
       Blog : Blog_Ref;
   end record;
   type Post_Access is access all Post_Impl;
   overriding
   procedure Destroy (Object : access Post_Impl);
   overriding
   procedure Find (Object  : in out Post_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);
   overriding
   procedure Load (Object  : in out Post_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Post_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);
   overriding
   procedure Save (Object  : in out Post_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);
   procedure Create (Object  : in out Post_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);
   overriding
   procedure Delete (Object  : in out Post_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);
   procedure Set_Field (Object : in out Post_Ref'Class;
                        Impl   : out Post_Access);

   package File_Adminpostinfo is
      new ADO.Queries.Loaders.File (Path => "blog-admin-post-list.xml",
                                    Sha1 => "DA3E693F256D9D9914791FF2C73C8B2E033AFA8E");

   package Def_Adminpostinfo_Blog_Admin_Post_List is
      new ADO.Queries.Loaders.Query (Name => "blog-admin-post-list",
                                     File => File_Adminpostinfo.File'Access);
   Query_Blog_Admin_Post_List : constant ADO.Queries.Query_Definition_Access
   := Def_Adminpostinfo_Blog_Admin_Post_List.Query'Access;

   package File_Postinfo is
      new ADO.Queries.Loaders.File (Path => "blog-post-list.xml",
                                    Sha1 => "F61889EED51F4277BE7D979A3A2657A506FA0406");

   package Def_Postinfo_Blog_Post_List is
      new ADO.Queries.Loaders.Query (Name => "blog-post-list",
                                     File => File_Postinfo.File'Access);
   Query_Blog_Post_List : constant ADO.Queries.Query_Definition_Access
   := Def_Postinfo_Blog_Post_List.Query'Access;

   package File_Bloginfo is
      new ADO.Queries.Loaders.File (Path => "blog-list.xml",
                                    Sha1 => "F4F57D21CFAF56A121532B852D9C38D4ECEFDA64");

   package Def_Bloginfo_Blog_List is
      new ADO.Queries.Loaders.Query (Name => "blog-list",
                                     File => File_Bloginfo.File'Access);
   Query_Blog_List : constant ADO.Queries.Query_Definition_Access
   := Def_Bloginfo_Blog_List.Query'Access;
end AWA.Blogs.Models;
