PPLogger
========

A subclass of UIImageView which loads image from URL asynchronously, with activity indicator on top.

Installation
------------

### Cocoapods

If you are not using cocoapods yet, you may know more at [here](http://cocoapods.org).

If you have already installed, you should have a `Podfile` file at your project's root directory.

Edit it with your favourite text editor to add the following line to the bottom of the Podfile:

    pod 'PPLogger', '~> 0.0'

Since the versioning is using [Semantic Versioning](http://semver.org), you are safe to use `~>` for backward-compatible changes.

Now you can install the dependencies from your command line:

    $ pod install

Finally, in the file you want to use the `PPLogger`, add the following import statement:

    #inport "PPLogger.h"

### Manual

Just copy all the classes from the `/PPLogger` directory to your project, then add the following to import:

    #inport "PPLogger.h"
    
Setup and usage
---------------

### Importing

You may want to add the import statement to your AppName-Prefix.pch so that PPLogger macros `PPLog` and `PPLog...` could be available to all classes.

Furthermore, if you are already using a lot of NSLog, and do not want to change, you may define the `PPLOGGER_SWIZZLE_NSLOG` constant before importing `PPLogger.h`:

    #define PPLOGGER_SWIZZLE_NSLOG
    import "PPLogger.h"

### Configuring

`PPLog` and `PPLog...` macros both uses the instance method of `[PPLogger sharedInstance]`. You may configure the shared instance in your app delegate (or anywhere before logs).

`[PPLogger sharedInstance]` provides a set of default configuration through its `configuration` property. It should fit the default usage, namely:

- Under development (with DEBUG constant)
    - PPLog logs to severity level DEBUG.
    - Minimum severity being shown is DEBUG level.
    - PPLog logs with verbosity level DETAILED.
- Other than development (without DEBUG constant, such as Release)
    - PPLog logs to severity level DEBUG.
    - Minimum severity being shown is INFO level. (that means PPLog messages wouldn't be logged)
    - PPLog logs with verbosity level PLAIN.

If you use other ways to determine the environments (such as Develop, Staging and Production), you may configure the configuration accordingly:

    PPLoggerConfiguration *configuration = [[PPLogger sharedInstance] configuration];
    [configuration setDefaultSeverity:PPLoggerSeverityDebug];
    #ifdef DEVELOP
        [configuration setMinimumSeverity:PPLoggerSeverityDebug];
        [configuration setDefaultVerbosity:PPLoggerVerbosityDetailed];
    #endif
    #ifdef STAGING
        [configuration setMinimumSeverity:PPLoggerSeverityInfo];
        [configuration setDefaultVerbosity:PPLoggerVerbosityDetailed];
    #endif
    #ifdef PRODUCTION
        [configuration setMinimumSeverity:PPLoggerSeverityInfo];
        [configuration setDefaultVerbosity:PPLoggerVerbosityPlain];
    #endif
    
### Usage

It is not recommented to show all logs to the user. Because there could be some sensitive data that should not be logged, or just too much details that the user does not need to know.

Because of this, `PPLog` macro, by the default configuration, logs to DEBUG level which is ignored when released.

So you may use `PPLog` (or `NSLog` if you defined `PPLOGGER_SWIZZLE_NSLOG` constant) for logging debug information for development use.

However, there are times you really want to leave some logs on the production release. Such as the reasons why some operation fails, or something not expected during development.

In this case, you may use `PPLogDebug`, `PPLogInfo`, `PPLogWarn`, `PPLogError` and `PPLogFatal` macros to log explicitly to the level you want.

All these macros uses `PPLoggerVerbosityUNSET`, which will translate to the debug verbosity of the configuration.

There is also a macro `PPLogBase` which is the base method of all the above macros. You may explicitly set the severity and verbosity. However, the above macros should already be enough and in most of the case you should not need to use this one (and actually not recommended to use `PPLogBase`).

Contribution
------------

- Fork, update and send pull request.
- Leave any comments, improvements, suggestions, ideas etc at to [Issues](https://github.com/peterwongpp/PPAsyncImageView/issues).

License
-------

PPLogger is made available under the [MIT License](http://opensource.org/licenses/MIT):

<pre>
The MIT License (MIT)

Copyright (c) 2014 Peter Wong

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
</pre>