# Requirements #

AWA and all its components have been compiled and tested on the
following platforms:

  * GNAT 2011 on Windows7 (gcc 4.5.3)
  * GNAT 2012 on Windows7 (gcc 4.5.3)
  * GNAT 2011 on Ubuntu (gcc 4.5.3)
  * gcc 4.4.3 on Ubuntu 11.04
  * gcc 4.6.2 on Ubuntu 12.04
  * gcc 4.7.2 on Ubuntu 12.04  (Facebook example will not work)
  * gcc 4.6.3 on NetBSD 5.1

You will need:

  * The AWS web server (compiled with SSL support),
  * The XML/Ada library,

To build on Windows, you will need the [Mingw32 Msys](http://www.mingw.org/) package.  To be able to create a new project with Dynamo you will also need [AutoConf for Windows](http://gnuwin32.sourceforge.net/packages/autoconf.htm).

# Building external packages first #

Before building AWA, you should have installed the XML Ada and the AWS
packages.  If you do not have them, you should build them and install them first.  You can build them by downloading the sources or you can
use the sources available in the `external` directory.  For this,
make sure the configure script was executed with the
`--enable-xmlada --enable-aws` options.  For example:

```
  ./configure --enable-xmlada --enable-aws
```

The XML Ada sources are extracted in the **xmlada** directory and
the AWS sources are extracted in the **aws** directory.  A utility script
is provided to help in the build.  After the configure, you should
run the following commands:

```
  cd xmlada && make && make install

  cd aws && make prefix="/usr/local" setup build install
```


# Configuration #

On Unix platforms, configure with:

```
  ./configure --prefix=/usr
```

On Windows, you can configure with:

```
  ./configure --prefix=d:/installation/dir
```

At this stage, if you don't have XML/Ada or AWS installed, an
error will be reported.  Check again step **Building external packages first**.

# Build #

For all plateform, you should build with make as follows:

```
  make
```

# Manual Build #

In case of problem, you could also build by using gnatmake or gprbuild.
In that case, you have to build each component individually.
Note that this method works for a specific component but it is not
recommended to build the AWA framework.

```
  cd util && gnatmake -p -Putil
  cd el && gnatmake -p -Pel
  cd security && gnatmake -p -Psecurity
  cd asf && gnatmake -p -Pasf
  cd ado && gnatmake -p -Pado
  cd awa && gnatmake -p -Pawa
  cd dynamo && gprbuild -p -Pdynamo
```

# Installation #

After the packages are built, you can install them as follows:

```
make install
```