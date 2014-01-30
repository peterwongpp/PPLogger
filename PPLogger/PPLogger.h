//
//  PPLogger.h
//  PPLoggerExample
//
//  Created by Peter Wong on 29/1/14.
//  Copyright (c) 2014 PPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPLoggerConfiguration.h"

#define PPLogBase(_severity, _verbosity, _format, ...) [[PPLogger sharedInstance] log:[NSString stringWithFormat:_format, ##__VA_ARGS__] severity:_severity verbosity:_verbosity className:NSStringFromClass([self class]) methodName:NSStringFromSelector(_cmd) lineNumber:__LINE__]

#define PPLog(_format, ...) PPLogBase(PPLoggerSeverityUNSET, PPLoggerVerbosityUNSET, _format, ##__VA_ARGS__)

#ifdef PPLOGGER_SWIZZLE_NSLOG
#undef NSLog
#define NSLog(_format, ...)		PPLog(_format, ##__VA_ARGS__)
#endif

@interface PPLogger : NSObject

/**
    When you use log macros such as @c PPLog, the message will be directed to the sharedInstance automatically.
 */
+ (PPLogger *) sharedInstance;

/**
    Provides default values. You probably want different configurations for development and production environments.
 */
@property (nonatomic, strong) PPLoggerConfiguration *configuration;

/**
    Logs message. You should use the @c PPLog and @c PPLogBase macros.
 */
- (void) log:(NSString *)message severity:(PPLoggerSeverity)severity verbosity:(PPLoggerVerbosity)verbosity className:(NSString *)className methodName:(NSString *)methodName lineNumber:(NSInteger)lineNumber;

@end
