//
//  RMStep.h
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

#import <Foundation/Foundation.h>

/**
 A `RMStep` is used to set the title of a certain step and to customize the appearance of this step in a `RMStepsBar`
 */

@interface RMStep : NSObject

/**
 Provides access to the title of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) NSString *title;

/**
 Provides access to the selected bar color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *selectedBarColor;

/**
 Provides access to the enabled bar color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *enabledBarColor;

/**
 Provides access to the disabled bar color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *disabledBarColor;

/**
 Provides access to the selected text color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *selectedTextColor;

/**
 Provides access to the enabled text color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *enabledTextColor;

/**
 Provides access to the disabled text color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *disabledTextColor;

@end
