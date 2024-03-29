-----------------------------------------------------------------------
--  awa-users-module -- User management module
--  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2014 Stephane Carrez
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
with AWA.Users.Services;
with AWA.Users.Filters;
with AWA.Users.Servlets;

--  == Introduction ==
--  The <b>Users.Module</b> manages the creation, update, removal and authentication of users
--  in an application.  The module provides the foundations for user management in
--  a web application.
--
--  A user can register himself by using a subscription form.  In that case, a verification mail
--  is sent and the user has to follow the verification link defined in the mail to finish
--  the registration process.  The user will authenticate using a password.
--
--  A user can also use an OpenID account and be automatically registered.
--
--  A user can have one or several permissions that allow to protect the application data.
--  User permissions are managed by the <b>Permissions.Module</b>.
--
--  == Configuration ==
--  The *users* module uses a set of configuration properties to configure the OpenID
--  integration.
--
--  @include users.xml
--
--  @include awa-users-services.ads
--
--  @include users.xml
--
--  == Model ==
--  [http://ada-awa.googlecode.com/svn/wiki/awa_user_model.png]
--
--  @include User.hbm.xml
package AWA.Users.Modules is

   NAME : constant String := "users";

   type User_Module is new AWA.Modules.Module with private;
   type User_Module_Access is access all User_Module'Class;

   --  Initialize the user module.
   overriding
   procedure Initialize (Plugin : in out User_Module;
                         App    : in AWA.Modules.Application_Access;
                         Props  : in ASF.Applications.Config);

   --  Get the user manager.
   function Get_User_Manager (Plugin : in User_Module) return Services.User_Service_Access;

   --  Create a user manager.  This operation can be overriden to provide another
   --  user service implementation.
   function Create_User_Manager (Plugin : in User_Module) return Services.User_Service_Access;

   --  Get the user module instance associated with the current application.
   function Get_User_Module return User_Module_Access;

   --  Get the user manager instance associated with the current application.
   function Get_User_Manager return Services.User_Service_Access;

private

   type User_Module is new AWA.Modules.Module with record
      Manager     : Services.User_Service_Access := null;
      Key_Filter  : aliased AWA.Users.Filters.Verify_Filter;
      Auth_Filter : aliased AWA.Users.Filters.Auth_Filter;
      Auth        : aliased AWA.Users.Servlets.Request_Auth_Servlet;
      Verify_Auth : aliased AWA.Users.Servlets.Verify_Auth_Servlet;
   end record;

end AWA.Users.Modules;
