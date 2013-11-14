//
//  RMStepsBar.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMStepsBar.h"

#import "RMStep.h"
#import "RMStepSeperatorView.h"

#define RM_CANCEL_BUTTON_WIDTH 50
#define RM_MINIMAL_STEP_WIDTH 40
#define RM_SEPERATOR_WIDTH 10

#define RM_LEFT_SEPERATOR_KEY @"RM_LEFT_SEPERATOR_KEY"
#define RM_RIGHT_SEPERATOR_KEY @"RM_RIGHT_SEPERATOR_KEY"
#define RM_STEP_KEY @"RM_STEP_KEY"
#define RM_STEP_WIDTH_CONSTRAINT_KEY @"RM_STEP_WIDTH_CONSTRAINT_KEY"

@interface RMStepsBar ()

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *cancelSeperator;

@property (nonatomic, strong) NSMutableArray *stepDictionaries;

@end

@implementation RMStepsBar

#pragma mark - Init and Dealloc
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.clipsToBounds = YES;
        
        self.topLine.frame = CGRectMake(0, 0, frame.size.width, 1);
        [self addSubview:self.topLine];
        
        self.bottomLine.frame = CGRectMake(0, frame.size.width-1, frame.size.width, 1);
        [self addSubview:self.bottomLine];
        
        self.cancelSeperator.frame = CGRectMake(RM_CANCEL_BUTTON_WIDTH, 0, 1, frame.size.height);
        [self addSubview:self.cancelSeperator];
    }
    return self;
}

#pragma mark - Properties
- (UIView *)topLine {
    if(!_topLine) {
        self.topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    }
    
    return _topLine;
}

- (UIView *)bottomLine {
    if(!_bottomLine) {
        self.bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    
    return _bottomLine;
}

- (UIView *)cancelSeperator {
    if(!_cancelSeperator) {
        self.cancelSeperator = [[UIView alloc] initWithFrame:CGRectZero];
        _cancelSeperator.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _cancelSeperator.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    }
    
    return _cancelSeperator;
}

- (NSMutableArray *)stepDictionaries {
    if(!_stepDictionaries) {
        self.stepDictionaries = [@[] mutableCopy];
    }
    
    return _stepDictionaries;
}

- (UIColor *)selectedColor {
    if(!_selectedColor) {
        self.selectedColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    }
    
    return _selectedColor;
}

- (UIColor *)enabledColor {
    if(!_enabledColor) {
        self.enabledColor = [UIColor colorWithWhite:0.85 alpha:0.5];
    }
    
    return _enabledColor;
}

- (UIColor *)disabledColor {
    if(!_disabledColor) {
        self.disabledColor = [UIColor clearColor];
    }
    
    return _disabledColor;
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
        
        if(animated)
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self layoutIfNeeded];
            } completion:nil];
        else
            [self layoutIfNeeded];
        
        [self updateStepsAnimated:animated];
    }
}

#pragma mark - Helper
- (void)updateStepsAnimated:(BOOL)animated {
    __weak RMStepsBar *blockself = self;
    [self.stepDictionaries enumerateObjectsUsingBlock:^(NSDictionary *aStepDict, NSUInteger idx, BOOL *stop) {
        if(blockself.indexOfSelectedStep > idx) {
            void (^stepAnimations)(void) = ^(void) {
                [(RMStep *)aStepDict[RM_STEP_KEY] stepView].backgroundColor = self.enabledColor;
            };
            
            if(animated)
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:stepAnimations completion:nil];
            else
                stepAnimations();
            
            [(RMStepSeperatorView *)aStepDict[RM_LEFT_SEPERATOR_KEY] setRightColor:self.enabledColor animated:animated];
            [(RMStepSeperatorView *)aStepDict[RM_RIGHT_SEPERATOR_KEY] setLeftColor:self.enabledColor animated:animated];
        } else if(blockself.indexOfSelectedStep == idx) {
            void (^stepAnimations)(void) = ^(void) {
                [(RMStep *)aStepDict[RM_STEP_KEY] stepView].backgroundColor = self.selectedColor;
            };
            
            if(animated)
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:stepAnimations completion:nil];
            else
                stepAnimations();
            
            [(RMStepSeperatorView *)aStepDict[RM_LEFT_SEPERATOR_KEY] setRightColor:self.selectedColor animated:animated];
            [(RMStepSeperatorView *)aStepDict[RM_RIGHT_SEPERATOR_KEY] setLeftColor:self.selectedColor animated:animated];
        } else if(blockself.indexOfSelectedStep < idx) {
            void (^stepAnimations)(void) = ^(void) {
                [(RMStep *)aStepDict[RM_STEP_KEY] stepView].backgroundColor = self.disabledColor;
            };
            
            if(animated)
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:stepAnimations completion:nil];
            else
                stepAnimations();
            
            [(RMStepSeperatorView *)aStepDict[RM_LEFT_SEPERATOR_KEY] setRightColor:self.disabledColor animated:animated];
            [(RMStepSeperatorView *)aStepDict[RM_RIGHT_SEPERATOR_KEY] setLeftColor:self.disabledColor animated:animated];
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
            rightSeperator.translatesAutoresizingMaskIntoConstraints = NO;
            
            [self addSubview:rightSeperator];
        }
        
        RMStep *step = [self.dataSource stepsBar:self stepAtIndex:i];
        step.numberLabel.text = [NSString stringWithFormat:@"%u", i+1];
        [self addSubview:step.stepView];
        
        UIView *leftEnd = leftSeperator ? leftSeperator : self.cancelSeperator;
        UIView *rightEnd = rightSeperator ? rightSeperator : self;
        UIView *stepView = step.stepView;
        NSNumber *minimalStepWidth = @(RM_MINIMAL_STEP_WIDTH);
        NSNumber *seperatorWidth = @(RM_SEPERATOR_WIDTH);
        
        NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(leftEnd, rightEnd, stepView);
        NSDictionary *metricsDict = NSDictionaryOfVariableBindings(minimalStepWidth, seperatorWidth);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(1)-[stepView]-(1)-|" options:0 metrics:metricsDict views:bindingsDict]];
        if(rightSeperator) {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[leftEnd]-(0)-[stepView]-(0)-[rightEnd]" options:0 metrics:metricsDict views:bindingsDict]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[rightEnd(seperatorWidth)]" options:0 metrics:metricsDict views:bindingsDict]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(1)-[rightEnd]-(1)-|" options:0 metrics:metricsDict views:bindingsDict]];
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

@end
