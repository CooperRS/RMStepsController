//
//  RMStepViewController.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMDemoStepViewController.h"

#import "UIViewController+RMStepsController.h"

@interface RMDemoStepViewController ()

@end

@implementation RMDemoStepViewController

#pragma mark - Actions
- (IBAction)nextStepTapped:(id)sender {
    [self.stepsController showNextStep];
}

- (IBAction)previousStepTapped:(id)sender {
    [self.stepsController showPreviousStep];
}

@end
