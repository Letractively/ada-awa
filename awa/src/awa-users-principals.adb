-----------------------------------------------------------------------
--  awa-users-principals -- User principals
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

--  with AWA.Users.Services;
--  with AWA.Users.Module;
package body AWA.Users.Principals is

   --  ------------------------------
   --  Get the principal name.
   --  ------------------------------
   function Get_Name (From : in Principal) return String is
   begin
      return From.User.Get_Name;
   end Get_Name;

   --  ------------------------------
   --  Returns true if the given role is stored in the user principal.
   --  ------------------------------
   function Has_Role (User : in Principal;
                      Role : in Security.Permissions.Role_Type) return Boolean is
   begin
      return User.Roles (Role);
   end Has_Role;

   --  ------------------------------
   --  Get the principal identifier (name)
   --  ------------------------------
   function Get_Id (From : in Principal) return String is
   begin
      return From.User.Get_Name;
   end Get_Id;

   --  ------------------------------
   --  Get the user associated with the principal.
   --  ------------------------------
   function Get_User (From : in Principal) return AWA.Users.Models.User_Ref is
   begin
      return From.User;
   end Get_User;

   --  ------------------------------
   --  Get the current user identifier invoking the service operation.
   --  Returns NO_IDENTIFIER if there is none.
   --  ------------------------------
   function Get_User_Identifier (From : in Principal) return ADO.Identifier is
   begin
      return From.User.Get_Id;
   end Get_User_Identifier;

   --  ------------------------------
   --  Get the connection session used by the user.
   --  ------------------------------
   function Get_Session (From : in Principal) return AWA.Users.Models.Session_Ref is
   begin
      return From.Session;
   end Get_Session;

   --  ------------------------------
   --  Get the connection session identifier used by the user.
   --  ------------------------------
   function Get_Session_Identifier (From : in Principal) return ADO.Identifier is
   begin
      return From.Session.Get_Id;
   end Get_Session_Identifier;

   --  ------------------------------
   --  Create a principal for the given user.
   --  ------------------------------
   function Create (User    : in AWA.Users.Models.User_Ref;
                    Session : in AWA.Users.Models.Session_Ref) return Principal_Access is
      Result : constant Principal_Access := new Principal;
   begin
      Result.User    := User;
	  Result.Session := Session;
      return Result;
   end Create;

   --  ------------------------------
   --  Get the current user identifier invoking the service operation.
   --  Returns NO_IDENTIFIER if there is none or if the principal is not an AWA principal.
   --  ------------------------------
   function Get_User_Identifier (From : in Security.Permissions.Principal_Access)
                                 return ADO.Identifier is
      use type Security.Permissions.Principal_Access;
   begin
      if From = null then
         return ADO.NO_IDENTIFIER;

      elsif not (From.all in Principal'Class) then
         return ADO.NO_IDENTIFIER;

      else
         return Principal'Class (From.all).Get_User_Identifier;
      end if;
   end Get_User_Identifier;

   --  ------------------------------
   --  Create a principal object that correspond to the authenticated user identified
   --  by the <b>Auth</b> information.  The principal will be attached to the session
   --  and will be destroyed when the session is closed.
   --  ------------------------------
   procedure Create_Principal (Server : in Verify_Auth_Servlet;
                               Auth   : in Security.Openid.Authentication;
                               Result : out ASF.Principals.Principal_Access) is
      pragma Unreferenced (Server);
--        use AWA.Users.Module;
--        use AWA.Users.Services;

--        Manager : constant User_Service_Access := AWA.Users.Module.Get_User_Manager;
--  	  User    : AWA.Users.Models.User_Ref;
--  	  Session : AWA.Users.Models.Session_Ref;
   begin
--        Manager.Authenticate (Auth    => Auth,
--                              IpAddr  => "",
--                              User    => User,
--                              Session => Session);
--        Result := Create (User, Session).all'Access;

      Result := null;
   end Create_Principal;

end AWA.Users.Principals;
