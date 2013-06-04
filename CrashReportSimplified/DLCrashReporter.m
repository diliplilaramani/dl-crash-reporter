//
//  DLCrashReporter.m
//  CrashReportSimplified
//
//  Created by Dilip Lilaramani on 6/4/13.
//  Copyright (c) 2013 Dilip Lilaramani. All rights reserved.
//

#import "DLCrashReporter.h"

@implementation DLCrashReporter

-(void)initiateDLCrashReporter
{
    enableNotification = YES;
    
    PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    NSError *error;
    // Check if we previously crashed
    if ([crashReporter hasPendingCrashReport])
        [self handleCrashReport];
    // Enable the Crash Reporter
    if (![crashReporter enableCrashReporterAndReturnError: &error])
        NSLog(@"Warning: Could not enable crash reporter: %@", error);
}
- (void) handleCrashReport {
    PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
    NSData *crashData;
    NSError *error;
    PLCrashReport *report = nil;
    PLCrashReportTextFormat textFormat = PLCrashReportTextFormatiOS;
    // Try loading the crash report
    crashData = [crashReporter loadPendingCrashReportDataAndReturnError: &error];
    if (crashData == nil) {
        NSLog(@"Could not load crash report: %@", error);
        goto finish;
    }
    // We could send the report from here, but we'll just print out
    // some debugging info instead
    report = [[PLCrashReport alloc] initWithData: crashData error: &error];
    if (report == nil) {
        NSLog(@"Could not parse crash report");
        goto finish;
    }else {
        NSString *log = [PLCrashReportTextFormatter stringValueForCrashReport: report withTextFormat: textFormat];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *outputPath = [documentsDirectory stringByAppendingPathComponent: @"app.crash"];
        if (![log writeToFile:outputPath atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
            NSLog(@"Failed to write crash report");
        } else {
            NSLog(@"Saved crash report to: %@", outputPath);
        }
    }
    
    // Purge the report
finish:
    [crashReporter purgePendingCrashReport];
    [self pendingCrashAlert:nil];
    return;
}
//-(void)enableUserAlert:(BOOL)enableUserAlert
//{
//    enableNotification = enableUserAlert;
//}
-(void)pendingCrashAlert:(NSDictionary*)dictionary
{
    if(enableNotification)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Crash Report" message:@"Crash Description" delegate:nil cancelButtonTitle:@"Ignore" otherButtonTitles:@"Send Report", nil];
        [alertView show];
    }
}
@end
