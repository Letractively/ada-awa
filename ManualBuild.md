This page tries to explain how to build various packages
used by AWA manually.

A support script is provided in ada-awa-all to help in this task.
It can be used on Unix platforms as well as on Windows.

# Edit configuration #

Go in the `support` directory
```
  cd support
```

Check and modify the configuration by editing the file `build.config`.
  * If the file does not exist, copy `build.config.in`
  * Check the **PREFIX** variable which indicates where the packages will be installed.
  * Check that the PATH variable is correct

# Building XML Ada #

Copy the XML Ada source package:
```
  cp ../external/xmlada/xmlada-gpl-4.1-src.tgz .
```

Run the script that extracts, configures, builds and installs.
```
  sh ./build.sh xmlada-gpl-4.1-src
```


# Building AWS #

Copy the AWS source package:
```
  cp ../external/aws/aws-gpl-2.10.0-src.tgz .
```

Run the script that extracts, configures, builds and installs.
```
  sh ./build.sh aws-gpl-2.10.0-src
```