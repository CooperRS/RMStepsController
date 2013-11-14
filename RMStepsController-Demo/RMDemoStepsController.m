//
//  RMDemoStepController.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMDemoStepsController.h"

#import "RMDemoStepViewController.h"

@interface RMDemoStepsController ()

@end

@implementation RMDemoStepsController

- (NSArray *)stepViewControllers {
    RMDemoStepViewController *firstStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep"];
    firstStep.title = @"First";
    
    RMDemoStepViewController *secondStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep2"];
    secondStep.title = @"Second";
    
    RMDemoStepViewController *thirdStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep3"];
    thirdStep.title = @"Third";
    
    return @[firstStep, secondStep, thirdStep];
}

@end
