-----------------------------------------------------------------------
--  awa-settings-modules -- Module awa-settings
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
with ASF.Applications;
with Ada.Strings.Unbounded;
with AWA.Modules;
package AWA.Settings.Modules is

   --  The name under which the module is registered.
   NAME : constant String := "awa-settings";

   --  The settings manager controls the creation and update of user settings.
   --  It maintains a small LRU cache of user settings that have been loaded and
   --  used by the application.  The settings manager is intended to be stored as
   --  an HTTP session attribute.
   type Setting_Manager is new AWA.Modules.Module_Manager with private;
   type Setting_Manager_Access is access all Setting_Manager'Class;

   --  Set the user setting with the given name in the setting manager cache
   --  and in the database.
   procedure Set (Manager : in out Setting_Manager;
                  Name    : in String;
                  Value   : in String);

   --  Get the user setting with the given name from the setting manager cache.
   --  Load the user setting from the database if necessary.
   procedure Get (Manager : in out Setting_Manager;
                  Name    : in String;
                  Default : in String;
                  Value   : out Ada.Strings.Unbounded.Unbounded_String);

   --  Get the current setting manager for the current user.
   function Current return Setting_Manager_Access;

   --  ------------------------------
   --  Module awa-settings
   --  ------------------------------
   type Setting_Module is new AWA.Modules.Module with private;
   type Setting_Module_Access is access all Setting_Module'Class;

   --  Initialize the settings module.
   overriding
   procedure Initialize (Plugin : in out Setting_Module;
                         App    : in AWA.Modules.Application_Access;
                         Props  : in ASF.Applications.Config);

   --  Get the settings module.
   function Get_Setting_Module return Setting_Module_Access;


private

   type Setting_Module is new AWA.Modules.Module with null record;

   type Setting_Data;
   type Setting_Data_Access is access all Setting_Data;

   type Setting_Data is limited record
      Next_Setting : Setting_Data_Access;
      Name         : Ada.Strings.Unbounded.Unbounded_String;
      Value        : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   protected type Settings is

      procedure Get (Name    : in String;
                     Default : in String;
                     Value   : out Ada.Strings.Unbounded.Unbounded_String);

      procedure Set (Name  : in String;
                     Value : in String);

      procedure Clear;

   private
      First   : Setting_Data_Access := null;
   end Settings;

   type Setting_Manager is new AWA.Modules.Module_Manager with record
      Data : Settings;
   end record;

end AWA.Settings.Modules;
