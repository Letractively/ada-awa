## Introduction ##
The <b>AWA.Events</b> package defines an event framework for modules to post events
and have Ada bean methods be invoked when these events are dispatched.  Subscription to
events is done through configuration files.  This allows to configure the modules and
integrate them together easily at configuration time.

### Declaration ###
Modules define the events that they can generate by instantiating the <b>Definition</b>
package. This is a static definition of the event.  Each event is given a unique name.

```
  package Event_New_User is new AWA.Events.Definition ("new-user");
```

### Posting an event ###
The module can post an event to inform other modules or the system that a particular
action occurred.  The module creates the event instance of type <b>Module_Event</b> and
populates that event with useful properties for event receivers.

```
  Event : AWA.Events.Module_Event;
  Event.Set_Event_Kind (Event_New_User.Kind);
  Event.Set_Parameter ("email", "harry.potter@hogwarts.org");

```

The module will post the event by using the <b>Send_Event</b> operation.

```
  Manager.Send_Event (Event);
```

### Receiving an event ###
Modules or applications interested by a particular event will configure the event manager
to dispatch the event to an Ada bean event action.  The Ada bean is an object that must
implement a procedure that matches the prototype:

```
  type Action_Bean is new Util.Beans.Basic.Readonly_Bean ...;
  procedure Action (Bean : in out Action_Bean; Event : in AWA.Events.Module_Event'Class);
```

The Ada bean method and object are registered as other Ada beans.

The configuration file indicates how to bind the Ada bean action and the event together.
The action is specified using an EL Method Expression (See Ada EL or JSR 245).

```
  <on-event name="new_user">
      <action>#{ada_bean.action}</action>
  </on-event>
```

### Event queues and dispatchers ###
The **AWA.Events** framework posts events on queues and it uses a dispatcher to process them.
There are two kinds of dispatchers:

  * Synchronous dispatcher process the event when it is posted.  The task which posts the event invokes the Ada bean action.  In this dispatching mode, there is no event queue. If the action method raises an exception, it will however be blocked.

  * Asynchronous dispatcher are executed by dedicated tasks.  The event is put in an event queue.  A dispatcher task processes the event and invokes the action method at a later time.

When the event is queued, there are two types of event queues:

  * A Fifo memory queue manages the event and dispatches them in FIFO order. If the application is stopped, the events present in the Fifo queue are lost.

  * A persistent event queue manages the event in a similar way as the FIFO queue but saves them in the database.  If the application is stopped, events that have not yet been processed will be dispatched when the application is started again.

## Data Model ##



---

[Generated by Dynamo](http://code.google.com/p/ada-gen) _from awa-events.ads_