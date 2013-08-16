//
//  BRLogging.h
//  BRCocoaLumberjack
//
//  Created by Matt on 8/16/13.
//  Copyright (c) 2013 Blue Rocket, Inc. All rights reserved.
//

#ifndef BRCocoaLumberjack_BRLogging_h
#define BRCocoaLumberjack_BRLogging_h

void BRLoggingSetupDefaultLogging();
void BRLoggingSetupDefaultLoggingWithBundle(NSBundle *bundle);
void BRLoggingSetupLogging(NSArray *loggers, id formatter, int defaultLevel, NSDictionary *dynamicLogging);

int BRLogLevelForClass(Class aClass);

#endif
