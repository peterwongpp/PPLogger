//
//  PPLoggerConfiguration.m
//  PPLoggerExample
//
//  Created by Peter Wong on 1/2/14.
//  Copyright (c) 2014 PPP. All rights reserved.
//

#import "PPLoggerConfiguration.h"



@implementation PPLoggerConfiguration

+ (PPLoggerConfiguration *)defaultConfiguration
{
    PPLoggerConfiguration *defaultConfiguration = [[PPLoggerConfiguration alloc] init];

#ifdef DEBUG
    [defaultConfiguration setMinimumSeverity:PPLoggerSeverityDebug];
    [defaultConfiguration setDefaultSeverity:PPLoggerSeverityDebug];
    [defaultConfiguration setDefaultVerbosity:PPLoggerVerbosityDetailed];
#else
    [defaultConfiguration setMinimumSeverity:PPLoggerSeverityInfo];
    [defaultConfiguration setDefaultSeverity:PPLoggerSeverityDebug];
    [defaultConfiguration setDefaultVerbosity:PPLoggerVerbosityPlain];
#endif

    return defaultConfiguration;
}

+ (PPLoggerSeverity)severityOfTagRepresentation:(NSString *)tagRepresentation
{
    NSDictionary *mapping = @{
                              @"[UNSET]": @(PPLoggerSeverityUNSET),
                              @"[DEBUG]": @(PPLoggerSeverityDebug),
                              @"[INFO]": @(PPLoggerSeverityInfo),
                              @"[WARN]": @(PPLoggerSeverityWarn),
                              @"[ERROR]": @(PPLoggerSeverityError),
                              @"[FATAL]": @(PPLoggerSeverityFatal),
                              };
    return (PPLoggerSeverity)[mapping[tagRepresentation] integerValue];
}

+ (NSString *)tagRepresentationOfSeverity:(PPLoggerSeverity)severity
{
    NSDictionary *mapping = @{
                              @(PPLoggerSeverityUNSET): @"[UNSET]",
                              @(PPLoggerSeverityDebug): @"[DEBUG]",
                              @(PPLoggerSeverityInfo): @"[INFO]",
                              @(PPLoggerSeverityWarn): @"[WARN]",
                              @(PPLoggerSeverityError): @"[ERROR]",
                              @(PPLoggerSeverityFatal): @"[FATAL]",
                              };
    return mapping[@(severity)];
}

- (PPLoggerSeverity)normalizedSeverity:(PPLoggerSeverity)severity
{
    if (severity == PPLoggerSeverityUNSET) {
        return self.defaultSeverity;
    }
    return severity;
}

- (PPLoggerVerbosity)normalizedVerbosity:(PPLoggerVerbosity)verbosity
{
    if (verbosity == PPLoggerVerbosityUNSET) {
        return self.defaultVerbosity;
    }
    return verbosity;
}

- (BOOL)shouldLogUnderSeverity:(PPLoggerSeverity)severity verbosity:(PPLoggerVerbosity)verbosity
{
    BOOL severityOK = severity >= self.minimumSeverity;
    BOOL verbosityOK = verbosity != PPLoggerVerbosityNone;
    return severityOK && verbosityOK;
}

@end
