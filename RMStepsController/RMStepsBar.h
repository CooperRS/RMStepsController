//
//  RMStepsBar.h
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
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
