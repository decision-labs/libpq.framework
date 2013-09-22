#libpq.framework for iOS 6.1
**An XCode project to compile your own libpq.framework for iOS 6.1**

[libpq](http://www.postgresql.org/docs/current/interactive/libpq.html) is a set of library functions that allow client programs to pass queries to the [PostgreSQL](http://www.postgresql.org/) backend database server and to receive the results of these sql queries.

This repository allows you to easily create a `libpq.framework` to use in your iOS applications.

##Getting Started

`libpq.framework` has no external dependencies apart from `libssl.a` and `libcrypto.a` from OpenSSL, which we download and compile by using the `build-libssl.sh` script so that you can be sure you are downloading it from the official OpenSSL repository. So getting started is easy:

* Install [Git](http://git-scm.com/) and the latest Xcode with the iOS 6.1 SDK.

* Make sure that `xcode-select` points to the correct location by running:

    `sudo /usr/bin/xcode-select --switch /Applications/Xcode.app/Contents/Developer`

* Fork this repo from GitHub:

    `git clone git://github.com/spacialdb/libpq.framwework.git`

* Run the script to download and compile OpenSSL:

    `./build-libssl.sh`

* Open `libpq.xcodeproj` with XCode and *build* the framework.

##Download precompiled Framework

You can also download a precompiled `libpq.framework` from: [libpq.framework.zip](http://bit.ly/libpq-framework)

##Usage

Drop the framework into your project's Navigator and don't forget to copy it to your project, and you should be ready to go. See libpq's [example programs](http://www.postgresql.org/docs/current/interactive/libpq-example.html) for sample code. In general for Objective-C one would need to do something like:

```Objective-C
#import <libpq/libpq-fe.h>

const char *_connectionString;
...
PGconn *_pgconn = PQconnectdb(_connectionString);
if (PQstatus(_pgconn) != CONNECTION_OK) {
    ...
}

PGresult *res = PQexec(_pgconn, "BEGIN");
if (PQresultStatus(res) != PGRES_TUPLES_OK) {
    ...
}
PQclear(res);
...

PQfinish(_pgconn);
```

##Licenses

PostgreSQL is released under the [PostgreSQL](http://www.opensource.org/licenses/postgresql) License, a liberal Open Source license, similar to the BSD or MIT licenses. See the [COPYRIGHT.PostgreSQL](https://github.com/spacialdb/libpq.framework/blob/master/COPYRIGHT.PostgreSQL) file.

The [OpenSSL](http://www.openssl.org/) toolkit stays under a dual license, i.e. both the conditions of the OpenSSL License and the original SSLeay License apply to the toolkit. See the [LICENSE.OpenSSL](https://github.com/spacialdb/libpq.framework/blob/master/LICENSE.OpenSSL) file for the actual license texts.

This work itself uses Felix Schulze's `build-libssl.sh` script from the [OpenSSL-for-iPhone](https://github.com/x2on/OpenSSL-for-iPhone) project and Jeff Verkoeyen's [iOS-Framework](https://github.com/jverkoey/iOS-Framework); and is licensed under the MIT license. See the [LICENSE](https://github.com/spacialdb/libpq.framework/blob/master/LICENSE) file for the details.
