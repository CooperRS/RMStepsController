//
//  RMAnotherDemoStepsViewController.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 15.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMAnotherDemoStepsViewController.h"

@interface RMAnotherDemoStepsViewController ()

@end

@implementation RMAnotherDemoStepsViewController

- (void)finishedAllSteps {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)canceled {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
