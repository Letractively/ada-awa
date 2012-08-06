-----------------------------------------------------------------------
--  awa-mail -- Mail module
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

with AWA.Modules.Beans;
with AWA.Modules.Get;
with AWA.Mail.Beans;
with AWA.Mail.Components.Factory;
with AWA.Applications;

with ASF.Requests.Mockup;
with ASF.Responses.Mockup;
with Util.Beans.Basic;
with Util.Beans.Objects;
with Util.Log.Loggers;

package body AWA.Mail.Modules is

   use Util.Log;

   Log : constant Loggers.Logger := Loggers.Create ("AWA.Mail.Module");

   package Register is new AWA.Modules.Beans (Module => Mail_Module,
                                              Module_Access => Mail_Module_Access);

   --  ------------------------------
   --  Initialize the mail module.
   --  ------------------------------
   overriding
   procedure Initialize (Plugin : in out Mail_Module;
                         App    : in AWA.Modules.Application_Access;
                         Props  : in ASF.Applications.Config) is
   begin
      Log.Info ("Initializing the mail module");

      --  Add the Mail UI components.
      App.Add_Components (AWA.Mail.Components.Factory.Definition);

      --  Register here any bean class, servlet, filter.
      Register.Register (Plugin => Plugin,
                         Name   => "AWA.Mail.Beans.Mail_Bean",
                         Handler => AWA.Mail.Beans.Create_Mail_Bean'Access);

      AWA.Modules.Module (Plugin).Initialize (App, Props);
   end Initialize;

   --  ------------------------------
   --  Configures the module after its initialization and after having read its XML configuration.
   --  ------------------------------
   overriding
   procedure Configure (Plugin : in out Mail_Module;
                        Props  : in ASF.Applications.Config) is
      Mailer : constant String := Props.Get ("mailer", "smtp");
   begin
      Plugin.Mailer := AWA.Mail.Clients.Factory (Mailer, Props);
   end Configure;

   --  ------------------------------
   --  Create a new mail message.
   --  ------------------------------
   function Create_Message (Plugin : in Mail_Module)
                            return AWA.Mail.Clients.Mail_Message_Access is
   begin
      return Plugin.Mailer.Create_Message;
   end Create_Message;

   --  ------------------------------
   --  Get the mail template that must be used for the given event name.
   --  The mail template is configured by the property: <i>module</i>.template.<i>event</i>.
   --  ------------------------------
   function Get_Template (Plugin : in Mail_Module;
                          Name   : in String) return String is
      Prop_Name : constant String := Plugin.Get_Name & ".template." & Name;
   begin
      return Plugin.Get_Config (Prop_Name);
   end Get_Template;

   --  Receive an event sent by another module with <b>Send_Event</b> method.
   --  Format and send an email.
   procedure Send_Mail (Plugin   : in Mail_Module;
                        Template : in String;
                        Props    : in Util.Beans.Objects.Maps.Map;
                        Content  : in AWA.Events.Module_Event'Class) is
      Name : constant String := Content.Get_Parameter ("name");
   begin
      Log.Info ("Receive event {0}", Name);

      if Template = "" then
         Log.Debug ("No email template associated with event {0}", Name);
         return;
      end if;

      declare
         Req   : ASF.Requests.Mockup.Request;
         Reply : ASF.Responses.Mockup.Response;
         Ptr   : constant Util.Beans.Basic.Readonly_Bean_Access := Content'Unrestricted_Access;
         Bean  : constant Util.Beans.Objects.Object
           := Util.Beans.Objects.To_Object (Ptr, Util.Beans.Objects.STATIC);
      begin
         Req.Set_Path_Info (Template);
         Req.Set_Method ("GET");
         Req.Set_Attribute (Name => "event", Value => Bean);
         Req.Set_Attributes (Props);

         Plugin.Get_Application.Dispatch (Page     => Template,
                                          Request  => Req,
                                          Response => Reply);
      end;
   end Send_Mail;

   --  ------------------------------
   --  Get the mail module instance associated with the current application.
   --  ------------------------------
   function Get_Mail_Module return Mail_Module_Access is
      function Get is new AWA.Modules.Get (Mail_Module, Mail_Module_Access, NAME);
   begin
      return Get;
   end Get_Mail_Module;

end AWA.Mail.Modules;
