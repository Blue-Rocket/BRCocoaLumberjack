//
//  main.m
//  BRCocoaLumberjackSampleApp
//
//  Created by Matt on 4/27/15.
//  Copyright (c) 2015 Blue Rocket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BRCocoaLumberjack/BRCocoaLumberjack.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
	@autoreleasepool {
#ifdef LOGGING
		BRLoggingSetupDefaultLogging();
#endif
	    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	}
}
