//
//  RMStep.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMStep.h"

@interface RMStep ()

@property (nonatomic, strong, readwrite) UIView *stepView;
@property (nonatomic, strong, readwrite) UILabel *numberLabel;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@end

@implementation RMStep

#pragma mark Properties
- (UIView *)stepView {
    if(!_stepView) {
        self.stepView = [[UIView alloc] initWithFrame:CGRectZero];
        _stepView.translatesAutoresizingMaskIntoConstraints = NO;
        _stepView.clipsToBounds = YES;
        
        NSInteger radius = 12;
        CAShapeLayer *circle = [CAShapeLayer layer];
        circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius) cornerRadius:radius].CGPath;
        circle.position = CGPointMake(9, 10);
        circle.fillColor = [UIColor clearColor].CGColor;
        circle.strokeColor = [UIColor colorWithWhite:0 alpha:0.3].CGColor;
        circle.lineWidth = 1;
        [_stepView.layer addSublayer:circle];
        
        [_stepView addSubview:self.numberLabel];
        [_stepView addSubview:self.titleLabel];
        
        UILabel *titleLabel = self.titleLabel;
        UILabel *numberLabel = self.numberLabel;
        NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(titleLabel, numberLabel);
        
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(40)-[titleLabel]" options:0 metrics:nil views:bindingsDict]];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[titleLabel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(11)-[numberLabel]-(9)-[titleLabel]" options:0 metrics:nil views:bindingsDict]];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[numberLabel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    }
    
    return _stepView;
}

- (UILabel *)numberLabel {
    if(!_numberLabel) {
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.text = @"0";
        _numberLabel.textColor = [UIColor colorWithWhite:0 alpha:0.3];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        _numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _numberLabel;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0.3];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}

- (void)setTitle:(NSString *)newTitle {
    if(_title != newTitle) {
        _title = newTitle;
        
        self.titleLabel.text = newTitle;
    }
}

@end
