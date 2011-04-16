-----------------------------------------------------------------------
--  AWA tests - AWA Tests Framework
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

with Util.Properties;
with ASF.Requests.Mockup;
with ASF.Responses.Mockup;
with ASF.Server;
with AWA.Applications;
package AWA.Tests is

   --  Initialize the awa test framework mockup.
   procedure Initialize (Props : in Util.Properties.Manager);

   --  Get the server
   function Get_Server return access ASF.Server.Container;

   --  Get the test application.
   function Get_Application return AWA.Applications.Application_Access;

end AWA.Tests;
