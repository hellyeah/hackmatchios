//
//  Apptimize.h
//  Apptimize (v2.0.0)
//
//  Copyright (c) 2014 Apptimize, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_5_1
#error "The Apptimize library uses features only available in iOS SDK 5.1 and later."
#endif


// Options for runExperiment:withBaseline:variations:options:
extern NSString *const ApptimizeUpdateMetadataTimeoutOption; // @(0) blocks until metadata is available, @(N) blocks for up-to N milliseconds. If this option is omitted, we will not block for metadata.

// Levels for setLogLevel:
extern NSString *const ApptimizeLogLevelVerbose;
extern NSString *const ApptimizeLogLevelDebug;
extern NSString *const ApptimizeLogLevelInfo;
extern NSString *const ApptimizeLogLevelWarn;
extern NSString *const ApptimizeLogLevelError;
extern NSString *const ApptimizeLogLevelOff; // default

// Info.plist keys
extern NSString *const ApptimizeAppKey; // Type: String
extern NSString *const ApptimizeDevicePairingEnabled; // Type: Boolean; Defaults to ON for dev builds. (Appstore signed builds never have pairing enabled.)


/*
 Getting Started:
 
 Add your Apptimize App Key to your application's Info.plist e.g.
 ApptimizeAppKey = "AaaaABbbbBCcccCDdddDEeeeEFfffF" // Type: String; Without quotes.
 
 For more information on how to get started using the Apptimize Library see:
 http://apptimize.com/docs/getting-started-ios/step-1-installation-ios/
 */


@interface Apptimize : NSObject

/**
 Run a test. Either the baseline or one of the variation blocks will be called synchronously exactly once
 per call. To run a test, set it up at https://apptimize.com/admin/ and then copy and paste the
 provided code template into your code to use this.
 */
+ (void)runTest:(NSString *)testName withBaseline:(void (^)(void))baselineBlock variations:(NSDictionary *)variations andOptions:(NSDictionary *)options;

/**
 Same as runExperiment:withBaseline:variations:options: passing nil for options.
 @see runExperiment:withBaseline:variations:options:
 */
+ (void)runTest:(NSString *)testName withBaseline:(void (^)(void))baselineBlock andVariations:(NSDictionary *)variations;

/**
 Report that a metric has been achieved. Set up a metric/test at https://apptimize.com/admin/ and then copy and paste the
 provided code template into your code to use this.
 */
+ (void)metricAchieved:(NSString *)metricName;

/**
 Inform Apptimize a numeric metric was recorded. Call this whenever a numeric metric has been recorded. The Apptimize
 administration website will instruct you on how to call this.
 */
+ (void)setMetric:(NSString*)metricName toValue:(double)value;

/**
 Inform Apptimize a numeric metric's value has changed. Call this to adjust a given numeric metric by the given amount.
 The Apptimize administration website will instruct you on how to call this.
 */
+ (void)addToMetric:(NSString*)metricName value:(double)value;

/**
 Set the log level of the Apptimize library.
 */
+ (void)setLogLevel:(NSString *)logLevel;

/**
 @return Returns the version number of the Apptimize library in this form: major.minor.build (e.g., 1.2.0)
 */
+ (NSString *)libraryVersion;

/**
 @return Returns the ID used by Apptimize to uniquely identify users of the current app
 */
+ (NSString *)userID;

@end

// Include compatability aliases and deprecated methods, these should not be used in new code.
#import "Apptimize+Compatibility.h"

