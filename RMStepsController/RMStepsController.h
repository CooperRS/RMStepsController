//
//  RMViewController.h
//  RMStepsController
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

#import "RMStepsBar.h"
#import "RMStep.h"

/**
 `RMStepsController` is an iOS control for guiding a user through a process step-by-step. It uses an instance of `RMStepsBar` for showing the currently selected step and the total number of steps.
 
 When creating subclasses of `RMStepsController` make sure you overwrite the following instance methods:
 
 - `-[RMStepsController stepViewControllers]`
 - `-[RMStepsController finishedAllSteps]`
 - `-[RMStepsController canceled]`
 
 */

@interface RMStepsController : UIViewController

/// @name Properties

/**
 Returns the instans of `RMStepsBar` used.
 */
@property (nonatomic, strong, readonly) RMStepsBar *stepsBar;

/**
 Returns an instance `NSMutableDictionary` which can be used for storing results of one step. These results can then be accessed by another step using the dictionary returned here.
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *results;

/// @name Instance Methods

/**
 A subclass of `RMStepsController` is supposed to return an array of view controllers here. Every view controller will be one step in the process. The first element in the array will be the first step and the last element will be the last step.
 
 The default implementation returns an empty array.
 
 @return An array with one view controller for every step.
 */
- (NSArray *)stepViewControllers;

/**
 Call this method to proceed to the next step. When you call this method when already in the last step `-[RMStepsController finishedAllSteps]`will be called.
 */
- (void)showNextStep;

/**
 Call this method to go one step back. When you call this method when already in the first step `-[RMStepsController canceled]`will be called.
 */
- (void)showPreviousStep;

/**
 This method is called after `-[RMStepsController showNextStep]` has been called in the last step. A subclass of `RMStepsController` is supposed to do whatever needs to be done here after all steps have been finished.
 */
- (void)finishedAllSteps;

/**
 This method is called after `-[RMStepsController showPreviousStep]` has been called in the first step. A subclass of `RMStepsController` is supposed to do whatever needs to be done here after the process has been canceled by the user.
 */
- (void)canceled;

@end

/**
 `UIViewController(RMStepsController)` is a category of `UIViewController` for providing mandatory properties so that a UIViewController can be used as a step in `RMStepsController`.
 */

@interface UIViewController (RMStepsController)

/**
 Provides access to the instance of `RMStepsController` this `UIViewController` is shown in as a child view controller.
 
 If this `UIViewController` is not part of any `RMStepsController` this property will be `nil`.
 */
@property (nonatomic, strong) RMStepsController *stepsController;

/**
 Provides access to an instance of `RMStep` associated with this `UIVIewController`.
 */
@property (nonatomic, strong) RMStep *step;

@end
