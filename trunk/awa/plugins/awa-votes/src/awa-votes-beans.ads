-----------------------------------------------------------------------
--  awa-votes-beans -- Beans for module votes
--  Copyright (C) 2013 Stephane Carrez
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

with Util.Beans.Basic;
with AWA.Votes.Modules;
with AWA.Votes.Models;

--  === Vote Beans ===
--  The <b>Vote_Bean</b> is a bean intended to be used in presentation files (facelet files)
--  to vote for an item.  The managed bean can be easily configured in the application XML
--  configuration file.  The <b>permission</b> and <b>entity_type</b> are the two properties
--  that should be defined in the configuration.  The <b>permission</b> is the name of the
--  permission that must be used to verify that the user is allowed to vote for the item.
--  The <b>entity_type</b> is the name of the entity (table name) used by the item.
--  The example below defines the bean <tt>questionVote</tt> defined by the question module.
--
--    <managed-bean>
--      <description>The vote bean that allows to vote for a question.</description>
--      <managed-bean-name>questionVote</managed-bean-name>
--      <managed-bean-class>AWA.Votes.Beans.Votes_Bean</managed-bean-class>
--      <managed-bean-scope>request</managed-bean-scope>
--      <managed-property>
--        <property-name>permission</property-name>
--        <property-class>String</property-class>
--        <value>answer-create</value>
--      </managed-property>
--      <managed-property>
--        <property-name>entity_type</property-name>
--        <property-class>String</property-class>
--        <value>awa_question</value>
--      </managed-property>
--    </managed-bean>
--
--  The vote concerns entities for the <tt>awa_question</tt> entity table.
--  The permission <tt>answer-create</tt> is used to verify for the vote.
--
--  [http://ada-awa.googlecode.com/svn/wiki/awa_votes_bean.png]
--
package AWA.Votes.Beans is

   type Vote_Bean is new AWA.Votes.Models.Vote_Bean with private;
   type Vote_Bean_Access is access all Vote_Bean'Class;

   --  Action to vote up.
   overriding
   procedure Vote_Up (Bean    : in out Vote_Bean;
                      Outcome : in out Ada.Strings.Unbounded.Unbounded_String);

   --  Action to vote down.
   overriding
   procedure Vote_Down (Bean    : in out Vote_Bean;
                        Outcome : in out Ada.Strings.Unbounded.Unbounded_String);

   --  Action to vote.
   overriding
   procedure Vote (Bean    : in out Vote_Bean;
                   Outcome : in out Ada.Strings.Unbounded.Unbounded_String);

   --  Create the Votes_Bean bean instance.
   function Create_Vote_Bean (Module : in AWA.Votes.Modules.Vote_Module_Access)
      return Util.Beans.Basic.Readonly_Bean_Access;

private

   type Vote_Bean is new AWA.Votes.Models.Vote_Bean with record
      Module : AWA.Votes.Modules.Vote_Module_Access := null;
   end record;

end AWA.Votes.Beans;
