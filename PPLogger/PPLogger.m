//
//  PPLogger.m
//  PPLoggerExample
//
//  Created by Peter Wong on 29/1/14.
//  Copyright (c) 2014 PPP. All rights reserved.
//

#import "PPLogger.h"

@interface PPLogger ()

- (NSString *) formatMessage:(NSString *)message severity:(PPLoggerSeverity)severity className:(NSString *)className methodName:(NSString *)methodName lineNumber:(NSInteger)lineNumber underVerbosity:(PPLoggerVerbosity)verbosity;

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

- (NSString *)formatMessage:(NSString *)message severity:(PPLoggerSeverity)severity className:(NSString *)className methodName:(NSString *)methodName lineNumber:(NSInteger)lineNumber underVerbosity:(PPLoggerVerbosity)verbosity
{
    if (verbosity == PPLoggerVerbosityUNSET) {
        return @"";
    }

    NSMutableArray *parts = [NSMutableArray array];

    NSString *severityTag = [PPLoggerConfiguration tagRepresentationOfSeverity:severity];
    [parts addObject:severityTag];

    if (verbosity == PPLoggerVerbosityDetailed) {
        NSString *verboseDetails = [NSString stringWithFormat:@"[%@][%@][%d]", className, methodName, lineNumber];
        [parts addObject:verboseDetails];
    }

    [parts addObject:message];

    return [parts componentsJoinedByString:@"\t"];
}

- (void)log:(NSString *)message severity:(PPLoggerSeverity)severity verbosity:(PPLoggerVerbosity)verbosity className:(NSString *)className methodName:(NSString *)methodName lineNumber:(NSInteger)lineNumber
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

    NSString *formattedMessage = [self formatMessage:message severity:(PPLoggerSeverity)severity className:className methodName:methodName lineNumber:lineNumber underVerbosity:verbosity];

    NSLogv(formattedMessage, nil);
}

@end