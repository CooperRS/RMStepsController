//
//  RMStep.m
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

#import "RMStep.h"

@interface RMStep ()

@property (nonatomic, strong, readwrite) UIView *stepView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation RMStep


- (void)updateConstrains {
    UILabel *titleLabel = self.titleLabel;
    UILabel *numberLabel = self.numberLabel;
    NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(titleLabel, numberLabel);
    
    NSArray* leftMarginConstraints;
    if (self.hideNumberLabel) {
        leftMarginConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(8)-[titleLabel]-(0)-|" options:0 metrics:nil views:bindingsDict];
    } else {
        leftMarginConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(40)-[titleLabel]-(0)-|" options:0 metrics:nil views:bindingsDict];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(11)-[numberLabel]-(9)-[titleLabel]" options:0 metrics:nil views:bindingsDict]];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[numberLabel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    }
    
    [_stepView addConstraints: leftMarginConstraints];
    [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[titleLabel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    
    [self.stepView setNeedsUpdateConstraints];
}

#pragma mark Properties
- (UIView *)stepView {
    if(!_stepView) {
        self.stepView = [[UIView alloc] initWithFrame:CGRectZero];
        _stepView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_stepView.layer addSublayer:self.circleLayer];
        
        [_stepView addSubview:self.numberLabel];
        [_stepView addSubview:self.titleLabel];
        
        [self updateConstrains];
    }
    
    return _stepView;
}

- (UILabel *)numberLabel {
    if(!_numberLabel) {
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.text = @"0";
        _numberLabel.textColor = self.disabledNumberColor;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.font = self.numberFont;
        _numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        if (_fillNumberLabel) {
            _numberLabel.textColor = [UIColor whiteColor];
        }
    }
    
    return _numberLabel;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = self.title;
        _titleLabel.textColor = self.disabledTextColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = self.titleFont;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}

- (CAShapeLayer *)circleLayer {
    if(!_circleLayer) {
        NSInteger radius = 12;
        
        self.circleLayer = [CAShapeLayer layer];
        _circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius) cornerRadius:radius].CGPath;
        _circleLayer.position = CGPointMake(9, 10);
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.strokeColor = self.disabledNumberColor.CGColor;
        _circleLayer.lineWidth = 1;
        
        if (_fillNumberLabel) {
            _circleLayer.fillColor = self.disabledNumberColor.CGColor;
        }
    }
    
    return _circleLayer;
}

- (void)setTitle:(NSString *)newTitle {
    if(_title != newTitle) {
        _title = newTitle;
        
        self.titleLabel.text = newTitle;
    }
}

- (UIColor *)selectedBarColor {
    if(!_selectedBarColor) {
        self.selectedBarColor = [UIColor colorWithRed:23./255. green:220./255. blue:108./255. alpha:1];
    }
    
    return _selectedBarColor;
}

- (UIColor *)enabledBarColor {
    if(!_enabledBarColor) {
        self.enabledBarColor = [UIColor colorWithWhite:142./255. alpha:0.5];
    }
    
    return _enabledBarColor;
}

- (UIColor *)disabledBarColor {
    if(!_disabledBarColor) {
        self.disabledBarColor = [UIColor clearColor];
    }
    
    return _disabledBarColor;
}

- (UIColor *)selectedTextColor {
    if(!_selectedTextColor) {
        self.selectedTextColor = [UIColor colorWithWhite:1 alpha:1];
    }
    
    return _selectedTextColor;
}

- (UIColor *)enabledTextColor {
    if(!_enabledTextColor) {
        self.enabledTextColor = [UIColor colorWithWhite:1 alpha:1];
    }
    
    return _enabledTextColor;
}

- (UIColor *)disabledTextColor {
    if(!_disabledTextColor) {
        self.disabledTextColor = [UIColor colorWithWhite:0.75 alpha:1];
    }
    
    return _disabledTextColor;
}

- (UIColor *)selectedNumberColor {
    if(!_selectedNumberColor) {
        self.selectedNumberColor = [UIColor colorWithWhite:1 alpha:1];
    }
    
    return _selectedNumberColor;
}

- (UIColor *)enabledNumberColor {
    if(!_enabledNumberColor) {
        self.enabledNumberColor = [UIColor colorWithWhite:1 alpha:1];
    }
    
    return _enabledNumberColor;
}

- (UIColor *)disabledNumberColor {
    if(!_disabledNumberColor) {
        self.disabledNumberColor = [UIColor colorWithWhite:0.75 alpha:1];
    }
    
    return _disabledNumberColor;
}


- (void)setHideNumberLabel:(BOOL)hideNumberLabel {
    _hideNumberLabel = hideNumberLabel;
    
    for (NSLayoutConstraint* contraint in self.stepView.constraints)
    {
        [self.stepView removeConstraint: contraint];
    }
    
    self.numberLabel.hidden = hideNumberLabel;
    self.circleLayer.hidden = hideNumberLabel;
    
    [self updateConstrains];
}

@end
