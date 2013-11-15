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

@property (nonatomic, strong) UIColor *selectedBarColor;
@property (nonatomic, strong) UIColor *enabledBarColor;
@property (nonatomic, strong) UIColor *disabledBarColor;

@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *enabledTextColor;
@property (nonatomic, strong) UIColor *disabledTextColor;

@end
