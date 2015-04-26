# BRCocoaLumberjackSampleApp

This simple sample app shows how to integrate **BRCocoaLumberjack** into an iOS project.
Class-level logging is configured in the _LocalEnvironment.plist_ file. Normally this file
would not be added to SCM, but for this project it is so as to demonstrate how class-level
logging is configured.

When the app launches, logging is configured and some log lines are written to the console,
like this:

		2015-04-27 11:05:06.473 BRCocoaLumberjackSampleApp[7763:114876] Logging configuration loaded from /Volumes/Renton/Users/matt/Library/Developer/CoreSimulator/Devices/1D0B1E8A-AD9E-4E5C-993E-046308DB16D3/data/Containers/Bundle/Application/83B02A30-9A9B-4B60-AEFB-BAD81132C8D3/BRCocoaLumberjackSampleApp.app/LocalEnvironment.plist
		2015-04-27 11:05:18.886 BRCocoaLumberjackSampleApp[7763:114876] Default log level set to 7; default C log level set to 7
		2015-04-27 11:05:34.392 BRCocoaLumberjackSampleApp[7763:114876] Default log level set to 7; default C log level set to 7
		2015-04-27 11:05:34.392 BRCocoaLumberjackSampleApp[7763:114876] Configuring class AppDelegate log level debug (15)
		INFO  04271105:34.501 607    AppDelegate.m:21 application:didFinishLaunchingWithOptions:| Hello from BRCocoaLumberjack: (null)
		DEBUG 04271105:34.503 607    AppDelegate.m:22 application:didFinishLaunchingWithOptions:| Debug logging enabled!

The first 4 lines are `NSLog` lines used while the logging system is initialized. After that,
the `INFO` and `DEBUG` lines show messages with different log levels being emitted.
