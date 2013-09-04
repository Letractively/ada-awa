-----------------------------------------------------------------------
--  awa-tags-beans -- Beans for the tags module
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
with Ada.Strings.Unbounded;
with Ada.Containers.Hashed_Maps;
with Ada.Finalization;

with Util.Beans.Basic;
with Util.Beans.Objects.Lists;
with Util.Beans.Lists.Strings;
with Util.Strings.Vectors;

with ADO;
with ADO.Utils;
with ADO.Schemas;
with ADO.Sessions;

with AWA.Tags.Models;
with AWA.Tags.Modules;
package AWA.Tags.Beans is

   type Tag_List_Bean is
     new Util.Beans.Objects.Lists.List_Bean and Util.Beans.Basic.Bean with private;

   type Tag_List_Bean_Access is access all Tag_List_Bean'Class;

   --  Set the value identified by the name.
   --  If the name cannot be found, the method should raise the No_Value
   --  exception.
   overriding
   procedure Set_Value (From  : in out Tag_List_Bean;
                        Name  : in String;
                        Value : in Util.Beans.Objects.Object);

   --  Set the entity type (database table) onto which the tags are associated.
   procedure Set_Entity_Type (Into  : in out Tag_List_Bean;
                              Table : in ADO.Schemas.Class_Mapping_Access);

   --  Set the permission to check before removing or adding a tag on the entity.
   procedure Set_Permission (Into       : in out Tag_List_Bean;
                             Permission : in String);

   --  Load the tags associated with the given database identifier.
   procedure Load_Tags (Into          : in out Tag_List_Bean;
                        Session       : in ADO.Sessions.Session;
                        For_Entity_Id : in ADO.Identifier);

   --  Set the list of tags to add.
   procedure Set_Added (Into  : in out Tag_List_Bean;
                        Tags  : in Util.Strings.Vectors.Vector);

   --  Set the list of tags to remove.
   procedure Set_Deleted (Into : in out Tag_List_Bean;
                          Tags : in Util.Strings.Vectors.Vector);

   --  Update the tags associated with the tag entity represented by <tt>For_Entity_Id</tt>.
   --  The list of tags defined by <tt>Set_Deleted</tt> are removed first and the list of
   --  tags defined by <tt>Set_Added</tt> are associated with the database entity.
   procedure Update_Tags (From          : in Tag_List_Bean;
                          For_Entity_Id : in ADO.Identifier);

   --  Create the tag list bean instance.
   function Create_Tag_List_Bean (Module : in AWA.Tags.Modules.Tag_Module_Access)
                                  return Util.Beans.Basic.Readonly_Bean_Access;

   type Tag_Search_Bean is
     new Util.Beans.Objects.Lists.List_Bean and Util.Beans.Basic.Bean with private;
   type Tag_Search_Bean_Access is access all Tag_Search_Bean'Class;

   --  Set the value identified by the name.
   --  If the name cannot be found, the method should raise the No_Value
   --  exception.
   overriding
   procedure Set_Value (From  : in out Tag_Search_Bean;
                        Name  : in String;
                        Value : in Util.Beans.Objects.Object);

   --  Search the tags that match the search string.
   procedure Search_Tags (Into    : in out Tag_Search_Bean;
                          Session : in ADO.Sessions.Session;
                          Search  : in String);

   --  Set the entity type (database table) onto which the tags are associated.
   procedure Set_Entity_Type (Into  : in out Tag_Search_Bean;
                              Table : in ADO.Schemas.Class_Mapping_Access);

   --  Create the tag search bean instance.
   function Create_Tag_Search_Bean (Module : in AWA.Tags.Modules.Tag_Module_Access)
                                    return Util.Beans.Basic.Readonly_Bean_Access;

   type Tag_Info_List_Bean is
     new AWA.Tags.Models.Tag_Info_List_Bean and Util.Beans.Basic.Bean with private;
   type Tag_Info_List_Bean_Access is access all Tag_Info_List_Bean'Class;

   --  Set the value identified by the name.
   --  If the name cannot be found, the method should raise the No_Value
   --  exception.
   overriding
   procedure Set_Value (From  : in out Tag_Info_List_Bean;
                        Name  : in String;
                        Value : in Util.Beans.Objects.Object);

   --  Load the list of tags.
   procedure Load_Tags (Into    : in out Tag_Info_List_Bean;
                        Session : in out ADO.Sessions.Session);

   --  Create the tag info list bean instance.
   function Create_Tag_Info_List_Bean (Module : in AWA.Tags.Modules.Tag_Module_Access)
                                       return Util.Beans.Basic.Readonly_Bean_Access;

   --  The <tt>Entity_Tag_Map</tt> contains a list of tags associated with some entities.
   --  It allows to retrieve from the database all the tags associated with several entities
   --  and get the list of tags for a given entity.
   type Entity_Tag_Map is new Ada.Finalization.Limited_Controlled with private;

   --  Get the list of tags associated with the given entity.
   --  Returns null if the entity does not have any tag.
   function Get_Tags (From       : in Entity_Tag_Map;
                      For_Entity : in ADO.Identifier)
                      return Util.Beans.Lists.Strings.List_Bean_Access;

   --  Get the list of tags associated with the given entity.
   --  Returns a null object if the entity does not have any tag.
   function Get_Tags (From       : in Entity_Tag_Map;
                      For_Entity : in ADO.Identifier)
                      return Util.Beans.Objects.Object;

   --  Release the list of tags.
   procedure Clear (List : in out Entity_Tag_Map);

   --  Load the list of tags associated with a list of entities.
   procedure Load_Tags (Into        : in out Entity_Tag_Map;
                        Session     : in out ADO.Sessions.Session'Class;
                        Entity_Type : in String;
                        List        : in ADO.Utils.Identifier_Vector);

   --  Release the list of tags.
   overriding
   procedure Finalize (List : in out Entity_Tag_Map);

private

   type Tag_List_Bean is
     new Util.Beans.Objects.Lists.List_Bean and Util.Beans.Basic.Bean with record
      Module      : AWA.Tags.Modules.Tag_Module_Access;
      Entity_Type : Ada.Strings.Unbounded.Unbounded_String;
      Permission  : Ada.Strings.Unbounded.Unbounded_String;
      Current     : Natural := 0;
      Added       : Util.Strings.Vectors.Vector;
      Deleted     : Util.Strings.Vectors.Vector;
   end record;

   type Tag_Search_Bean is
     new Util.Beans.Objects.Lists.List_Bean and Util.Beans.Basic.Bean with record
      Module      : AWA.Tags.Modules.Tag_Module_Access;
      Entity_Type : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   type Tag_Info_List_Bean is
     new AWA.Tags.Models.Tag_Info_List_Bean and Util.Beans.Basic.Bean with record
      Module      : AWA.Tags.Modules.Tag_Module_Access;
      Entity_Type : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   package Entity_Tag_Maps is
     new Ada.Containers.Hashed_Maps (Key_Type        => ADO.Identifier,
                                     Element_Type    => Util.Beans.Lists.Strings.List_Bean_Access,
                                     Hash            => ADO.Utils.Hash,
                                     Equivalent_Keys => ADO."=",
                                     "="             => Util.Beans.Lists.Strings."=");

   type Entity_Tag_Map is new Ada.Finalization.Limited_Controlled with record
      Tags : Entity_Tag_Maps.Map;
   end record;

end AWA.Tags.Beans;
