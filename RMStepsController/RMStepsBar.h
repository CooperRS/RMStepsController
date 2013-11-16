//
//  RMStepsBar.h
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

@class RMStepsBar;
@class RMStep;

/**
 This protocol is used by an instance of `RMStepsBar` to get the data it should display.
 */

@protocol RMStepsBarDataSource <NSObject>

/**
 Returns the number of steps for a certain `RMStepsBar`.
 
 @param bar The instance of `RMStepsBar` asking for the number of steps it should display.
 
 @return Number of steps thet should be displayed.
 */
- (NSUInteger)numberOfStepsInStepsBar:(RMStepsBar *)bar;

/**
 Returns an instance of `RMStep` that represents the stept at a certain index.
 
 @param bar The instance of `RMStepsBar` asking for a certain step.
 @param index The index of the step.
 
 @return An instance of `RMStep`.
 */
- (RMStep *)stepsBar:(RMStepsBar *)bar stepAtIndex:(NSUInteger)index;

@end

/**
 This protocol is used by an instance of `RMStepsBar` to tell the delegate that certain events have been triggered.
 */

@protocol RMStepsBarDelegate <UIToolbarDelegate>

/**
 Called by an instance of `RMStepsBar` after the user has selected the cancel button.
 
 @param bar The instance of `RMStepsBar`.
 */
- (void)stepsBarDidSelectCancelButton:(RMStepsBar *)bar;

/**
 Called by an instance of `RMStepsBar` after the user has selected a certain enabled step.
 
 @param bar The instance of `RMStepsBar`.
 @param index The index of the new selected step.
 */
- (void)stepsBar:(RMStepsBar *)bar shouldSelectStepAtIndex:(NSInteger)index;

@end

/**
 A `RMStepsBar` is a subclass of `UIToolbar`. It displays the progress of an user while going through an arbitrary number of steps.
 */

@interface RMStepsBar : UIToolbar

/**
 The delegate of this `RMStepsBar`. Must conform to the `RMStepsBarDelegate` protocol.
 */
@property (nonatomic, weak) id<RMStepsBarDelegate> delegate;

/**
 The data source of this `RMStepsBar`. Must conform to the `RMStepsBarDataSource` protocol.
 */
@property (nonatomic, weak) id<RMStepsBarDataSource> dataSource;

/**
 Used to hide or show the cancel button.
 */
@property (nonatomic, assign) BOOL hideCancelButton;

/**
 Used to access the cancel button and to customize its appearance.
 */
@property (nonatomic, strong, readonly) UIButton *cancelButton;

/**
 Used to set the seperator color.
 */
@property (nonatomic, strong) UIColor *seperatorColor;

/**
 Used to set the index of the selected step. When changing the selected step using this property the change will not be animated.
 
 @see `-[RMStepsBar setIndexOfSelectedStep:animated:]`
 */
@property (nonatomic, assign) NSUInteger indexOfSelectedStep;

/**
 Used to set the index of the selected step.
 
 @param newIndexOfSelectedStep The index of the new selected step.
 @param animated Enable or disable animations.
 */
- (void)setIndexOfSelectedStep:(NSUInteger)newIndexOfSelectedStep animated:(BOOL)animated;

/**
 Used to completely reload all data displayed ba this `RMStepsBar`. Any changes will not be animated.
 */
- (void)reloadData;

@end
