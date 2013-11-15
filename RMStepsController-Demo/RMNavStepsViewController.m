//
//  RMAnotherDemoStepsViewController.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 15.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMNavStepsViewController.h"

@interface RMNavStepsViewController ()

@end

@implementation RMNavStepsViewController

#pragma mark - Init and Dealloc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stepsBar.hideCancelButton = YES;
}

#pragma mark - Actions
- (void)finishedAllSteps {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)canceled {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
