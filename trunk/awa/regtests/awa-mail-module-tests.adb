-----------------------------------------------------------------------
--  awa-mail-module-tests -- Unit tests for Mail module
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

with Util.Test_Caller;

with AWA.Events;

package body AWA.Mail.Module.Tests is

   package Caller is new Util.Test_Caller (Test, "Mail.Clients");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test AWA.Mail.Module.Create_Message",
                       Test_Create_Message'Access);
   end Add_Tests;

   --  Create an email message and verify its content.
   procedure Test_Create_Message (T : in out Test) is
      use Util.Beans.Objects;

      Mail  : constant AWA.Mail.Module.Mail_Module_Access := AWA.Mail.Module.Get_Mail_Module;
      Event : AWA.Events.Module_Event;
      Props : Util.Beans.Objects.Maps.Map;
   begin
      T.Assert (Mail /= null, "There is no current mail module");

      Props.Insert ("name", To_Object (String '("joe")));
      Props.Insert ("email", To_Object (String '("joe.rogers@somewhere.org")));
      Mail.Send_Mail (Template => "mail-info.html",
                      Props    => Props,
                      Content  => Event);

   end Test_Create_Message;

end AWA.Mail.Module.Tests;
