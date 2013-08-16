//
//  BRLog.h
//  BRCocoaLumberjack
//
//  Created by Matt on 8/16/13.
//  Copyright (c) 2013 Blue Rocket, Inc. All rights reserved.
//

#import "DDLog.h"

@interface BRLog : DDLog

+ (void)configureDynamicLog;
+ (void)configureDynamicLogFromDictionary:(NSDictionary *)localEnv;

@end
