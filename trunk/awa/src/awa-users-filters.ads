-----------------------------------------------------------------------
--  awa-users-filters -- Specific filters for authentication and key verification
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

with Ada.Strings.Unbounded;

with ASF.Requests;
with ASF.Responses;
with ASF.Sessions;
with ASF.Principals;
with ASF.Filters;
with ASF.Servlets;
with Security.Filters;
package AWA.Users.Filters is

   type Auth_Filter is new Security.Filters.Auth_Filter with null record;

   overriding
   procedure Authenticate (F        : in Auth_Filter;
                           Request  : in out ASF.Requests.Request'Class;
                           Response : in out ASF.Responses.Response'Class;
                           Session  : in ASF.Sessions.Session;
                           Auth_Id  : in String;
                           Principal : out ASF.Principals.Principal_Access);

   --  ------------------------------
   --  Verify access key filter
   --  ------------------------------
   --  The <b>Verify_Filter</b> filter verifies an access key associated to a user.
   --  The access key should have been sent to the user by some mechanism (email).
   --  The access key must be valid, that is an <b>Access_Key</b> database entry
   --  must exist and it must be associated with an email address and a user.
   type Verify_Filter is new ASF.Filters.Filter with private;

   --  The request parameter that <b>Verify_Filter</b> will check.
   PARAM_ACCESS_KEY : constant String := "key";

   --  Initialize the filter and configure the redirection URIs.
   procedure Initialize (Filter  : in out Verify_Filter;
                         Context : in ASF.Servlets.Servlet_Registry'Class);

   --  Filter a request which contains an access key and verify that the
   --  key is valid and identifies a user.  Once the user is known, create
   --  a session and setup the user principal.
   --
   --  If the access key is missing or invalid, redirect to the
   --  <b>Invalid_Key_URI</b> associated with the filter.
   procedure Do_Filter (Filter   : in Verify_Filter;
                        Request  : in out ASF.Requests.Request'Class;
                        Response : in out ASF.Responses.Response'Class;
                        Chain    : in out ASF.Servlets.Filter_Chain);

private

   use Ada.Strings.Unbounded;

   type Verify_Filter is new ASF.Filters.Filter with record
      Invalid_Key_URI : Unbounded_String;
   end record;

end AWA.Users.Filters;
