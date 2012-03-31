-----------------------------------------------------------------------
--  awa-mail-components-recipients -- Mail UI Recipients
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

--  The <b>AWA.Mail.Components.Messages</b> package defines the UI components
--  to represent the email message with its recipients, subject and body.
--
--  The mail message is retrieved by looking at the parent UI component until a
--  <tt>UIMailMessage</b> component is found.  The mail message recipients are initialized
--  during the render response JSF phase, that is when <tt>Encode_End</tt> are called.
package AWA.Mail.Components.Messages is

   --  ------------------------------
   --  The mail recipient
   --  ------------------------------
   type UIMailMessage is new UIMailComponent with private;

   --  Set the mail message instance.
   procedure Set_Message (UI      : in out UIMailMessage;
                          Message : in AWA.Mail.Clients.Mail_Message_Access);

   --  Get the mail message instance.
   overriding
   function Get_Message (UI      : in UIMailMessage) return AWA.Mail.Clients.Mail_Message_Access;

   --  Send the mail.
   overriding
   procedure Encode_End (UI      : in UIMailMessage;
                         Context : in out ASF.Contexts.Faces.Faces_Context'Class);

   --  Finalize and release the mail message.
   overriding
   procedure Finalize (UI : in out UIMailMessage);

   --  ------------------------------
   --  The mail subject
   --  ------------------------------
   type UIMailSubject is new UIMailComponent with private;

   --  Render the mail subject and initializes the message with its content.
   overriding
   procedure Encode_Children (UI      : in UIMailSubject;
                              Context : in out ASF.Contexts.Faces.Faces_Context'Class);

   --  ------------------------------
   --  The mail body
   --  ------------------------------
   type UIMailBody is new UIMailComponent with private;

   --  Render the mail body and initializes the message with its content.
   overriding
   procedure Encode_Children (UI      : in UIMailBody;
                              Context : in out ASF.Contexts.Faces.Faces_Context'Class);

private

   type UIMailMessage is new UIMailComponent with record
      Message : AWA.Mail.Clients.Mail_Message_Access;
   end record;

   type UIMailBody is new UIMailComponent with null record;
   type UIMailSubject is new UIMailComponent with null record;

end AWA.Mail.Components.Messages;
