//
//  RMViewController.h
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMStepsController;
@class RMStep;
@class RMStepsBar;

@protocol RMStepViewController <NSObject>

@property (nonatomic, strong) RMStepsController *stepsController;
@property (nonatomic, strong) RMStep *step;

@end

@interface RMStepsController : UIViewController

@property (nonatomic, strong, readonly) RMStepsBar *stepsBar;
@property (nonatomic, strong, readonly) NSMutableDictionary *results;

- (NSArray *)stepViewControllers;

- (void)showNextStep;
- (void)showPreviousStep;

- (void)finishedAllSteps;
- (void)canceled;

@end
