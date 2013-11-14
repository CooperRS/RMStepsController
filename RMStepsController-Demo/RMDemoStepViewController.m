//
//  RMStepViewController.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMDemoStepViewController.h"

#import "RMStepsController.h"
#import "RMStep.h"

@interface RMDemoStepViewController ()

@end

@implementation RMDemoStepViewController

@synthesize stepsController = _stepsController;
@synthesize step = _step;

#pragma mark - Properties
- (RMStep *)step {
    if(!_step) {
        self.step = [[RMStep alloc] init];
        self.step.title = self.title;
    }
    
    return _step;
}

#pragma mark - Actions
- (IBAction)nextStepTapped:(id)sender {
    [self.stepsController showNextStep];
}

- (IBAction)previousStepTapped:(id)sender {
    [self.stepsController showPreviousStep];
}

@end
