//
//  UIViewController+RMStepsController.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 15.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "UIViewController+RMStepsController.h"

#import <objc/runtime.h>

static char const * const stepsControllerKey = "stepsControllerKey";
static char const * const stepKey = "stepKey";

@implementation UIViewController (RMStepsController)

@dynamic stepsController, step;

#pragma marl - Properties
- (RMStepsController *)stepsController {
    return objc_getAssociatedObject(self, stepsControllerKey);
}

- (void)setStepsController:(RMStepsController *)stepsController {
    objc_setAssociatedObject(self, stepsControllerKey, stepsController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RMStep *)step {
    RMStep *aStep = objc_getAssociatedObject(self, stepKey);
    if(!aStep) {
        aStep = [[RMStep alloc] init];
        self.step = aStep;
    }
    
    return aStep;
}

- (void)setStep:(RMStep *)step {
    objc_setAssociatedObject(self, stepKey, step, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
