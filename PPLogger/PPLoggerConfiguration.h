//
//  PPLoggerConfiguration.h
//  PPLoggerExample
//
//  Created by Peter Wong on 1/2/14.
//  Copyright (c) 2014 PPP. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
    Severity levels.
 */
typedef NS_ENUM(NSUInteger, PPLoggerSeverity) {
    PPLoggerSeverityUNSET,  /** Will use default. */
    PPLoggerSeverityDebug,  /** will translate to tag [DEBUG] */
    PPLoggerSeverityInfo,   /** will translate to tag [INFO] */
    PPLoggerSeverityWarn,   /** will translate to tag [WARN] */
    PPLoggerSeverityError,  /** will translate to tag [ERROR] */
    PPLoggerSeverityFatal   /** will translate to tag [FATAL] */
};

/**
    Verbosity levels.
 */
typedef NS_ENUM(NSUInteger, PPLoggerVerbosity) {
    PPLoggerVerbosityUNSET,     /** Will use default. */
    PPLoggerVerbosityNone,      /** Nothing will be logged. */
    PPLoggerVerbosityPlain,     /** Logs only the log messages. */
    PPLoggerVerbosityDetailed   /** Logs the log messages, together with class name, method name and line number. */
};

/**
    A PPLogger uses a PPLoggerConfiguration instance for default values. All the public properties are configurable.
 */
@interface PPLoggerConfiguration : NSObject

/**
    Translate the tag representation of a severity level back to PPLoggerSeverity type.
 
    @note The tag representation format is "[NAME]" (without the quotes).
    @note If the NAME is not matched, @c PPLoggerSeverityUNSET would be returned.
 */
+ (PPLoggerSeverity) severityOfTagRepresentation:(NSString *)tagRepresentation;
/**
    Translate the severity level to the tag representation.
 
    @note The tag representation format is "[NAME]" (without the quotes).
 */
+ (NSString *) tagRepresentationOfSeverity:(PPLoggerSeverity)severity;

/**
    A predefined default configuration for production-targeted use.
 */
+ (PPLoggerConfiguration *) defaultConfiguration;

/**
    The minimum severity that will be logged. Severity level lower than this will be ignored. For example, if you set @c minimumSeverity to @c PPLoggerSeverityInfo, any logs with @c PPLoggerSeverityDebug will be ignored.
 */
@property (nonatomic, assign) PPLoggerSeverity minimumSeverity;

/**
    The default severity used if you did not provide the severity explicitly.

    @note Only the lowest bit will be treated as the default value. For example if you set it to @c PPLoggerSeverityInfo|PPLoggerSeverityError, the default would be @c PPLoggerSeverityInfo.
 */
@property (nonatomic, assign) PPLoggerSeverity defaultSeverity;

/**
    The default verbosity used if you did not provide the verbosity explicitly.
 
    @note Only the lowest bit will be treated as the default value. For example if you set it to @c PPLoggerVerbosityPlain|PPLoggerVerbosityDetailed, the default would be @c PPLoggerVerbosityPlain.
 */
@property (nonatomic, assign) PPLoggerVerbosity defaultVerbosity;

/**
    Normalize the severity.

    @param severity The severity to be normalized.
    @return If the severity is UNSET, return the default severity. Otherwise return the untouched severity.
 */
- (PPLoggerSeverity) normalizedSeverity:(PPLoggerSeverity)severity;
/**
    Normalize the verbosity.

    @param verbosity The verbosity to be normalized.
    @return If the verbosity is UNSET, return the default verbosity. Otherwise return the untouched verbosity.
 */
- (PPLoggerVerbosity) normalizedVerbosity:(PPLoggerVerbosity)verbosity;

/**
    Determine should the message be logged under the given severity and verbosity.

    @param severity The severity to check against.
    @param verbosity The verbosity to check against.
    @return YES if should be logged, NO otherwise.
 */
- (BOOL) shouldLogUnderSeverity:(PPLoggerSeverity)severity verbosity:(PPLoggerVerbosity)verbosity;

@end
