-----------------------------------------------------------------------
--  awa-users-servlets -- OpenID verification servlet for user authentication
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

with AWA.Users.Services;
with AWA.Users.Module;
with AWA.Users.Models;
with AWA.Users.Principals;
package body AWA.Users.Servlets is

   --  ------------------------------
   --  Create a principal object that correspond to the authenticated user identified
   --  by the <b>Auth</b> information.  The principal will be attached to the session
   --  and will be destroyed when the session is closed.
   --  ------------------------------
   procedure Create_Principal (Server : in Verify_Auth_Servlet;
                               Auth   : in Security.Openid.Authentication;
                               Result : out ASF.Principals.Principal_Access) is
      pragma Unreferenced (Server);
      use AWA.Users.Module;
      use AWA.Users.Services;

      Manager : constant User_Service_Access := AWA.Users.Module.Get_User_Manager;
      User    : AWA.Users.Models.User_Ref;
      Session : AWA.Users.Models.Session_Ref;
   begin
      Manager.Authenticate (Auth    => Auth,
                            IpAddr  => "",
                            User    => User,
                            Session => Session);
      Result := AWA.Users.Principals.Create (User, Session).all'Access;
   end Create_Principal;

end AWA.Users.Servlets;
