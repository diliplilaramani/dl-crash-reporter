//
//  DLCrashReporter.h
//  CrashReportSimplified
//
//  Created by Dilip Lilaramani on 6/4/13.
//  Copyright (c) 2013 Dilip Lilaramani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CrashReporter/CrashReporter.h>

@interface DLCrashReporter : NSObject
{
    BOOL enableNotification;
}

-(void)initiateDLCrashReporter:(BOOL)enableUserAlert;
-(void)pendingCrashAlert:(NSDictionary*)dictionary;

@end
