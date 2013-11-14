//
//  RMStep.h
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMStep : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong, readonly) UIView *stepView;
@property (nonatomic, strong, readonly) UILabel *numberLabel;
@property (nonatomic, strong, readonly) UILabel *titleLabel;

@end
