//
//  PPLogger.h
//  PPLoggerExample
//
//  Created by Peter Wong on 29/1/14.
//  Copyright (c) 2014 PPP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPLoggerConfiguration.h"

#define PPLogBase(_severity, _verbosity, _format, ...) [[PPLogger sharedInstance] log:[NSString stringWithFormat:_format, ##__VA_ARGS__] severity:_severity verbosity:_verbosity functionName:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__] lineNumber:__LINE__]

#define PPLog(_format, ...) PPLogBase(PPLoggerSeverityUNSET, PPLoggerVerbosityUNSET, _format, ##__VA_ARGS__)

#define PPLogDebug(_format, ...) PPLogBase(PPLoggerSeverityDebug, PPLoggerVerbosityUNSET, _format, ##__VA_ARGS__)
#define PPLogInfo(_format, ...) PPLogBase(PPLoggerSeverityInfo, PPLoggerVerbosityUNSET, _format, ##__VA_ARGS__)
#define PPLogWarn(_format, ...) PPLogBase(PPLoggerSeverityWarn, PPLoggerVerbosityUNSET, _format, ##__VA_ARGS__)
#define PPLogError(_format, ...) PPLogBase(PPLoggerSeverityError, PPLoggerVerbosityUNSET, _format, ##__VA_ARGS__)
#define PPLogFatal(_format, ...) PPLogBase(PPLoggerSeverityFatal, PPLoggerVerbosityUNSET, _format, ##__VA_ARGS__)

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
- (void) log:(NSString *)message severity:(PPLoggerSeverity)severity verbosity:(PPLoggerVerbosity)verbosity functionName:(NSString *)functionName lineNumber:(NSInteger)lineNumber;

@end
