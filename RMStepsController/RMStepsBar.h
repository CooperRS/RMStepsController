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

@protocol RMStepsBarDataSource <NSObject>

- (NSUInteger)numberOfStepsInStepsBar:(RMStepsBar *)bar;
- (RMStep *)stepsBar:(RMStepsBar *)bar stepAtIndex:(NSUInteger)index;

@end

@protocol RMStepsBarDelegate <UIToolbarDelegate>

- (void)stepsBarDidSelectCancelButton:(RMStepsBar *)bar;
- (void)stepsBar:(RMStepsBar *)bar shouldSelectStepAtIndex:(NSInteger)index;

@end

@interface RMStepsBar : UIToolbar

@property (nonatomic, weak) id<RMStepsBarDelegate> delegate;
@property (nonatomic, weak) id<RMStepsBarDataSource> dataSource;

@property (nonatomic, assign) BOOL hideCancelButton;
@property (nonatomic, strong, readonly) UIButton *cancelButton;
@property (nonatomic, strong) UIColor *seperatorColor;

@property (nonatomic, assign) NSUInteger indexOfSelectedStep;

- (void)setIndexOfSelectedStep:(NSUInteger)newIndexOfSelectedStep animated:(BOOL)animated;

- (void)reloadData;

@end
