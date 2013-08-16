//
//  BRLogging.m
//  BRCocoaLumberjack
//
//  Created by Matt on 8/16/13.
//  Copyright (c) 2013 Blue Rocket, Inc. All rights reserved.
//

#import "BRLogging.h"

#import <objc/runtime.h>
#import "BRLogFormatter.h"
#import "BRLogConstants.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"

int BRCLogLevel;

static NSMutableDictionary *BRLogLevelClassMap;
static int BRDefaultLogLevel;

static void configureDynamicLogFromDictionary(NSDictionary * localEnv);

void BRLoggingSetupDefaultLogging() {
	BRLoggingSetupDefaultLoggingWithBundle([NSBundle mainBundle]);
}

void BRLoggingSetupDefaultLoggingWithBundle(NSBundle *bundle) {
    NSString *envFilePath = [bundle pathForResource:@"LocalEnvironment" ofType:@"plist"];
	NSDictionary *dynamic = [NSDictionary dictionaryWithContentsOfFile:envFilePath];
	if ( dynamic != nil ) {
		NSLog(@"Logging configuration loaded from %@", envFilePath);
	}
	BRLoggingSetupLogging(@[[DDASLLogger sharedInstance], [DDTTYLogger sharedInstance]],
						  [[BRLogFormatter alloc] init],
						  LOG_LEVEL_DEBUG,
						  dynamic);
}

void BRLoggingSetupLogging(NSArray *loggers, id formatter, int defaultLevel, NSDictionary *dynamicLogging) {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		BRLogLevelClassMap = [[NSMutableDictionary alloc] initWithCapacity:4];
	});
    BRCLogLevel = defaultLevel;
	BRDefaultLogLevel = defaultLevel;
	for ( id<DDLogger> logger in loggers ) {
		[DDLog addLogger:logger];
		[logger setLogFormatter:formatter];
	}
	
	configureDynamicLogFromDictionary(dynamicLogging);
}

int BRLogLevelForClass(Class aClass) {
	NSNumber *logLevel = [BRLogLevelClassMap valueForKey:NSStringFromClass(aClass)];
    if (logLevel == nil) {
        Class superClass = aClass;
        while ((superClass = class_getSuperclass(superClass))) {
            NSNumber *superLogLevel = [BRLogLevelClassMap valueForKey:NSStringFromClass(superClass)];
            if (superLogLevel != nil) {
                logLevel = superLogLevel;
                break;
            }
        }
    }
    return (logLevel) ? [logLevel intValue] : BRDefaultLogLevel;
}

static void setLogLevelForClass(int logLevel, Class aClass) {
	if ( aClass != nil ) {
		[BRLogLevelClassMap setObject:[NSNumber numberWithInt:logLevel] forKey:NSStringFromClass(aClass)];
	}
}

static int logLevelForKey(NSString * levelString) {
    if ( [levelString isEqualToString:@"error"] ) {
        return LOG_LEVEL_ERROR;
    } else if ( [levelString isEqualToString:@"warn"] ) {
        return LOG_LEVEL_WARN;
    } else if ( [levelString isEqualToString:@"info"] ) {
        return LOG_LEVEL_INFO;
    } else if ( [levelString isEqualToString:@"debug"] ) {
        return LOG_LEVEL_DEBUG;
    } else if ( [levelString isEqualToString:@"trace"] ) {
        return LOG_LEVEL_TRACE;
    }
    return -1;
}

static void configureDynamicLog() {
    NSString *envFilePath = [[NSBundle mainBundle] pathForResource:@"LocalEnvironment" ofType:@"plist"];
	NSDictionary *localEnv = [NSDictionary dictionaryWithContentsOfFile:envFilePath];
	if ( localEnv != nil ) {
		NSLog(@"Logging configuration loaded from %@", envFilePath);
		configureDynamicLogFromDictionary(localEnv);
	}
}

static void configureDynamicLogFromDictionary(NSDictionary * localEnv) {
    [BRLogLevelClassMap removeAllObjects];
	id logging = [localEnv valueForKey:@"logging"];
	if ( [logging isKindOfClass:[NSDictionary class]] ) {
		NSDictionary *loggingMap = (NSDictionary *)logging;
        for (NSString *key in [loggingMap allKeys]) {
            NSString *value = [loggingMap valueForKey:key];
            int logLevel = logLevelForKey([value lowercaseString]);
            if ( logLevel != (int)-1 ) {
                if ( [key isEqualToString:@"default"] ) {
                    BRDefaultLogLevel = logLevel;
                } else {
                    [DDLog setLogLevel:logLevel forClassWithName:key];
                }
            }
        }
    }
}
