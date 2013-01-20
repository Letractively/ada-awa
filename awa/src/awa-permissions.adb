-----------------------------------------------------------------------
--  awa-permissions -- Permissions module
--  Copyright (C) 2011, 2012, 2013 Stephane Carrez
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

with Util.Log.Loggers;
with Util.Beans.Objects;
with Util.Serialize.Mappers.Record_Mapper;

with ADO.Schemas.Entities;
with ADO.Sessions.Entities;

with Security.Contexts;

with AWA.Services.Contexts;
with AWA.Permissions.Controllers;
package body AWA.Permissions is

   Log : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("AWA.Permissions");

   --  ------------------------------
   --  Verify that the permission represented by <b>Permission</b> is granted.
   --  ------------------------------
   procedure Check (Permission : in Security.Permissions.Permission_Index) is
   begin
      if not (Security.Contexts.Has_Permission (Permission)) then
         raise NO_PERMISSION;
      end if;
   end Check;

   --  ------------------------------
   --  Verify that the permission represented by <b>Permission</b> is granted to access the
   --  database entity represented by <b>Entity</b>.
   --  ------------------------------
   procedure Check (Permission : in Security.Permissions.Permission_Index;
                    Entity     : in ADO.Identifier) is
      use type Security.Contexts.Security_Context_Access;

      Context : constant Security.Contexts.Security_Context_Access := Security.Contexts.Current;
      Perm    : Entity_Permission (Permission);
   begin
      if Context = null then
         Log.Debug ("Permission is refused because there is no security context");
         raise NO_PERMISSION;
      end if;
      Perm.Entity := Entity;
      if not Context.Has_Permission (Perm) then
         Log.Debug ("Permission is refused by the security controller");
         raise NO_PERMISSION;
      end if;
   end Check;

   --  ------------------------------
   --  Verify that the permission represented by <b>Permission</b> is granted to access the
   --  database entity represented by <b>Entity</b>.
   --  ------------------------------
   procedure Check (Permission : in Security.Permissions.Permission_Index;
                    Entity     : in ADO.Objects.Object_Ref'Class) is
   begin
      if Entity.Is_Null then
         Log.Debug ("Permission is refused because the entity is null.");
         raise NO_PERMISSION;
      end if;
      Check (Permission, ADO.Objects.Get_Value (Entity.Get_Key));
   end Check;

   type Controller_Config is record
      Name    : Util.Beans.Objects.Object;
      SQL     : Util.Beans.Objects.Object;
      Entity  : ADO.Entity_Type := 0;
      Count   : Natural := 0;
      Manager : Entity_Policy_Access;
      Session : ADO.Sessions.Session;
   end record;

   type Config_Fields is (FIELD_NAME, FIELD_ENTITY_TYPE, FIELD_ENTITY_PERMISSION, FIELD_SQL);

   type Controller_Config_Access is access all Controller_Config;

   procedure Set_Member (Into  : in out Controller_Config;
                         Field : in Config_Fields;
                         Value : in Util.Beans.Objects.Object);

   --  ------------------------------
   --  Called while parsing the XML policy file when the <name>, <entity-type>, <sql> and
   --  <entity-permission> XML entities are found.  Create the new permission when the complete
   --  permission definition has been parsed and save the permission in the security manager.
   --  ------------------------------
   procedure Set_Member (Into  : in out Controller_Config;
                         Field : in Config_Fields;
                         Value : in Util.Beans.Objects.Object) is
      use AWA.Permissions.Controllers;
      use type ADO.Entity_Type;
   begin
      case Field is
         when FIELD_NAME =>
            Into.Name := Value;

         when FIELD_SQL =>
            Into.SQL := Value;

         when FIELD_ENTITY_TYPE =>
            declare
               Name : constant String := Util.Beans.Objects.To_String (Value);
            begin
               Into.Entity := ADO.Sessions.Entities.Find_Entity_Type (Into.Session, Name);

            exception
               when ADO.Schemas.Entities.No_Entity_Type =>
                  raise Util.Serialize.Mappers.Field_Error with "Invalid entity type: " & Name;
            end;

         when FIELD_ENTITY_PERMISSION =>
            declare
               Name : constant String := Util.Beans.Objects.To_String (Into.Name);
            begin
               if Into.Entity = 0 then
                  raise Util.Serialize.Mappers.Field_Error
                  with "Permission '" & Name & "' ignored: missing entity type";
               end if;
               declare
                  SQL  : constant String := Util.Beans.Objects.To_String (Into.SQL);
                  Perm : constant Entity_Controller_Access
                    := new Entity_Controller '(Len    => SQL'Length,
                                               SQL    => SQL,
                                               Entity => Into.Entity);
               begin
                  Into.Manager.Add_Permission (Name, Perm.all'Access);
                  Into.Count := 0;
                  Into.Entity := 0;
               end;
            end;

      end case;
   end Set_Member;

   package Config_Mapper is
     new Util.Serialize.Mappers.Record_Mapper (Element_Type        => Controller_Config,
                                               Element_Type_Access => Controller_Config_Access,
                                               Fields              => Config_Fields,
                                               Set_Member          => Set_Member);

   Mapper : aliased Config_Mapper.Mapper;

   --  ------------------------------
   --  Setup the XML parser to read the <b>entity-permission</b> description.  For example:
   --
   --  <entity-permission>
   --     <name>create-workspace</name>
   --     <entity-type>WORKSPACE</entity-type>
   --     <sql>select acl.id from acl where ...</sql>
   --  </entity-permission>
   --
   --  This defines a permission <b>create-workspace</b> that will be granted if the
   --  SQL statement returns a non empty list.
   --  ------------------------------

   --  ------------------------------
   --  Get the policy name.
   --  ------------------------------
   overriding
   function Get_Name (From : in Entity_Policy) return String is
      pragma Unreferenced (From);
   begin
      return NAME;
   end Get_Name;

   --  ------------------------------
   --  Setup the XML parser to read the <b>policy</b> description.
   --  ------------------------------
   overriding
   procedure Prepare_Config (Policy : in out Entity_Policy;
                             Reader : in out Util.Serialize.IO.XML.Parser) is
      Config : constant Controller_Config_Access := new Controller_Config;
   begin
      Reader.Add_Mapping ("policy-rules", Mapper'Access);
      Reader.Add_Mapping ("module", Mapper'Access);
      Config.Manager := Policy'Unchecked_Access;
      Config.Session := AWA.Services.Contexts.Get_Session (AWA.Services.Contexts.Current);
      Config_Mapper.Set_Context (Reader, Config);
   end Prepare_Config;

begin
   Mapper.Add_Mapping ("entity-permission", FIELD_ENTITY_PERMISSION);
   Mapper.Add_Mapping ("entity-permission/name", FIELD_NAME);
   Mapper.Add_Mapping ("entity-permission/entity-type", FIELD_ENTITY_TYPE);
   Mapper.Add_Mapping ("entity-permission/sql", FIELD_SQL);
end AWA.Permissions;
