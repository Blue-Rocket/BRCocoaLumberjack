//
//  BRLog.m
//  BRCocoaLumberjack
//
//  Created by Matt on 8/16/13.
//  Copyright (c) 2013 Blue Rocket, Inc. Distributable under the terms of the Apache License, Version 2.0.
//

#import "BRLog.h"

#import <objc/runtime.h>
#import "BRLogConstants.h"

static NSMutableDictionary *logLevelClassMap;
static int defaultLogLevel;

@implementation BRLog

+ (void)initialize {
    logLevelClassMap = [[NSMutableDictionary alloc] initWithCapacity:4];
}

// DDLog.m overridden methods
+ (int)logLevelForClass:(Class)aClass {
	NSNumber *logLevel = [logLevelClassMap valueForKey:NSStringFromClass(aClass)];
    if (logLevel == nil) {
        Class superClass = aClass;
        while ((superClass = class_getSuperclass(superClass))) {
            NSNumber *superLogLevel = [logLevelClassMap valueForKey:NSStringFromClass(superClass)];
            if (superLogLevel != nil) {
                logLevel = superLogLevel;
                break;
            }
        }
    }
    return (logLevel) ? [logLevel intValue] : defaultLogLevel;
}

+ (void)setLogLevel:(int)logLevel forClass:(Class)aClass {
	if ( aClass != nil ) {
		[logLevelClassMap setObject:[NSNumber numberWithInt:logLevel] forKey:NSStringFromClass(aClass)];
	}
}

+ (int)logLevelForKey:(NSString *)levelString {
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

// Call this from application did launch.
+ (void)configureDynamicLog {
    NSString *envFilePath = [[NSBundle mainBundle] pathForResource:@"LocalEnvironment" ofType:@"plist"];
	NSDictionary *localEnv = [NSDictionary dictionaryWithContentsOfFile:envFilePath];
	if ( localEnv != nil ) {
		NSLog(@"Logging configuration loaded from %@", envFilePath);
		[self configureDynamicLogFromDictionary:localEnv];
	}
}

+ (void)configureDynamicLogFromDictionary:(NSDictionary *)localEnv {
    [logLevelClassMap removeAllObjects];
    defaultLogLevel = [self logLevelForKey:@"error"];
	id logging = [localEnv valueForKey:@"logging"];
	if ( [logging isKindOfClass:[NSDictionary class]] ) {
		NSDictionary *loggingMap = (NSDictionary *)logging;
        for (NSString *key in [loggingMap allKeys]) {
            NSString *value = [loggingMap valueForKey:key];
            int logLevel = [self logLevelForKey:[value lowercaseString]];
            if (logLevel != (int)-1) {
                if ([key isEqualToString:@"default"]) {
                    defaultLogLevel = logLevel;
                }
                else {
                    [self setLogLevel:logLevel forClassWithName:key];
                }
            }
        }
    }
}

@end
