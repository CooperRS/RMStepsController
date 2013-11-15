//
//  RMDemoStepController.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMDemoStepsController.h"

#import "RMDemoStepViewController.h"
#import "UIViewController+RMStepsController.h"

@interface RMDemoStepsController ()

@end

@implementation RMDemoStepsController

- (NSArray *)stepViewControllers {
    RMDemoStepViewController *firstStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep"];
    firstStep.step.title = @"First";
    
    RMDemoStepViewController *secondStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep2"];
    secondStep.step.title = @"Second";
    secondStep.step.selectedBarColor = [UIColor redColor];
    
    RMDemoStepViewController *thirdStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep3"];
    thirdStep.step.title = @"Third";
    thirdStep.step.selectedBarColor = [UIColor blueColor];
    
    RMDemoStepViewController *fourthStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep4"];
    fourthStep.step.title = @"Fourth";
    
    return @[firstStep, secondStep, thirdStep, fourthStep];
}

@end
