-----------------------------------------------------------------------
--  awa-mail-clients-aws_smtp -- Mail client implementation on top of AWS SMTP client
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

with Ada.Unchecked_Deallocation;

with AWS.SMTP.Client;

with Util.Log.Loggers;

package body AWA.Mail.Clients.AWS_SMTP is

   use Ada.Strings.Unbounded;

   Log : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("AWA.Mail.Clients.AWS_SMTP");

   procedure Free is
      new Ada.Unchecked_Deallocation (Object => AWS.SMTP.Recipients,
                                      Name   => Recipients_Access);

   --  ------------------------------
   --  Set the <tt>From</tt> part of the message.
   --  ------------------------------
   overriding
   procedure Set_From (Message : in out AWS_Mail_Message;
                       Name    : in String;
                       Address : in String) is
   begin
      Message.From := AWS.SMTP.E_Mail (Name    => Name,
                                       Address => Address);
   end Set_From;

   --  ------------------------------
   --  Add a recipient for the message.
   --  ------------------------------
   overriding
   procedure Add_Recipient (Message : in out AWS_Mail_Message;
                            Kind    : in Recipient_Type;
                            Name    : in String;
                            Address : in String) is
   begin
      if Message.To = null then
         Message.To := new AWS.SMTP.Recipients (1 .. 1);
      else
         declare
            To : constant Recipients_Access := new AWS.SMTP.Recipients (1 .. Message.To'Last + 1);
         begin
            To (Message.To'Range) := Message.To.all;
            Free (Message.To);
            Message.To := To;
         end;
      end if;
      Message.To (Message.To'Last) := AWS.SMTP.E_Mail (Name    => Name,
                                                       Address => Address);
   end Add_Recipient;

   --  ------------------------------
   --  Set the subject of the message.
   --  ------------------------------
   overriding
   procedure Set_Subject (Message : in out AWS_Mail_Message;
                          Subject : in String) is
   begin
      Message.Subject := To_Unbounded_String (Subject);
   end Set_Subject;

   --  ------------------------------
   --  Set the body of the message.
   --  ------------------------------
   overriding
   procedure Set_Body (Message : in out AWS_Mail_Message;
                       Content : in String) is
   begin
      Message.Content := To_Unbounded_String (Content);
   end Set_Body;

   --  ------------------------------
   --  Send the email message.
   --  ------------------------------
   overriding
   procedure Send (Message : in out AWS_Mail_Message) is
      Result  : AWS.SMTP.Status;
   begin
      if Message.To = null then
         return;
      end if;

      if Message.Manager.Enable then
         Log.Info ("Send email to {0}", "");
         AWS.SMTP.Client.Send (Server  => Message.Manager.Server,
                               From    => Message.From,
                               To      => Message.To.all,
                               Subject => To_String (Message.Subject),
                               Message => To_String (Message.Content),
                               Status  => Result);

      else
         Log.Info ("Disable send email to {0}", "");
      end if;
   end Send;

   --  ------------------------------
   --  Deletes the mail message.
   --  ------------------------------
   overriding
   procedure Finalize (Message : in out AWS_Mail_Message) is
   begin
      Log.Info ("Finalize mail message");
      Free (Message.To);
   end Finalize;

   --  ------------------------------
   --  Create a SMTP based mail manager and configure it according to the properties.
   --  ------------------------------
   function Create_Manager (Props : in Util.Properties.Manager) return Mail_Manager_Access is
      Server : constant String := Props.Get (Name => "smtp.host", Default => "localhost");
      Port   : constant String := Props.Get (Name => "smtp.port", Default => "25");
      Enable : constant String := Props.Get (Name => "smtp.enable", Default => "1");
      Result : constant AWS_Mail_Manager_Access := new AWS_Mail_Manager;
   begin
      Log.Info ("Creating SMTP mail manager to server {0}:{1}", Server, Port);

      Result.Self   := Result;
      Result.Enable := Enable = "1" or Enable = "yes" or Enable = "true";
      Result.Server := AWS.SMTP.Client.Initialize (Server_Name => Server,
                                                   Port => Positive'Value (Port));
      return Result.all'Access;
   end Create_Manager;

   --  ------------------------------
   --  Create a new mail message.
   --  ------------------------------
   overriding
   function Create_Message (Manager : in AWS_Mail_Manager) return Mail_Message_Access is
      Result : constant AWS_Mail_Message_Access := new AWS_Mail_Message;
   begin
      Result.Manager := Manager.Self;
      return Result.all'Access;
   end Create_Message;

end AWA.Mail.Clients.AWS_SMTP;
