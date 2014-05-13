//
//  BRLogging.h
//  BRCocoaLumberjack
//
//  Created by Matt on 8/16/13.
//  Copyright (c) 2013 Blue Rocket, Inc. Distributable under the terms of the Apache License, Version 2.0.
//

#ifndef BRCocoaLumberjack_BRLogging_h
#define BRCocoaLumberjack_BRLogging_h

@protocol DDLogFormatter;

void BRLoggingSetupDefaultLogging();
void BRLoggingSetupDefaultLoggingWithBundle(NSBundle *bundle);
void BRLoggingSetupLogging(NSArray *loggers, id<DDLogFormatter> formatter, int defaultLevel, NSDictionary *dynamicLogging);

int BRLogLevelForClass(Class aClass);

#endif
