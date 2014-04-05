//
//  Apptimize+Compatibility.h
//  Apptimize
//
//  Copyright (c) 2014 Apptimize, Inc. All rights reserved.
//
//  WARNING: Methods and Constants in this file should not be used in new code!
//

#ifndef __deprecated_msg
#define __deprecated_msg(_msg) __deprecated
#endif

// The following are compatibility aliases that will likely be deprecated at some point in the future and should not be used in new code.
@interface Apptimize (CompatibilityAliases)

/**
 This is a compatability alias. You should prefer runTest:withBaseline:andVariations: for all new code.
 */
+ (void)runExperiment:(NSString *)experimentName withBaseline:(void (^)(void))baselineBlock andVariations:(NSDictionary *)variations;

/**
 This is a compatability alias. You should prefer runTest:withBaseline:variations:options: for all new code.
 */
+ (void)runExperiment:(NSString *)experimentName withBaseline:(void (^)(void))baselineBlock variations:(NSDictionary *)variations options:(NSDictionary *)options; // You should prefer runTest: for all new code.

/**
 This is a compatability alias. You should prefer metricAchieved: for all new code.
 */
+ (void)goalAchieved:(NSString *)goalName;

@end



// The following constants and methods are deprecated and will be removed in a future release.

extern NSString *const ApptimizeDevicePairingOption __deprecated;
extern NSString *const ApptimizeGestureRecognizerOption __deprecated;
extern NSString *const ApptimizeLogLevelOption __deprecated;

@interface Apptimize (Deprecated)

+ (void)setUpWithApplicationKey:(NSString *)applicationKey __deprecated_msg("This method should be removed in favor of Zero-Line Installation. See http://apptimize.com/docs/getting-started-ios/step-1-installation-ios/ for more information.");
+ (void)setUpWithApplicationKey:(NSString *)applicationKey options:(NSDictionary *)options __deprecated_msg("This method should be removed in favor of Zero-Line Installation. See http://apptimize.com/docs/getting-started-ios/step-1-installation-ios/ for more information.");

+ (NSString *)version __deprecated_msg("libraryVersion should be used for all new code.");

@end