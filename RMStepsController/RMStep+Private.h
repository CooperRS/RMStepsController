//
//  RMStep+Private.h
//  RMStepsController-Demo
//
//  Created by Roland Moers on 15.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMStep.h"

@interface RMStep (Private)

@property (nonatomic, strong, readonly) UIView *stepView;
@property (nonatomic, strong, readonly) UILabel *numberLabel;
@property (nonatomic, strong, readonly) UILabel *titleLabel;

@property (nonatomic, strong, readonly) CAShapeLayer *circleLayer;

@end
