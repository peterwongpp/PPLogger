//
//  PPLogger.m
//  PPLoggerExample
//
//  Created by Peter Wong on 29/1/14.
//  Copyright (c) 2014 PPP. All rights reserved.
//

#import "PPLogger.h"

@interface PPLogger ()

- (NSString *) formatMessage:(NSString *)message severity:(PPLoggerSeverity)severity functionName:(NSString *)functionName lineNumber:(NSInteger)lineNumber underVerbosity:(PPLoggerVerbosity)verbosity;

@end

@implementation PPLogger

+ (PPLogger *)sharedInstance
{
    static PPLogger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PPLogger alloc] init];
    });
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        self.configuration = [PPLoggerConfiguration defaultConfiguration];
    }
    return self;
}

- (NSString *)formatMessage:(NSString *)message severity:(PPLoggerSeverity)severity functionName:(NSString *)functionName lineNumber:(NSInteger)lineNumber underVerbosity:(PPLoggerVerbosity)verbosity
{
    if (verbosity == PPLoggerVerbosityUNSET) {
        return @"";
    }

    NSMutableArray *parts = [NSMutableArray array];

    NSString *severityTag = [PPLoggerConfiguration tagRepresentationOfSeverity:severity];
    [parts addObject:severityTag];

    if (verbosity == PPLoggerVerbosityDetailed) {
        [parts addObject:[NSString stringWithFormat:@"%@", functionName]];
    }

    if (verbosity == PPLoggerVerbosityDetailed) {
        [parts addObject:[NSString stringWithFormat:@"[%d]", lineNumber]];
    }

    [parts addObject:message];

    return [parts componentsJoinedByString:@"\t"];
}

- (void)log:(NSString *)message severity:(PPLoggerSeverity)severity verbosity:(PPLoggerVerbosity)verbosity functionName:(NSString *)functionName lineNumber:(NSInteger)lineNumber
{
    PPLoggerSeverity minimumSeverity = self.configuration.minimumSeverity;
    PPLoggerSeverity defaultSeverity = self.configuration.defaultSeverity;
    PPLoggerVerbosity defaultVerbosity = self.configuration.defaultVerbosity;

    if (severity == PPLoggerSeverityUNSET) {
        severity = defaultSeverity;
    }
    if (verbosity == PPLoggerVerbosityUNSET) {
        verbosity = defaultVerbosity;
    }

    if (severity < minimumSeverity ||
        verbosity == PPLoggerVerbosityNone) {
        return;
    }

    NSString *formattedMessage = [self formatMessage:message severity:(PPLoggerSeverity)severity functionName:(NSString *)functionName lineNumber:lineNumber underVerbosity:verbosity];

    NSLogv(formattedMessage, nil);
}

@end
