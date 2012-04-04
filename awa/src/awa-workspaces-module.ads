-----------------------------------------------------------------------
--  awa-workspaces-module -- Module workspaces
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

with ADO.Sessions;

with ASF.Applications;

with AWA.Modules;
with AWA.Services.Contexts;
with AWA.Workspaces.Models;
package AWA.Workspaces.Module is

   --  The name under which the module is registered.
   NAME : constant String := "workspaces";

   --  ------------------------------
   --  Module workspaces
   --  ------------------------------
   type Workspace_Module is new AWA.Modules.Module with private;
   type Workspace_Module_Access is access all Workspace_Module'Class;

   --  Initialize the workspaces module.
   overriding
   procedure Initialize (Plugin : in out Workspace_Module;
                         App    : in AWA.Modules.Application_Access;
                         Props  : in ASF.Applications.Config);

   --  Get the current workspace associated with the current user.
   --  If the user has not workspace, create one.
   procedure Get_Workspace (Session   : in out ADO.Sessions.Master_Session;
                            Context   : in AWA.Services.Contexts.Service_Context_Access;
                            Workspace : out AWA.Workspaces.Models.Workspace_Ref);

private

   type Workspace_Module is new AWA.Modules.Module with null record;

end AWA.Workspaces.Module;
