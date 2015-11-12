Ada Web Application is a framework to build a web application.

## This project was moved to `GitHub`. ##

The new location is: https://github.com/stcarrez/ada-awa/wiki

The Git repository is: https://github.com/stcarrez/ada-awa.git


  * AWA uses [Ada Server Faces](http://code.google.com/p/ada-asf/) for the web framework.  This framework is using several patterns from the Java world such as [Java Server Faces](http://en.wikipedia.org/wiki/JavaServer_Faces) and [Java Servlets](http://en.wikipedia.org/wiki/Java_Servlet).
  * AWA provides a set of ready to use and extendable modules that are common to many web application.  This includes managing the login, authentication, users, permissions.
  * AWA uses an [Object Relational Mapping](http://en.wikipedia.org/wiki/Object-relational_mapping) that helps in writing Ada applications on top of MySQL or SQLite databases.  The [ADO framework](http://code.google.com/p/ada-ado) allows to map database objects into Ada records and access them easily.
  * To avoid the _blank page syndrome_, the [Dynamo](http://code.google.com/p/ada-gen) application generator is provided to quickly create a new project, add a new database model or add a presentation page.

![http://ada-awa.googlecode.com/svn/wiki/awa_architecture_overview.png](http://ada-awa.googlecode.com/svn/wiki/awa_architecture_overview.png)

The AWA framework runs on top of GNU/Linux, Windows or NetBSD.

## NEWS ##

Version 1.0 released on July 2014 is available http://download.vacs.fr/ada-awa/awa-all-1.0.0.tar.gz
  * New countries plugin to provide country/region/city data models
  * New settings plugin to control application user settings
  * New tags plugin to easily add tags in applications
  * New `<awa:tagList>` and `<awa:tagCloud>` components for tag display
  * Add tags to the question and blog plugins
  * Add comments to the blog post

## Documentation ##

  * [Installation](Installation.md)
  * [Getting Started](GettingStarted.md)
  * [AWA Events](AWA_Events.md)
  * [AWA Modules](AWA_Modules.md)
  * [AWA Permissions](AWA_Permissions.md)
  * [AWA Users](AWA_Users_Modules.md)
  * [AWA Blog Plugin](AWA_Blogs.md)
  * [AWA Comments](AWA_Comments.md)
  * [AWA Mail Plugin](AWA_Mail_Modules.md)
  * [AWA Tags Plugin](AWA_Tags.md)
  * [AWA Votes Plugin](AWA_Votes.md)
  * [Atlas, the Ada Web Application Demonstrator](http://blog.vacs.fr/index.php?post/2012/05/22/Atlas%2C-the-Ada-Web-Application-demonstrator)
  * [Tutorial to use Dynamo to build a database Ada application](http://code.google.com/p/ada-gen/wiki/UsingDynamo)

## Demo ##

  * [Atlas](http://demo.vacs.fr/atlas)
  * [Ada Server Faces demonstrations](http://demo.vacs.fr/demo)

## Tutorial ##

  * Step 1: [Ada Web Application: Setting up the project](http://blog.vacs.fr/vacs/blogs/post.html?post=2014/05/08/Ada-Web-Application-Setting-up-the-project)
  * Step 2: [Ada Web Application: Building the UML model](http://blog.vacs.fr/vacs/blogs/post.html?post=2014/05/18/Ada-Web-Application--Building-the-UML-model)
  * Step 3: [Review Web Application: Creating a review](http://blog.vacs.fr/vacs/blogs/post.html?post=2014/06/14/Review-Web-Application-Creating-a-review)
  * Step 4: [Review Web Application: Listing the reviews](http://blog.vacs.fr/vacs/blogs/post.html?post=2014/07/19/Review-Web-Application-Listing-the-reviews)