//
//  PPAppDelegate.m
//  PPLoggerExample
//
//  Created by Peter Wong on 29/1/14.
//  Copyright (c) 2014 PPP. All rights reserved.
//

#import "PPAppDelegate.h"
#import "PPLogger.h"

@implementation PPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    // Provide suitable log configuration depending on the environment.
    PPLoggerConfiguration *logConfiguration = [[PPLoggerConfiguration alloc] init];
    [logConfiguration setDefaultSeverity:PPLoggerSeverityDebug];
#ifdef DEBUG
    [logConfiguration setMinimumSeverity:PPLoggerSeverityDebug];
    [logConfiguration setDefaultVerbosity:PPLoggerVerbosityDetailed];
#else
    [logConfiguration setMinimumSeverity:PPLoggerSeverityInfo];
    [logConfiguration setDefaultVerbosity:PPLoggerVerbosityPlain];
#endif
    [[PPLogger sharedInstance] setConfiguration:logConfiguration];

#define PPLOGGER_SWIZZLE_NSLOG

#ifdef PPLOGGER_SWIZZLE_NSLOG
    NSLog(@"NSLog is swizzled and is the same as PPLog");
#else
    NSLog(@"NSLog is not swizzled and is untouched.");
#endif

    PPLog(@"default log message.");
    PPLog(@"usage should be similar to %@", @"NSLog");

    PPLogBase(PPLoggerSeverityUNSET, PPLoggerVerbosityUNSET, @"set to unset is same as using default value. So this is same as using PPLog.");

    PPLogBase(PPLoggerSeverityDebug, PPLoggerVerbosityUNSET, @"unset (i.e. default) debug.");
    PPLogBase(PPLoggerSeverityInfo, PPLoggerVerbosityUNSET, @"unset (i.e. default) info.");
    PPLogBase(PPLoggerSeverityWarn, PPLoggerVerbosityUNSET, @"unset (i.e. default) warn.");
    PPLogBase(PPLoggerSeverityError, PPLoggerVerbosityUNSET, @"unset (i.e. default) error.");
    PPLogBase(PPLoggerSeverityFatal, PPLoggerVerbosityUNSET, @"unset (i.e. default) fatal.");
    PPLogBase(PPLoggerSeverityFatal, PPLoggerVerbosityUNSET, @"unset (i.e. default) Error: %@", [NSError errorWithDomain:@"PPLoggerExample" code:10001 userInfo:nil]);

    PPLogBase(PPLoggerSeverityDebug, PPLoggerVerbosityNone, @"none debug.");
    PPLogBase(PPLoggerSeverityInfo, PPLoggerVerbosityNone, @"none info.");
    PPLogBase(PPLoggerSeverityWarn, PPLoggerVerbosityNone, @"none warn.");
    PPLogBase(PPLoggerSeverityError, PPLoggerVerbosityNone, @"none error.");
    PPLogBase(PPLoggerSeverityFatal, PPLoggerVerbosityNone, @"none fatal.");
    PPLogBase(PPLoggerSeverityFatal, PPLoggerVerbosityNone, @"none Error: %@", [NSError errorWithDomain:@"PPLoggerExample" code:10001 userInfo:nil]);

    PPLogBase(PPLoggerSeverityDebug, PPLoggerVerbosityPlain, @"plain debug.");
    PPLogBase(PPLoggerSeverityInfo, PPLoggerVerbosityPlain, @"plain info.");
    PPLogBase(PPLoggerSeverityWarn, PPLoggerVerbosityPlain, @"plain warn.");
    PPLogBase(PPLoggerSeverityError, PPLoggerVerbosityPlain, @"plain error.");
    PPLogBase(PPLoggerSeverityFatal, PPLoggerVerbosityPlain, @"plain fatal.");
    PPLogBase(PPLoggerSeverityFatal, PPLoggerVerbosityPlain, @"plain Error: %@", [NSError errorWithDomain:@"PPLoggerExample" code:10002 userInfo:nil]);

    PPLogBase(PPLoggerSeverityDebug, PPLoggerVerbosityDetailed, @"detailed debug.");
    PPLogBase(PPLoggerSeverityInfo, PPLoggerVerbosityDetailed, @"detailed info.");
    PPLogBase(PPLoggerSeverityWarn, PPLoggerVerbosityDetailed, @"detailed warn.");
    PPLogBase(PPLoggerSeverityError, PPLoggerVerbosityDetailed, @"detailed error.");
    PPLogBase(PPLoggerSeverityFatal, PPLoggerVerbosityDetailed, @"detailed fatal.");
    PPLogBase(PPLoggerSeverityFatal, PPLoggerVerbosityDetailed, @"detailed Error: %@", [NSError errorWithDomain:@"PPLoggerExample" code:10003 userInfo:nil]);

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
