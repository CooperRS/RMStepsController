//
//  UIViewController+RMStepsController.h
//  RMStepsController-Demo
//
//  Created by Roland Moers on 15.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RMStepsController.h"
#import "RMStep.h"

@interface UIViewController (RMStepsController)

@property (nonatomic, strong) RMStepsController *stepsController;
@property (nonatomic, strong) RMStep *step;

@end
