-----------------------------------------------------------------------
--  awa-applications-configs -- Read application configuration files
--  Copyright (C) 2011, 2012 Stephane Carrez
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
with Util.Serialize.IO.XML;

with ASF.Contexts.Faces;
with ASF.Applications.Main.Configs;

with Security.Permissions;
with Security.Controllers.Roles;
with AWA.Permissions.Configs;
with AWA.Events.Configs;
with AWA.Services.Contexts;

package body AWA.Applications.Configs is

   use Util.Log;

   Log : constant Loggers.Logger := Loggers.Create ("AWA.Applications.Configs");

   --  ------------------------------
   --  Read the application configuration file and configure the application
   --  ------------------------------
   procedure Read_Configuration (App     : in out Application'Class;
                                 File    : in String;
                                 Context : in EL.Contexts.Default.Default_Context_Access) is

      Reader     : Util.Serialize.IO.XML.Parser;

      App_Access : constant ASF.Contexts.Faces.Application_Access := App'Unchecked_Access;
      Ctx : AWA.Services.Contexts.Service_Context;
      Sec : constant Security.Permissions.Permission_Manager_Access
        := App.Get_Permission_Manager;

   begin
      Log.Info ("Reading application configuration file {0}", File);

      Ctx.Set_Context (App'Unchecked_Access, null);
      declare
         package Bean_Config is
           new ASF.Applications.Main.Configs.Reader_Config (Reader, App_Access,
                                                            Context.all'Access);
         package Policy_Config is
           new Security.Permissions.Reader_Config (Reader, Sec);
         package Role_Config is
           new Security.Controllers.Roles.Reader_Config (Reader, Sec);
         package Entity_Config is
           new AWA.Permissions.Configs.Reader_Config (Reader, Sec);
         package Event_Config is
            new AWA.Events.Configs.Reader_Config (Reader  => Reader,
                                                  Manager => App.Events'Unchecked_Access,
                                                  Context => Context.all'Access);

         pragma Warnings (Off, Bean_Config);
         pragma Warnings (Off, Policy_Config);
         pragma Warnings (Off, Role_Config);
         pragma Warnings (Off, Entity_Config);
         pragma Warnings (Off, Event_Config);
      begin
         if Log.Get_Level >= Util.Log.DEBUG_LEVEL then
            Util.Serialize.IO.Dump (Reader, Log);
         end if;

         --  Read the configuration file and record managed beans, navigation rules.
         Reader.Parse (File);

      exception
         when E : others =>
            Log.Error ("Error while reading {0}", File);
            raise;
      end;
   end Read_Configuration;

end AWA.Applications.Configs;
