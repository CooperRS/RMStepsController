//
//  RMStepSeperatorView.m
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

#import "RMStepSeperatorView.h"
#import <QuartzCore/QuartzCore.h>

@interface RMStepSeperatorView ()

@property (nonatomic, strong) CAShapeLayer *leftShapeLayer;
@property (nonatomic, strong) CAShapeLayer *rightShapeLayer;

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
    [rightBezier addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
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
    [bezier addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
    [bezier addLineToPoint:CGPointMake(0, self.frame.size.height)];
    
    [bezier setLineWidth:1.0];
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
