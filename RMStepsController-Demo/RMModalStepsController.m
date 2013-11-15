//
//  RMDemoStepController.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMModalStepsController.h"

#import "RMDemoStepViewController.h"
#import "UIViewController+RMStepsController.h"

@interface RMModalStepsController ()

@end

@implementation RMModalStepsController

- (NSArray *)stepViewControllers {
    RMDemoStepViewController *firstStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep"];
    firstStep.step.title = @"First";
    
    RMDemoStepViewController *secondStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep2"];
    secondStep.step.title = @"Second";
    
    RMDemoStepViewController *thirdStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep3"];
    thirdStep.step.title = @"Third";
    
    RMDemoStepViewController *fourthStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep4"];
    fourthStep.step.title = @"Fourth";
    
    return @[firstStep, secondStep, thirdStep, fourthStep];
}

- (void)finishedAllSteps {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)canceled {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
