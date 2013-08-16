BRCocoaLumberjack
=================

CocoaLumberjack as a framework for iOS.

This project provides a way to integrate the [CocoaLumberjack](https://github.com/robbiehanson/CocoaLumberjack)
project easily into your own project, by providing a static library
framework that you can add rather than adding the sources directly. It also
provides a simple mechanism to use class-level logging, similar to what
the venerable [log4j](http://logging.apache.org/) provides in Java.

Example Usage
-------------

First to most easily integrate logging, add `BRCocoaLumberjack.h` to your PCH, something like this:

```objc
	#ifdef __OBJC__
		#import <UIKit/UIKit.h>
		#import <Foundation/Foundation.h>
		#import <BRCocoaLumberjack/BRCocoaLumberjack.h>
	#endif
```

Then you must configure the logging system, someplace early in the life of your application. How about in `main()`:

```objc
	int main(int argc, char *argv[]) {
		@autoreleasepool {
	#ifdef LOGGING
			BRLoggingSetupDefaultLogging();
	#endif
			return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
		}
	}
```

Note the `#ifdef LOGGING`. Unless you define this macro, logging anything less that at the *ERROR* level will not be enabled. Add `LOGGING=1` to your *Preprocessor Macros* build setting, probably just for the *Debug* configuration.

Then, when you want to log something in Objective-C, use the handy macros `log4X` or `DDLogX`, where `X`is one of *Error*, *Warn*, *Info*, *Debug*, or *Trace*. For example:

```objc
	DDLogDebug(@"Hi there, from %@", NSStringFromClass([self class]));
	log4Debug(@"Hi again, from %@", NSStringFromClass([self class]));
```

Note that `DDLogDebug` and `log4Debug` produce the same results, they are just two different styles to accomplish the same thing. The world loves variety, and the former style comes from CocoaLumberjack while the latter comes from the [log4cocoa](http://log4cocoa.sourceforge.net/) project (and is more similar to log4j if you're coming from that world).

Project Setup
-------------

After cloning the BRCocoaLumberjack repository, you must initialize git submodules.
For example:

	git clone git@github.com:Blue-Rocket/BRCocoaLumberjack.git
	cd BRCocoaLumberjack
	git submodule update --init
	
This will pull in the relevant submodules, e.g. CocoaLumberjack.

Static Framework Project Integration
------------------------------------

The BRCocoaLumberjack Xcode project includes a target called 
**BRCocoaLumberjack.framework** that builds a static library framework. Build 
that target, which will produce a `Framework/Release/BRCocoaLumberjack.framework` bundle at the root project directory. Copy that framework into your project and add it
as a build dependency.

Next, add `-ObjC` as an *Other Linker Flags* build setting.

Finally, you may need to add the path to the directory containing the 
`BRFullTextSearch.framework` bundle as a **Framework Search Paths** value
in the **Build Settings** tab of the project settings. Xcode may do this for you, however.
