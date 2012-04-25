-----------------------------------------------------------------------
--  awa-storages-modules -- Storage management module
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

with ASF.Applications;

with AWA.Modules;
with AWA.Storages.Services;

package AWA.Storages.Modules is

   NAME : constant String := "storages";

   type Storage_Module is new AWA.Modules.Module with private;
   type Storage_Module_Access is access all Storage_Module'Class;

   --  Initialize the storage module.
   overriding
   procedure Initialize (Plugin : in out Storage_Module;
                         App    : in AWA.Modules.Application_Access;
                         Props  : in ASF.Applications.Config);

   --  Get the storage manager.
   function Get_Storage_Manager (Plugin : in Storage_Module)
                                 return Services.Storage_Service_Access;

   --  Create a storage manager.  This operation can be overriden to provide another
   --  storage service implementation.
   function Create_Storage_Manager (Plugin : in Storage_Module)
                                    return Services.Storage_Service_Access;

   --  Get the storage module instance associated with the current application.
   function Get_Storage_Module return Storage_Module_Access;

   --  Get the storage manager instance associated with the current application.
   function Get_Storage_Manager return Services.Storage_Service_Access;

private

   type Storage_Module is new AWA.Modules.Module with record
      Manager     : Services.Storage_Service_Access := null;
   end record;

end AWA.Storages.Modules;