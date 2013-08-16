//
//  BRLog.h
//  BRCocoaLumberjack
//
//  Created by Matt on 8/16/13.
//  Copyright (c) 2013 Blue Rocket, Inc. Distributable under the terms of the Apache License, Version 2.0.
//

#import "DDLog.h"

@interface BRLog : DDLog

+ (void)configureDynamicLog;
+ (void)configureDynamicLogFromDictionary:(NSDictionary *)localEnv;

@end
