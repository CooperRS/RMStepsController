//
//  RMDemoStepController.m
//  RMStepsController-Demo
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

#import "RMModalStepsController.h"

@interface RMModalStepsController ()

@end

@implementation RMModalStepsController

- (NSArray *)stepViewControllers {
    UIViewController *firstStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep"];
    firstStep.step.title = @"First";
    
    UIViewController *secondStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep2"];
    secondStep.step.title = @"Second";
    
    UIViewController *thirdStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep3"];
    thirdStep.step.title = @"Third";
    
    UIViewController *fourthStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep4"];
    fourthStep.step.title = @"Fourth";
    
    UIViewController *fifthStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep5"];
    fifthStep.step.title = @"Fifth";
    
    UIViewController *sixthStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep6"];
    sixthStep.step.title = @"Sixth";
    
    UIViewController *seventhStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep7"];
    seventhStep.step.title = @"Seventh";
    
    UIViewController *eigthStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep8"];
    eigthStep.step.title = @"Eigth";
    
    UIViewController *ninethStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep9"];
    ninethStep.step.title = @"Nineth";
    
    UIViewController *tenthStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep10"];
    tenthStep.step.title = @"Tenth";
    
    //return @[firstStep, secondStep, thirdStep, fourthStep, fifthStep];
    return @[firstStep, secondStep, thirdStep, fourthStep, fifthStep, sixthStep, seventhStep, eigthStep, ninethStep, tenthStep];
}

- (void)finishedAllSteps {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)canceled {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
