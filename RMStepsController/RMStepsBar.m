//
//  RMStepsBar.m
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

#import "RMStepsBar.h"
#import <QuartzCore/QuartzCore.h>

#import "RMStep.h"

#define RM_CANCEL_BUTTON_WIDTH 50
#define RM_MINIMAL_STEP_WIDTH 40
#define RM_SEPERATOR_WIDTH 10

#define RM_LEFT_SEPERATOR_KEY @"RM_LEFT_SEPERATOR_KEY"
#define RM_RIGHT_SEPERATOR_KEY @"RM_RIGHT_SEPERATOR_KEY"
#define RM_STEP_KEY @"RM_STEP_KEY"
#define RM_STEP_WIDTH_CONSTRAINT_KEY @"RM_STEP_WIDTH_CONSTRAINT_KEY"

#pragma mark - Helper Categories

@interface RMStep (Private)

@property (nonatomic, strong, readonly) UIView *stepView;
@property (nonatomic, strong, readonly) UILabel *numberLabel;
@property (nonatomic, strong, readonly) UILabel *titleLabel;

@property (nonatomic, strong, readonly) CAShapeLayer *circleLayer;

@end

#pragma mark - Helper Classes

@interface RMStepSeperatorView : UIView

@property (nonatomic, strong) CAShapeLayer *leftShapeLayer;
@property (nonatomic, strong) CAShapeLayer *rightShapeLayer;

@property (nonatomic, strong) UIColor *seperatorColor;

- (void)setLeftColor:(UIColor *)leftColor animated:(BOOL)animated;
- (void)setRightColor:(UIColor *)rightColor animated:(BOOL)animated;

@end


@implementation RMStepSeperatorView

#pragma mark - Init and Dealloc
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.layer addSublayer:self.leftShapeLayer];
        [self.layer addSublayer:self.rightShapeLayer];
    }
    return self;
}

#pragma mark - Properties
- (UIColor *)seperatorColor {
    if(!_seperatorColor) {
        self.seperatorColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    
    return _seperatorColor;
}

- (CAShapeLayer *)leftShapeLayer {
    if(!_leftShapeLayer) {
        self.leftShapeLayer = [CAShapeLayer layer];
        _leftShapeLayer.actions = @{@"fillColor": [NSNull null]};
    }
    
    return _leftShapeLayer;
}

- (CAShapeLayer *)rightShapeLayer {
    if(!_rightShapeLayer) {
        self.rightShapeLayer = [CAShapeLayer layer];
        _rightShapeLayer.actions = @{@"fillColor": [NSNull null]};
    }
    
    return _rightShapeLayer;
}

- (void)setLeftColor:(UIColor *)leftColor animated:(BOOL)animated {
    if(animated) {
        CABasicAnimation *fillColorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
        fillColorAnimation.duration = 0.3;
        fillColorAnimation.fromValue = (id)[[self.leftShapeLayer presentationLayer] valueForKey:@"fillColor"];
        fillColorAnimation.toValue = (id)leftColor.CGColor;
        fillColorAnimation.delegate = self;
        fillColorAnimation.removedOnCompletion = NO;
        fillColorAnimation.fillMode = kCAFillModeForwards;
        fillColorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [self.leftShapeLayer addAnimation:fillColorAnimation forKey:@"fillColor"];
    } else {
        self.leftShapeLayer.fillColor = leftColor.CGColor;
    }
}

- (void)setRightColor:(UIColor *)rightColor animated:(BOOL)animated {
    if(animated) {
        CABasicAnimation *fillColorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
        fillColorAnimation.duration = 0.3;
        fillColorAnimation.fromValue = (id)[[self.rightShapeLayer presentationLayer] valueForKey:@"fillColor"];
        fillColorAnimation.toValue = (id)rightColor.CGColor;
        fillColorAnimation.delegate = self;
        fillColorAnimation.removedOnCompletion = NO;
        fillColorAnimation.fillMode = kCAFillModeForwards;
        fillColorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [self.rightShapeLayer addAnimation:fillColorAnimation forKey:@"fillColor"];
    } else {
        self.rightShapeLayer.fillColor = rightColor.CGColor;
    }
}

#pragma mark - Layout
- (void)layoutSubviews {
    UIBezierPath *leftBezier = [UIBezierPath bezierPath];
    [leftBezier moveToPoint:CGPointMake(0, 0)];
    [leftBezier addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
    [leftBezier addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [leftBezier closePath];
    
    [self.leftShapeLayer setPath:leftBezier.CGPath];
    [self.leftShapeLayer setBounds:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.leftShapeLayer setAnchorPoint:CGPointMake(0, 0)];
    [self.leftShapeLayer setPosition:CGPointMake(0, 0)];
    
    UIBezierPath *rightBezier = [UIBezierPath bezierPath];
    [rightBezier moveToPoint:CGPointMake(0, 0)];
    [rightBezier addLineToPoint:CGPointMake(self.frame.size.width-0.5, self.frame.size.height/2)];
    [rightBezier addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [rightBezier addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [rightBezier addLineToPoint:CGPointMake(self.frame.size.width, 0)];
    [rightBezier closePath];
    
    [self.rightShapeLayer setPath:rightBezier.CGPath];
    [self.rightShapeLayer setBounds:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.rightShapeLayer setAnchorPoint:CGPointMake(0, 0)];
    [self.rightShapeLayer setPosition:CGPointMake(0, 0)];
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(0, 0)];
    [bezier addLineToPoint:CGPointMake(self.frame.size.width-0.5, self.frame.size.height/2)];
    [bezier addLineToPoint:CGPointMake(0, self.frame.size.height)];
    
    [bezier setLineWidth:0.5];
    [bezier setLineJoinStyle:kCGLineJoinBevel];
    
    [self.seperatorColor setStroke];
    [bezier stroke];
}

#pragma mark - Animations
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if(flag) {
        if(anim == [self.leftShapeLayer animationForKey:@"fillColor"]) {
            self.leftShapeLayer.fillColor = (__bridge CGColorRef)([(CABasicAnimation *)anim toValue]);
        } else if(anim == [self.rightShapeLayer animationForKey:@"fillColor"]) {
            self.rightShapeLayer.fillColor = (__bridge CGColorRef)([(CABasicAnimation *)anim toValue]);
        }
    }
}

@end

#pragma mark - Main Implementation

@interface RMStepsBar ()

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *cancelSeperator;

@property (nonatomic, strong) NSLayoutConstraint *cancelButtonXConstraint;
@property (nonatomic, strong, readwrite) UIButton *cancelButton;

@property (nonatomic, strong) NSMutableArray *stepDictionaries;

@end

@implementation RMStepsBar

@synthesize seperatorColor = _seperatorColor;

#pragma mark - Init and Dealloc
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.clipsToBounds = YES;
        
        self.topLine.frame = CGRectMake(0, frame.size.height-43, frame.size.width, 0.4);
        [self addSubview:self.topLine];
        
        self.bottomLine.frame = CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5);
        [self addSubview:self.bottomLine];
        
        self.cancelButton.frame = CGRectMake(0, frame.size.height-43, RM_CANCEL_BUTTON_WIDTH, 42);
        [self addSubview:self.cancelButton];
        
        self.cancelSeperator.frame = CGRectMake(RM_CANCEL_BUTTON_WIDTH, frame.size.height-44, 0.5, frame.size.height);
        [self addSubview:self.cancelSeperator];
        
        NSNumber *cancelWidth = @(RM_CANCEL_BUTTON_WIDTH);
        
        NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(_topLine, _bottomLine, _cancelButton, _cancelSeperator);
        NSDictionary *metricsDict = NSDictionaryOfVariableBindings(cancelWidth);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[_topLine]-(0)-|" options:0 metrics:metricsDict views:bindingsDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[_bottomLine]-(0)-|" options:0 metrics:metricsDict views:bindingsDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_cancelButton(cancelWidth)]-(0)-[_cancelSeperator(0.5)]" options:0 metrics:metricsDict views:bindingsDict]];
        
        self.cancelButtonXConstraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[_cancelButton]" options:0 metrics:metricsDict views:bindingsDict] lastObject];
        [self addConstraint:self.cancelButtonXConstraint];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topLine(0.5)]-(43)-[_bottomLine(0.5)]-(0)-|" options:0 metrics:metricsDict views:bindingsDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_cancelButton(43)]-(0.5)-|" options:0 metrics:metricsDict views:bindingsDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_cancelSeperator(43)]-(0.5)-|" options:0 metrics:metricsDict views:bindingsDict]];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recognizedTap:)]];
    }
    return self;
}

#pragma mark - Properties
- (UIColor *)seperatorColor {
    if(!_seperatorColor) {
        self.seperatorColor = [UIColor colorWithWhite:0.75 alpha:1];
    }
    
    return _seperatorColor;
}

- (void)setSeperatorColor:(UIColor *)newSeperatorColor {
    if(newSeperatorColor != _seperatorColor) {
        _seperatorColor = newSeperatorColor;
        
        self.topLine.backgroundColor = newSeperatorColor;
        self.bottomLine.backgroundColor = newSeperatorColor;
        
        for(NSDictionary *aStepDict in self.stepDictionaries) {
            if(aStepDict[RM_RIGHT_SEPERATOR_KEY]) {
                [(RMStepSeperatorView *)aStepDict[RM_RIGHT_SEPERATOR_KEY] setSeperatorColor:newSeperatorColor];
            }
        }
    }
}

- (UIView *)topLine {
    if(!_topLine) {
        self.topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = self.seperatorColor;
        _topLine.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _topLine;
}

- (UIView *)bottomLine {
    if(!_bottomLine) {
        self.bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = self.seperatorColor;
        _bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _bottomLine;
}

- (void)setHideCancelButton:(BOOL)newHideCancelButton {
    [self setHideCancelButton:newHideCancelButton animated:NO];
}

- (void)setHideCancelButton:(BOOL)newHideCancelButton animated:(BOOL)animated {
    if(_hideCancelButton != newHideCancelButton) {
        _hideCancelButton = newHideCancelButton;
        
        if(newHideCancelButton)
            self.cancelButtonXConstraint.constant = -(RM_CANCEL_BUTTON_WIDTH+1);
        else
            self.cancelButtonXConstraint.constant = 0;
        
        if (animated) {
            __weak RMStepsBar *blockself = self;
            [UIView animateWithDuration:0.3 animations:^{
                [blockself layoutIfNeeded];
            }];
        }
    }
}


- (UIButton *)cancelButton {
    if(!_cancelButton) {
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"X" forState:UIControlStateNormal];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_cancelButton setTitleColor:[UIColor colorWithWhite:142./255. alpha:0.5] forState:UIControlStateNormal];
        
        [_cancelButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}

- (UIView *)cancelSeperator {
    if(!_cancelSeperator) {
        self.cancelSeperator = [[UIView alloc] initWithFrame:CGRectZero];
        _cancelSeperator.backgroundColor = self.seperatorColor;
        _cancelSeperator.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _cancelSeperator;
}

- (NSMutableArray *)stepDictionaries {
    if(!_stepDictionaries) {
        self.stepDictionaries = [@[] mutableCopy];
    }
    
    return _stepDictionaries;
}

- (void)setIndexOfSelectedStep:(NSUInteger)newIndexOfSelectedStep {
    [self setIndexOfSelectedStep:newIndexOfSelectedStep animated:NO];
}

- (void)setIndexOfSelectedStep:(NSUInteger)newIndexOfSelectedStep animated:(BOOL)animated {
    if(_indexOfSelectedStep != newIndexOfSelectedStep) {
        NSDictionary *oldStepDict = [self.stepDictionaries objectAtIndex:_indexOfSelectedStep];
        NSDictionary *newStepDict = [self.stepDictionaries objectAtIndex:newIndexOfSelectedStep];
        
        [self removeConstraint:newStepDict[RM_STEP_WIDTH_CONSTRAINT_KEY]];
        [self addConstraint:oldStepDict[RM_STEP_WIDTH_CONSTRAINT_KEY]];
        
        _indexOfSelectedStep = newIndexOfSelectedStep;
        
        if(animated) {
            __block RMStepsBar *blockself = self;
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                [blockself layoutIfNeeded];
            } completion:nil];
        } else
            [self layoutIfNeeded];
        
        [self updateStepsAnimated:animated];
    } else {
        [self updateStepsAnimated:NO];
    }
}

#pragma mark - Helper
- (void)updateStepsAnimated:(BOOL)animated {
    __weak RMStepsBar *blockself = self;
    [self.stepDictionaries enumerateObjectsUsingBlock:^(NSDictionary *aStepDict, NSUInteger idx, BOOL *stop) {
        RMStep *step = (RMStep *)aStepDict[RM_STEP_KEY];
        RMStepSeperatorView *leftSeperator = (RMStepSeperatorView *)aStepDict[RM_LEFT_SEPERATOR_KEY];
        RMStepSeperatorView *rightSeperator = (RMStepSeperatorView *)aStepDict[RM_RIGHT_SEPERATOR_KEY];
        
        if(blockself.indexOfSelectedStep > idx) {
            void (^stepAnimations)(void) = ^(void) {
                step.stepView.backgroundColor = step.enabledBarColor;
                step.titleLabel.textColor = step.enabledTextColor;
                step.numberLabel.textColor = step.enabledTextColor;
                step.circleLayer.strokeColor = step.enabledTextColor.CGColor;
                step.hideNumberLabel = NO;
            };
            
            if(animated)
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:stepAnimations completion:nil];
            else
                stepAnimations();
            
            [leftSeperator setRightColor:step.enabledBarColor animated:animated];
            [rightSeperator setLeftColor:step.enabledBarColor animated:animated];
        } else if(blockself.indexOfSelectedStep == idx) {
            void (^stepAnimations)(void) = ^(void) {
                step.stepView.backgroundColor = step.selectedBarColor;
                step.titleLabel.textColor = step.selectedTextColor;
                step.numberLabel.textColor = step.selectedTextColor;
                step.circleLayer.strokeColor = step.selectedTextColor.CGColor;
                step.hideNumberLabel = self.hideNumberLabelWhenActiveStep;
            };
            
            if(animated)
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:stepAnimations completion:nil];
            else
                stepAnimations();
            
            [leftSeperator setRightColor:step.selectedBarColor animated:animated];
            [rightSeperator setLeftColor:step.selectedBarColor animated:animated];
        } else if(blockself.indexOfSelectedStep < idx) {
            void (^stepAnimations)(void) = ^(void) {
                step.stepView.backgroundColor = step.disabledBarColor;
                step.titleLabel.textColor = step.disabledTextColor;
                step.numberLabel.textColor = step.disabledTextColor;
                step.circleLayer.strokeColor = step.disabledTextColor.CGColor;
                step.hideNumberLabel = NO;
            };
            
            if(animated)
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:stepAnimations completion:nil];
            else
                stepAnimations();
            
            [leftSeperator setRightColor:step.disabledBarColor animated:animated];
            [rightSeperator setLeftColor:step.disabledBarColor animated:animated];
        }
    }];
}


#pragma mark - Actions
- (void)reloadData {
    [self.stepDictionaries enumerateObjectsUsingBlock:^(NSDictionary *aStepDict, NSUInteger idx, BOOL *stop) {
        if((RMStepSeperatorView *)aStepDict[RM_RIGHT_SEPERATOR_KEY])
            [(RMStepSeperatorView *)aStepDict[RM_RIGHT_SEPERATOR_KEY] removeFromSuperview];
        [[(RMStep *)aStepDict[RM_STEP_KEY] stepView] removeFromSuperview];
    }];
    [self.stepDictionaries removeAllObjects];
    
    RMStepSeperatorView *leftSeperator = nil;
    RMStepSeperatorView *rightSeperator = nil;
    
    __block NSUInteger numberOfSteps = [self.dataSource numberOfStepsInStepsBar:self];
    for(NSUInteger i=0 ; i<numberOfSteps ; i++) {
        leftSeperator = rightSeperator;
        
        if(i == numberOfSteps-1) {
            rightSeperator = nil;
        } else {
            rightSeperator = [[RMStepSeperatorView alloc] initWithFrame:CGRectZero];
            rightSeperator.seperatorColor = self.seperatorColor;
            rightSeperator.translatesAutoresizingMaskIntoConstraints = NO;
            
            [self addSubview:rightSeperator];
        }
        
        RMStep *step = [self.dataSource stepsBar:self stepAtIndex:i];
        step.numberLabel.text = [NSString stringWithFormat:@"%lu", (long unsigned)i+1];
        [self addSubview:step.stepView];
        
        UIView *leftEnd = leftSeperator ? leftSeperator : self.cancelSeperator;
        UIView *rightEnd = rightSeperator ? rightSeperator : self;
        UIView *stepView = step.stepView;
        NSNumber *minimalStepWidth = @(RM_MINIMAL_STEP_WIDTH);
        NSNumber *seperatorWidth = @(RM_SEPERATOR_WIDTH);
        
        NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(leftEnd, rightEnd, stepView);
        NSDictionary *metricsDict = NSDictionaryOfVariableBindings(minimalStepWidth, seperatorWidth);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[stepView(44)]-(0)-|" options:0 metrics:metricsDict views:bindingsDict]];
        if(rightSeperator) {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[leftEnd]-(0)-[stepView]-(0)-[rightEnd]" options:0 metrics:metricsDict views:bindingsDict]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[rightEnd(seperatorWidth)]" options:0 metrics:metricsDict views:bindingsDict]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rightEnd(44)]-(0)-|" options:0 metrics:metricsDict views:bindingsDict]];
        } else {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[leftEnd]-(0)-[stepView]-(0)-|" options:0 metrics:metricsDict views:bindingsDict]];
        }
        
        NSArray *widthConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[stepView(minimalStepWidth)]" options:0 metrics:metricsDict views:bindingsDict];
        if(i != self.indexOfSelectedStep) {
            [self addConstraint:[widthConstraints lastObject]];
        }
        
        if(leftSeperator && rightSeperator) {
            [self.stepDictionaries addObject:@{RM_LEFT_SEPERATOR_KEY: leftSeperator, RM_STEP_KEY: step, RM_RIGHT_SEPERATOR_KEY: rightSeperator, RM_STEP_WIDTH_CONSTRAINT_KEY: [widthConstraints lastObject]}];
        } else if(leftSeperator && !rightSeperator) {
            [self.stepDictionaries addObject:@{RM_LEFT_SEPERATOR_KEY: leftSeperator, RM_STEP_KEY: step, RM_STEP_WIDTH_CONSTRAINT_KEY: [widthConstraints lastObject]}];
        } else if(!leftSeperator && rightSeperator) {
            [self.stepDictionaries addObject:@{RM_STEP_KEY: step, RM_RIGHT_SEPERATOR_KEY: rightSeperator, RM_STEP_WIDTH_CONSTRAINT_KEY: [widthConstraints lastObject]}];
        }
        
        [self updateStepsAnimated:NO];
    }
}

- (void)cancelButtonTapped:(id)sender {
    [self.delegate stepsBarDidSelectCancelButton:self];
}

- (void)recognizedTap:(UIGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:self];
    for(NSDictionary *aStepDict in self.stepDictionaries) {
        RMStep *step = aStepDict[RM_STEP_KEY];
        
        if(CGRectContainsPoint(step.stepView.frame, touchLocation)) {
            NSInteger index = [self.stepDictionaries indexOfObject:aStepDict];
            if(index < self.indexOfSelectedStep && self.allowBackward) {
                [self.delegate stepsBar:self shouldSelectStepAtIndex:index];
            }
        }
    }
}

@end
