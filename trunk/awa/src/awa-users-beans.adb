-----------------------------------------------------------------------
--  awa-users-beans -- ASF Beans for user module
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

with ASF.Sessions;
with ASF.Events.Actions;
with ASF.Contexts.Faces;

with AWA.Users.Principals;
package body AWA.Users.Beans is


   use AWA.Users.Models;

   --  Action to register a user
   procedure Register_User (Data    : in out Authenticate_Bean;
                            Outcome : in out Unbounded_String) is
      User  : User_Ref;
      Email : Email_Ref;
   begin
      Email.Set_Email (Data.Email);
      User.Set_First_Name (Data.First_Name);
      User.Set_Last_Name (Data.Last_Name);
      User.Set_Password (Data.Password);
      Data.Manager.Create_User (User  => User,
                                Email => Email);
      Outcome := To_Unbounded_String ("success");
   end Register_User;

   --  Action to verify the user after the registration
   procedure Verify_User (Data    : in out Authenticate_Bean;
                          Outcome : in out Unbounded_String) is
      User    : User_Ref;
      Session : Session_Ref;
   begin
      Data.Manager.Verify_User (Key     => To_String (Data.Access_Key),
                                User    => User,
                                IpAddr  => "",
                                Session => Session);

      Outcome := To_Unbounded_String ("success");
   end Verify_User;


   --  Action to trigger the lost password email process.
   procedure Lost_Password (Data    : in out Authenticate_Bean;
                            Outcome : in out Unbounded_String) is
   begin
      Data.Manager.Lost_Password (Email => To_String (Data.Email));
      Outcome := To_Unbounded_String ("success");
   end Lost_Password;

   --  Action to validate the reset password key and set a new password.
   procedure Reset_Password (Data    : in out Authenticate_Bean;
                             Outcome : in out Unbounded_String) is
      User    : User_Ref;
      Session : Session_Ref;
   begin
      Data.Manager.Reset_Password (Key      => To_String (Data.Access_Key),
                                   Password => To_String (Data.Password),
                                   IpAddr   => "",
                                   User     => User,
                                   Session  => Session);
      Outcome := To_Unbounded_String ("success");
   end Reset_Password;


   procedure Set_Session_Principal (Data : in Authenticate_Bean;
                                    User : in AWA.Users.Models.User_Ref) is
      Principal : constant Principals.Principal_Access := Principals.Create (User);
      Ctx       : constant ASF.Contexts.Faces.Faces_Context_Access := ASF.Contexts.Faces.Current;
      Session   : ASF.Sessions.Session := Ctx.Get_Session (Create => True);
      Name      : constant String := "User: " & User.Get_Name;
   begin
      Session.Set_Principal (Principal.all'Access);
      Session.Set_Attribute (Name  => "user",
                             Value => Util.Beans.Objects.To_Object (Name));
   end Set_Session_Principal;

   --  Action to authenticate a user.
   procedure Authenticate_User (Data    : in out Authenticate_Bean;
                                Outcome : in out Unbounded_String) is
      User      : User_Ref;
      Session   : Session_Ref;
   begin
      Data.Manager.Authenticate (Email    => To_String (Data.Email),
                                 Password => To_String (Data.Password),
                                 IpAddr   => "",
                                 User     => User,
                                 Session  => Session);
      Outcome := To_Unbounded_String ("success");

      Data.Set_Session_Principal (User);
   end Authenticate_User;

   --  Create an authenticate bean.
   function Create_Authenticate_Bean (Module : in AWA.Users.Module.User_Module_Access)
                                      return Util.Beans.Basic.Readonly_Bean_Access is
      Object : Authenticate_Bean_Access := new Authenticate_Bean;
   begin
      Object.Module := Module;
      Object.Manager := AWA.Users.Module.Get_User_Manager;
      return Object.all'Access;
   end Create_Authenticate_Bean;

   --  The code below this line could be generated automatically by an Asis tool.

   package Authenticate_Binding is
     new ASF.Events.Actions.Action_Method.Bind (Bean   => Authenticate_Bean,
                                                Method => Authenticate_User,
                                                Name   => "authenticate");

   package Register_Binding is
     new ASF.Events.Actions.Action_Method.Bind (Bean   => Authenticate_Bean,
                                                Method => Register_User,
                                                Name   => "register");

   package Verify_Binding is
     new ASF.Events.Actions.Action_Method.Bind (Bean   => Authenticate_Bean,
                                                Method => Verify_User,
                                                Name   => "verify");

   package Lost_Password_Binding is
     new ASF.Events.Actions.Action_Method.Bind (Bean   => Authenticate_Bean,
                                                Method => Lost_Password,
                                                Name   => "lostPassword");

   package Reset_Password_Binding is
     new ASF.Events.Actions.Action_Method.Bind (Bean   => Authenticate_Bean,
                                                Method => Reset_Password,
                                                Name   => "resetPassword");

   Binding_Array : aliased constant Util.Beans.Methods.Method_Binding_Array
     := (Authenticate_Binding.Proxy'Access,
         Register_Binding.Proxy'Access,
         Verify_Binding.Proxy'Access,
         Lost_Password_Binding.Proxy'Access,
         Reset_Password_Binding.Proxy'Access);

   --  Get the value identified by the name.
   overriding
   function Get_Value (From : in Authenticate_Bean;
                       Name : in String) return Util.Beans.Objects.Object is
   begin
      if Name = "email" then
         return Util.Beans.Objects.To_Object (From.Email);
      elsif Name = "password" then
         return Util.Beans.Objects.To_Object (From.Password);
      elsif Name = "key" then
         return Util.Beans.Objects.To_Object (From.Access_Key);
      else
         return Util.Beans.Objects.Null_Object;
      end if;
   end Get_Value;

   --  Set the value identified by the name.
   overriding
   procedure Set_Value (From  : in out Authenticate_Bean;
                        Name  : in String;
                        Value : in Util.Beans.Objects.Object) is
   begin
      if Name = "email" then
         From.Email := Util.Beans.Objects.To_Unbounded_String (Value);
      elsif Name = "password" then
         From.Password := Util.Beans.Objects.To_Unbounded_String (Value);
      elsif Name = "key" then
         From.Access_Key := Util.Beans.Objects.To_Unbounded_String (Value);
      end if;
   end Set_Value;

   --  This bean provides some methods that can be used in a Method_Expression
   overriding
   function Get_Method_Bindings (From : in Authenticate_Bean)
                                 return Util.Beans.Methods.Method_Binding_Array_Access is
   begin
      return Binding_Array'Access;
   end Get_Method_Bindings;

end AWA.Users.Beans;
