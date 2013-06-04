//
//  ViewController.m
//  CrashReportSimplified
//
//  Created by Dilip Lilaramani on 6/4/13.
//  Copyright (c) 2013 Dilip Lilaramani. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CrashButton {
    
    NSArray *arr = [[NSArray alloc] init];
    NSLog(@"%@",[arr objectAtIndex:0]);
}
@end
