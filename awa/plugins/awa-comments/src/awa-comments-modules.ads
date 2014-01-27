-----------------------------------------------------------------------
--  awa-comments-module -- Comments module
--  Copyright (C) 2011, 2012, 2013, 2014 Stephane Carrez
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

with ADO;
with AWA.Modules;
with AWA.Modules.Get;
with AWA.Comments.Models;

--  == Integration ==
--  The <tt>Comment_Module</tt> manages the comments associated with entities.  It provides
--  operations that are used by the comment beans to manage the comments.
--  An instance of the <tt>Comment_Module</tt> must be declared and registered in the
--  AWA application.  The module instance can be defined as follows:
--
--    type Application is new AWA.Applications.Application with record
--       Comment_Module : aliased AWA.Comments.Modules.Comment_Module;
--    end record;
--
--  And registered in the `Initialize_Modules` procedure by using:
--
--    Register (App    => App.Self.all'Access,
--              Name   => AWA.Comments.Modules.NAME,
--              URI    => "comments",
--              Module => App.Comment_Module'Access);
--
package AWA.Comments.Modules is

   NAME : constant String := "comments";

   Not_Found : exception;

   type Comment_Module is new AWA.Modules.Module with null record;
   type Comment_Module_Access is access all Comment_Module'Class;

   overriding
   procedure Initialize (Plugin : in out Comment_Module;
                         App    : in AWA.Modules.Application_Access;
                         Props  : in ASF.Applications.Config);

   --  Load the comment identified by the given identifier.
   procedure Load_Comment (Model   : in Comment_Module;
                           Comment : in out AWA.Comments.Models.Comment_Ref'Class;
                           Id      : in ADO.Identifier);

   --  Create a new comment for the associated database entity.
   procedure Create_Comment (Model       : in Comment_Module;
                             Permission  : in String;
                             Entity_Type : in String;
                             Comment     : in out AWA.Comments.Models.Comment_Ref'Class);

   --  Update the comment represented by <tt>Comment</tt> if the current user has the
   --  permission identified by <tt>Permission</tt>.
   procedure Update_Comment (Model       : in Comment_Module;
                             Permission  : in String;
                             Comment     : in out AWA.Comments.Models.Comment_Ref'Class);

   --  Delete the comment represented by <tt>Comment</tt> if the current user has the
   --  permission identified by <tt>Permission</tt>.
   procedure Delete_Comment (Model       : in Comment_Module;
                             Permission  : in String;
                             Comment     : in out AWA.Comments.Models.Comment_Ref'Class);

   --  Set the publication status of the comment represented by <tt>Comment</tt>
   --  if the current user has the permission identified by <tt>Permission</tt>.
   procedure Publish_Comment (Model       : in Comment_Module;
                              Permission  : in String;
                              Id          : in ADO.Identifier;
                              Status      : in AWA.Comments.Models.Status_Type;
                              Comment     : in out AWA.Comments.Models.Comment_Ref'Class);

   function Get_Comment_Module is
     new AWA.Modules.Get (Comment_Module, Comment_Module_Access, NAME);

end AWA.Comments.Modules;
