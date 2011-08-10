-----------------------------------------------------------------------
--  awa-modules-get -- Get a specific module instance
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

with ASF.Server;
with ASF.Servlets;
with AWA.Applications;

--  ------------------------------
--  The <b>Get</b> function is an helper that retrieves a given module
--  instance from the current application.
--  ------------------------------
function AWA.Modules.Get return Module_Type_Access is
   use type ASF.Servlets.Servlet_Registry_Access;

   Ctx : constant ASF.Servlets.Servlet_Registry_Access := ASF.Server.Current;
begin
   if Ctx = null then
      Log.Warn ("There is no servlet context");
      return null;
   end if;
   if not (Ctx.all in AWA.Applications.Application'Class) then
      Log.Warn ("The servlet context is not an application");
      return null;
   end if;
   declare
      A : constant AWA.Applications.Application_Access
        := AWA.Applications.Application'Class (Ctx.all)'Access;
      M : constant Module_Access := A.Find_Module (Name);
   begin
      if M = null then
         return null;
      else
         return Module_Type (M.all)'Access;
      end if;
   end;
end AWA.Modules.Get;
