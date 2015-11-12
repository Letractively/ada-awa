This short tutorial will help you create a first application and
get started easily with the AWA framework.  It assumes that you
have built and installed the complete AWA framework.

# Creating a project #

First, you will use the `dynamo` command to create your new project.
You must choose a project name.  This must be a valid Ada identifier
as it will be used for the application root package name.
The project files are created in the current directory.
You also indicate the license you want to use (**apache**, **gpl** or **proprietary**), your name and email address.  These parameters will
appear in the source headers.

```
dynamo create-project atlas -l apache Your-Name Your-Email
```

Once the project is created, it is ready to be configured, built and
executed.  The new project has the following structure:

|bin|Directory which will contain the application server|
|:--|:--------------------------------------------------|
|src|The application sources (Ada)                      |
|db |The application database models (XML and SQL files)|
|web|The presentation pages (HTML, XHTML, Javascript, ...)|
|web/css|The CSS presentation pages                         |
|web/images|The application images                             |
|web/js|The application javascript files                   |
|bundles|The resource bundles for application localization  |
|config|The application configuration files                |


# Configuring the project #

Your new project must be configured:

```
./configure
```

# Database Schema Generation #

The AWA framework uses either a MySQL or an SQLite database.
The application model files are defined according to the
[ADO](http://code.google.com/p/ada-ado) model: they are represented as
XML hibernate files.  From these XML files, the Ada model files as well
as the SQL files are created.  It is necessary to run the
`dynamo generate` command to build these files.

```
dynamo generate db
```

While doing so, the `dynamo` command looks at the application modules
and plugins which are used.  It generates SQL files that take into account
the data model defined by these modules and plugins.

# Database Creation #

You can create you MySQL database manually but it may be easier to
use again the `dynamo` command to generate the database, create the user,
and populate the database with tables.

```
dynamo create-database db 'mysql://localhost:3306/atlas_demo?user=atlas&password=atlas' root
```


# Building the project #

The project contains a Makefile as well as a GNAT project file.
The Makefile will invoke `gnatmake` to build the application.

```
make
```

You may also invoke `gnatmake` directly.  The GNAT project has the
name of the application.

```
gnatmake -Patlas
```

# Running the project #

Once the project is built, the `bin` directory will contain the
application server.  You just have to execute it.  The application server
contains the name of your project.

```
bin/atlas-server
```

When the server starts, it prints some log messages and one of them
tells you the URL you should connect to.

```
[2011-09-10 20:35:43] INFO  - Atlas.Server - Connect you browser to: http://localhost:8080/atlas/index.html
```

Point your browser to that URL to look at the page.

![http://ada-awa.googlecode.com/svn/wiki/dynamo-application.png](http://ada-awa.googlecode.com/svn/wiki/dynamo-application.png)

# Adding a new page #

Adding a new page is quite easy.  You just have to create a new XHTML file
somewhere in the `web` directory.  To help you, you can use `dynamo` to
create a page that you can modify.  When you invoke the following command:

```
dynamo add-page main
```

The file `web/main.xhtml` is created and your application server will now
expose a new web page `main.html`.  You can create new pages as well as modify them while your server is running.

# Video #

The short video below shows the above steps.

<a href='http://www.youtube.com/watch?feature=player_embedded&v=2VOZ4_p7h2o' target='_blank'><img src='http://img.youtube.com/vi/2VOZ4_p7h2o/0.jpg' width='425' height=344 /></a>