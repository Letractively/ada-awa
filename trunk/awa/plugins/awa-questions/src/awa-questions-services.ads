-----------------------------------------------------------------------
--  awa-questions-services -- Service services
--  Copyright (C) 2012, 2013 Stephane Carrez
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
with ADO;

with Security.Permissions;

with AWA.Modules;
with AWA.Questions.Models;
package AWA.Questions.Services is

   --  Define the permissions.
   package ACL_Create_Questions is new Security.Permissions.Definition ("question-create");
   package ACL_Delete_Questions is new Security.Permissions.Definition ("question-delete");
   package ACL_Update_Questions is new Security.Permissions.Definition ("question-update");
   package ACL_Answer_Questions is new Security.Permissions.Definition ("answer-create");
   package ACL_Delete_Answer is new Security.Permissions.Definition ("answer-delete");

   --  The maximum length for a short description.
   SHORT_DESCRIPTION_LENGTH : constant Positive := 200;

   --  ------------------------------
   --  Service services
   --  ------------------------------
   type Question_Service is new AWA.Modules.Module_Manager with private;
   type Question_Service_Access is access all Question_Service'Class;

   --  Create or save the question.
   procedure Save_Question (Model    : in Question_Service;
                            Question : in out AWA.Questions.Models.Question_Ref'Class);

   --  Delete the question.
   procedure Delete_Question (Model    : in Question_Service;
                              Question : in out AWA.Questions.Models.Question_Ref'Class);

   --  Load the question.
   procedure Load_Question (Model    : in Question_Service;
                            Question : in out AWA.Questions.Models.Question_Ref'Class;
                            Id       : in ADO.Identifier);

   --  Create or save the answer.
   procedure Save_Answer (Model    : in Question_Service;
                          Question : in AWA.Questions.Models.Question_Ref'Class;
                          Answer   : in out AWA.Questions.Models.Answer_Ref'Class);

   --  Delete the answer.
   procedure Delete_Answer (Model  : in Question_Service;
                            Answer : in out AWA.Questions.Models.Answer_Ref'Class);

   --  Load the answer.
   procedure Load_Answer (Model    : in Question_Service;
                          Answer   : in out AWA.Questions.Models.Answer_Ref'Class;
                          Question : in out AWA.Questions.Models.Question_Ref'Class;
                          Id       : in ADO.Identifier);

private

   type Question_Service is new AWA.Modules.Module_Manager with null record;

end AWA.Questions.Services;
