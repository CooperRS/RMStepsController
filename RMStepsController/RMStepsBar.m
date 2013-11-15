//
//  RMStepsBar.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMStepsBar.h"

#import "RMStep+Private.h"
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
        
        self.topLine.frame = CGRectMake(0, 0, frame.size.width, 1);
        [self addSubview:self.topLine];
        
        self.bottomLine.frame = CGRectMake(0, frame.size.width-1, frame.size.width, 1);
        [self addSubview:self.bottomLine];
        
        self.cancelButton.frame = CGRectMake(0, 1, RM_CANCEL_BUTTON_WIDTH, frame.size.height-2);
        [self addSubview:self.cancelButton];
        
        self.cancelSeperator.frame = CGRectMake(RM_CANCEL_BUTTON_WIDTH, 0, 1, frame.size.height);
        [self addSubview:self.cancelSeperator];
        
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
        _topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    }
    
    return _topLine;
}

- (UIView *)bottomLine {
    if(!_bottomLine) {
        self.bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = self.seperatorColor;
        _bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    
    return _bottomLine;
}

- (UIButton *)cancelButton {
    if(!_cancelButton) {
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"X" forState:UIControlStateNormal];
        _cancelButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        [_cancelButton setTitleColor:[UIColor colorWithWhite:142./255. alpha:0.5] forState:UIControlStateNormal];
        
        [_cancelButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}

- (UIView *)cancelSeperator {
    if(!_cancelSeperator) {
        self.cancelSeperator = [[UIView alloc] initWithFrame:CGRectZero];
        _cancelSeperator.backgroundColor = self.seperatorColor;
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
        RMStep *step = (RMStep *)aStepDict[RM_STEP_KEY];
        RMStepSeperatorView *leftSeperator = (RMStepSeperatorView *)aStepDict[RM_LEFT_SEPERATOR_KEY];
        RMStepSeperatorView *rightSeperator = (RMStepSeperatorView *)aStepDict[RM_RIGHT_SEPERATOR_KEY];
        
        if(blockself.indexOfSelectedStep > idx) {
            void (^stepAnimations)(void) = ^(void) {
                step.stepView.backgroundColor = step.enabledBarColor;
                step.titleLabel.textColor = step.enabledTextColor;
                step.numberLabel.textColor = step.enabledTextColor;
                step.circleLayer.strokeColor = step.enabledTextColor.CGColor;
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

- (void)cancelButtonTapped:(id)sender {
    [self.delegate stepsBarDidSelectCancelButton:self];
}

- (void)recognizedTap:(UIGestureRecognizer *)recognizer {
    CGPoint touchLocation = [recognizer locationInView:self];
    for(NSDictionary *aStepDict in self.stepDictionaries) {
        RMStep *step = aStepDict[RM_STEP_KEY];
        
        if(CGRectContainsPoint(step.stepView.frame, touchLocation)) {
            NSInteger index = [self.stepDictionaries indexOfObject:aStepDict];
            if(index < self.indexOfSelectedStep) {
                [self.delegate stepsBar:self shouldSelectStepAtIndex:index];
            }
        }
    }
}

@end
