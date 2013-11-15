//
//  RMStepSeperatorView.h
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMStepSeperatorView : UIView

@property (nonatomic, strong) UIColor *seperatorColor;

- (void)setLeftColor:(UIColor *)leftColor animated:(BOOL)animated;
- (void)setRightColor:(UIColor *)rightColor animated:(BOOL)animated;

@end
