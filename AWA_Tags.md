## Introduction ##
The <b>Tags</b> module allows to associate general purpose tags to any database entity.
It provides a JSF component that allows to insert easily a list of tags in a page and
in a form.  An application can use the bean types defined in <tt>AWA.Tags.Beans</tt>
to define the tags and it will use the <tt>awa:tagList</tt> component to display them.
A tag cloud is also provided by the <tt>awa:tagCloud</tt> component.

## Model ##
The database model is generic and it uses the <tt>Entity_Type</tt> provided by
[ADO](http://ada-ado.googlecode.com) to associate a tag to entities stored in different
tables.  The <tt>Entity_Type</tt> identifies the database table and the stored identifier
in <tt>for_entity_id</tt> defines the entity in that table.

![http://ada-awa.googlecode.com/svn/wiki/awa_tags_model.png](http://ada-awa.googlecode.com/svn/wiki/awa_tags_model.png)

## Integration ##
The <tt>Tag_Module</tt> manages the tags associated with entities.  It provides operations
that are used by the tag beans together with the <tt>awa:tagList</tt> and
<tt>awa:tagCloud</tt> components to manage the tags.
An instance of the <tt>Tag_Module</tt> must be declared and registered in the AWA application.
The module instance can be defined as follows:

```
  type Application is new AWA.Applications.Application with record
     Tag_Module : aliased AWA.Votes.Modules.Tag_Module;
  end record;
```

And registered in the `Initialize_Modules` procedure by using:

```
  Register (App    => App.Self.all'Access,
            Name   => AWA.Tags.Modules.NAME,
            URI    => "tags",
            Module => App.Tag_Module'Access);
```
## Tag Beans ##
Several bean types are provided to represent and manage a list of tags.
The tag module registers the bean constructors when it is initialized.
To use them, one must declare a bean definition in the application XML configuration.

### Tag\_List\_Bean ###
The <tt>Tag_List_Bean</tt> holds a list of tags and provides operations used by the
<tt>awa:tagList</tt> component to add or remove tags within a <tt>h:form</tt> component.
A bean can be declared and configured as follows in the XML application configuration file:

```
  <managed-bean>
    <managed-bean-name>questionTags</managed-bean-name>
    <managed-bean-class>AWA.Tags.Beans.Tag_List_Bean</managed-bean-class>
    <managed-bean-scope>request</managed-bean-scope>
    <managed-property>
      <property-name>entity_type</property-name>
      <property-class>String</property-class>
      <value>awa_question</value>
    </managed-property>
    <managed-property>
      <property-name>permission</property-name>
      <property-class>String</property-class>
      <value>question-edit</value>
    </managed-property>
  </managed-bean>
```

The <tt>entity_type</tt> property defines the name of the database table to which the tags
are assigned.  The <tt>permission</tt> property defines the permission name that must be used
to verify that the user has the permission do add or remove the tag.  Such permission is
verified only when the <tt>awa:tagList</tt> component is used within a form.

### Tag\_Search\_Bean ###
The <tt>Tag_Search_Bean</tt> is dedicated to searching for tags that start with a given
pattern.  The auto complete feature of the <tt>awa:tagList</tt> component can use this
bean type to look in the database for tags matching a start pattern.  The declaration of the
bean should define the database table to search for tags associated with a given database
table.  This is done in the XML configuration with the <tt>entity_type</tt> property.

```
  <managed-bean>
    <managed-bean-name>questionTagSearch</managed-bean-name>
    <managed-bean-class>AWA.Tags.Beans.Tag_Search_Bean</managed-bean-class>
    <managed-bean-scope>request</managed-bean-scope>
    <managed-property>
      <property-name>entity_type</property-name>
      <property-class>String</property-class>
      <value>awa_question</value>
    </managed-property>
  </managed-bean>
```

### Tag\_Info\_List\_Bean ###
The <tt>Tag_Info_List_Bean</tt> holds a collection of tags with their weight.  It is used
by the <tt>awa:tagCloud</tt> component.

```
  <managed-bean>
    <managed-bean-name>questionTagList</managed-bean-name>
    <managed-bean-class>AWA.Tags.Beans.Tag_Info_List_Bean</managed-bean-class>
    <managed-bean-scope>request</managed-bean-scope>
    <managed-property>
      <property-name>entity_type</property-name>
      <property-class>String</property-class>
      <value>awa_question</value>
    </managed-property>
  </managed-bean>
```
## Tags Component ##

### Displaying a list of tags ###
The <tt>awa:tagList</tt> component displays a list of tags.  Each tag can be rendered as
a link if the <tt>tagLink</tt> attribute is defined.  The list of tags is passed in the
<tt>value</tt> attribute.  When rending that list, the <tt>var</tt> attribute is used to
setup a variable with the tag value.  The <tt>tagLink</tt> attribute is then evaluated
against that variable and the result defines the link.

```
  <awa:tagList value='#{questionList.tags}' id='qtags' styleClass="tagedit-list"
               tagLink="#{contextPath}/questions/tagged.html?tag=#{tagName}"
               var="tagName"
               tagClass="tagedit-listelement tagedit-listelement-old"/>
```

### Tag editing ###
The <tt>awa:tagList</tt> component allows to add or remove tags associated with a given
database entity.  The tag management works with the jQuery plugin <b>Tagedit</b>.  For this,
the page must include the <b>/js/jquery.tagedit.js</b> Javascript resource.

The tag edition is active only if the <tt>awa:tagList</tt> component is placed within an
<tt>h:form</tt> component.  The <tt>value</tt> attribute defines the list of tags.  This must
be a <tt>Tag_List_Bean</tt> object.

```
  <awa:tagList value='#{question.tags}' id='qtags'
               autoCompleteUrl='#{contextPath}/questions/lists/tag-search.html'/>
```

When the form is submitted and validated, the procedure <tt>Set_Added</tt> and
<tt>Set_Deleted</tt> are called on the value bean with the list of tags that were
added and removed.  These operations are called in the <tt>UPDATE_MODEL_VALUES</tt>
phase (ie, before calling the action's bean operation).

### Tag cloud ###
The <tt>awa:tagCloud</tt> component displays a list of tags as a tag cloud.
The tags list passed in the <tt>value</tt> attribute must inherit from the
<tt>Tag_Info_List_Bean</tt> type which indicates for each tag the number of
times it is used.

```
  <awa:tagCloud value='#{questionTagList}' id='cloud' styleClass="tag-cloud"
                var="tagName" rows="30"
                tagLink="#{contextPath}/questions/tagged.html?tag=#{tagName}"
                tagClass="tag-link"/>
```

## Queries ##
<h4>AWA.Tags.Models.Tag_Info</h4><p>The tag information.</p><table width='100%'>
<tr>
<th width='15%' align='left'>Type</th>
<th width='15%' align='left'>Ada</th>
<th width='20%' align='left'>Name</th>
<th width='50%' align='left'>Description</th>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the tag name.</td>
</tr>
<tr>
<td></td>
<td>Natural</td>
<td></td>
<td>the number of references for the tag.</td>
</tr>
</table>





---

[Generated by Dynamo](http://code.google.com/p/ada-gen) _from awa-tags.ads_