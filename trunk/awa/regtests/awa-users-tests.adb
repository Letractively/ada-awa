-----------------------------------------------------------------------
--  files.tests -- Unit tests for files
--  Copyright (C) 2009, 2010, 2011 Stephane Carrez
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

with Util.Tests;
with Util.Test_Caller;

with ASF.Tests;
with AWA.Tests;
with ASF.Requests.Mockup;
with ASF.Responses.Mockup;
package body AWA.Users.Tests is

   use ASF.Tests;
   use AWA.Tests;

   package Caller is new Util.Test_Caller (Test);

   procedure Add_Tests (Suite : AUnit.Test_Suites.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test AWA.Users.Tests.Create_User",
                       Test_Create_User'Access);
      Caller.Add_Test (Suite, "Test AWA.Users.Logic.Close_Session",
                       Test_Logout_User'Access);
      Caller.Add_Test (Suite, "Test AWA.Users.Logic.Authenticate, Close_Session",
                       Test_Login_User'Access);
      Caller.Add_Test (Suite, "Test AWA.Users.Logic.Lost_Password, Reset_Password",
                       Test_Reset_Password_User'Access);
   end Add_Tests;

   procedure Test_Create_User (T : in out Test) is
      Request : ASF.Requests.Mockup.Request;
      Reply   : ASF.Responses.Mockup.Response;
   begin
      Do_Get (Request, Reply, "/users/register.html", "create-user-1.html");

      Request.Set_Parameter ("email", "Joe@gmail.com");
      Request.Set_Parameter ("password", "asdf");
      Request.Set_Parameter ("first_name", "joe");
      Request.Set_Parameter ("last_name", "dalton");
      Request.Set_Parameter ("register", "1");
      Do_Post (Request, Reply, "/users/register.html", "create-user-2.html");

      Assert (T, Reply.Get_Status = ASF.Responses.SC_OK, "Invalid response");
   end Test_Create_User;

   procedure Test_Logout_User (T : in out Test) is
   begin
      null;
   end Test_Logout_User;

   procedure Test_Login_User (T : in out Test) is
   begin
      null;
   end Test_Login_User;

   procedure Test_Reset_Password_User (T : in out Test) is
   begin
      null;
   end Test_Reset_Password_User;

end AWA.Users.Tests;
