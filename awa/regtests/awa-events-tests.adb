-----------------------------------------------------------------------
--  events-tests -- Unit tests for AWA events
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

with Util.Tests;
with Util.Test_Caller;

with EL.Contexts.Default;

with AWA.Applications;
with AWA.Tests;
with ADO.Sessions;

package body AWA.Events.Tests is

   package Event_Test_4 is new AWA.Events.Definition (Name => "event-test-4");
   package Event_Test_1 is new AWA.Events.Definition (Name => "event-test-1");
   package Event_Test_3 is new AWA.Events.Definition (Name => "event-test-3");
   package Event_Test_2 is new AWA.Events.Definition (Name => "event-test-2");
   package Event_Test_5 is new AWA.Events.Definition (Name => "event-test-5");

   package Caller is new Util.Test_Caller (Test, "Events.Tests");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test AWA.Events.Find_Event_Index",
                       Test_Find_Event'Access);
      Caller.Add_Test (Suite, "Test AWA.Events.Initialize",
                       Test_Initialize'Access);
      Caller.Add_Test (Suite, "Test AWA.Events.Add_Action",
                       Test_Add_Action'Access);
   end Add_Tests;

   --  ------------------------------
   --  Test searching an event name in the definition list.
   --  ------------------------------
   procedure Test_Find_Event (T : in out Test) is
   begin
      Util.Tests.Assert_Equals (T, Integer (Event_Test_4.Kind),
                                Integer (Find_Event_Index ("event-test-4")), "Find_Event");
      Util.Tests.Assert_Equals (T, Integer (Event_Test_5.Kind),
                                Integer (Find_Event_Index ("event-test-5")), "Find_Event");
      Util.Tests.Assert_Equals (T, Integer (Event_Test_1.Kind),
                                Integer (Find_Event_Index ("event-test-1")), "Find_Event");
   end Test_Find_Event;

   --  ------------------------------
   --  Test creation and initialization of event manager.
   --  ------------------------------
   procedure Test_Initialize (T : in out Test) is
      App     : AWA.Applications.Application_Access := AWA.Tests.Get_Application;
      Manager : Event_Manager;
      Session : ADO.Sessions.Master_Session := App.Get_Master_Session;
   begin
      Manager.Initialize (Session);
      T.Assert (Manager.Actions /= null, "Initialization failed");
   end Test_Initialize;

   --  ------------------------------
   --  Test adding an action.
   --  ------------------------------
   procedure Test_Add_Action (T : in out Test) is
      App     : AWA.Applications.Application_Access := AWA.Tests.Get_Application;
      Manager : Event_Manager;
      Ctx     : EL.Contexts.Default.Default_Context;
      Session : ADO.Sessions.Master_Session := App.Get_Master_Session;
      Action  : EL.Expressions.Method_Expression := EL.Expressions.Create_Expression ("#{a.send}", Ctx);
      Props   : EL.Beans.Param_Vectors.Vector;
      Pos     : Event_Index := Find_Event_Index ("event-test-4");
   begin
      Manager.Initialize (Session);

      for I in 1 .. 10 loop
         Manager.Add_Action (Event  => "event-test-4",
                             Queue  => "",
                             Action => Action,
                             Params => Props);
         Util.Tests.Assert_Equals (T, 1, Integer (Manager.Actions (Pos).Queues.Length),
                                   "Add_Action failed");
      end loop;
   end Test_Add_Action;

end AWA.Events.Tests;
