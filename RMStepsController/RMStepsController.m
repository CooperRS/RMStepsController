//
//  RMViewController.m
//  RMStepsController-Demo
//
//  Created by Roland Moers on 14.11.13.
//  Copyright (c) 2013 Roland Moers. All rights reserved.
//

#import "RMStepsController.h"

#import "UIViewController+RMStepsController.h"

@interface RMStepsController () <RMStepsBarDelegate, RMStepsBarDataSource>

@property (nonatomic, strong, readwrite) NSMutableDictionary *results;
@property (nonatomic, strong) UIViewController *currentStepViewController;

@property (nonatomic, strong, readwrite) RMStepsBar *stepsBar;
@property (nonatomic, strong) UIView *stepViewControllerContainer;

@end

@implementation RMStepsController

#pragma mark - Configuration
- (NSArray *)stepViewControllers {
    return @[];
}

#pragma mark - Init and Dealloc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadStepViewControllers];
    [self showStepViewController:[self.childViewControllers objectAtIndex:0] animated:NO];
    
    [self.view addSubview:self.stepViewControllerContainer];
    [self.view addSubview:self.stepsBar];
    
    id<UILayoutSupport> topGuide = self.topLayoutGuide;
    RMStepsBar *stepsBar = self.stepsBar;
    UIView *container = self.stepViewControllerContainer;
    
    NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(topGuide, stepsBar, container);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide]-(0)-[stepsBar(44)]" options:0 metrics:nil views:bindingsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide]-(0)-[container]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[stepsBar]-0-|" options:0 metrics:nil views:bindingsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[container]-0-|" options:0 metrics:nil views:bindingsDict]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.stepsBar reloadData];
}

#pragma mark - Properties
- (NSMutableDictionary *)results {
    if(!_results) {
        self.results = [@{} mutableCopy];
    }
    
    return _results;
}

- (RMStepsBar *)stepsBar {
    if(!_stepsBar) {
        self.stepsBar = [[RMStepsBar alloc] initWithFrame:CGRectZero];
        _stepsBar.delegate = self;
        _stepsBar.dataSource = self;
    }
    
    return _stepsBar;
}

- (UIView *)stepViewControllerContainer {
    if(!_stepViewControllerContainer) {
        self.stepViewControllerContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _stepViewControllerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _stepViewControllerContainer;
}

#pragma mark - Helper
- (void)loadStepViewControllers {
    NSArray *stepViewControllers = [self stepViewControllers];
    NSAssert([stepViewControllers count] > 0, @"Fatal: At least one step view controller must be returned by +[%@ stepViewControllers].", [self class]);
    
    for(UIViewController *aViewController in stepViewControllers) {
        NSAssert([aViewController isKindOfClass:[UIViewController class]], @"Fatal: %@ is not a subclass from UIViewController. Only UIViewControllers are supported by RMStepsController as steps.", [aViewController class]);
        
        aViewController.stepsController = self;
        
        [aViewController willMoveToParentViewController:self];
        [self addChildViewController:aViewController];
        [aViewController didMoveToParentViewController:self];
    }
}

- (void)showStepViewController:(UIViewController *)aViewController animated:(BOOL)animated {
    if(!animated) {
        [self showStepViewControllerWithoutAnimation:aViewController];
    } else {
        [self showStepViewControllerWithSlideInAnimation:aViewController];
    }
}

- (void)showStepViewControllerWithoutAnimation:(UIViewController *)aViewController {
    [self.currentStepViewController viewWillDisappear:NO];
    [self.currentStepViewController.view removeFromSuperview];
    [self.currentStepViewController viewDidDisappear:NO];
    
    aViewController.view.frame = CGRectMake(0, 0, self.stepViewControllerContainer.frame.size.width, self.stepViewControllerContainer.frame.size.height);
    aViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [aViewController viewWillAppear:NO];
    [self.stepViewControllerContainer addSubview:aViewController.view];
    [aViewController viewDidAppear:NO];
    
    self.currentStepViewController = aViewController;
    [self.stepsBar setIndexOfSelectedStep:[self.childViewControllers indexOfObject:aViewController] animated:NO];
}

- (void)showStepViewControllerWithSlideInAnimation:(UIViewController *)aViewController {
    NSInteger oldIndex = [self.childViewControllers indexOfObject:self.currentStepViewController];
    NSInteger newIndex = [self.childViewControllers indexOfObject:aViewController];
    
    BOOL fromLeft = NO;
    if(oldIndex < newIndex)
		fromLeft = NO;
    else
        fromLeft = YES;
    
    aViewController.view.frame = CGRectMake(fromLeft ? -self.stepViewControllerContainer.frame.size.width : self.stepViewControllerContainer.frame.size.width, 0, self.stepViewControllerContainer.frame.size.width, self.stepViewControllerContainer.frame.size.height);
    aViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.currentStepViewController viewWillDisappear:YES];
    [aViewController viewWillAppear:YES];
    [self.stepViewControllerContainer addSubview:aViewController.view];
    
    [self.stepsBar setIndexOfSelectedStep:[self.childViewControllers indexOfObject:aViewController] animated:YES];
    
    __weak RMStepsController *blockself = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        aViewController.view.frame = CGRectMake(0, 0, blockself.stepViewControllerContainer.frame.size.width, blockself.stepViewControllerContainer.frame.size.height);
        blockself.currentStepViewController.view.frame = CGRectMake(fromLeft ? blockself.stepViewControllerContainer.frame.size.width : -blockself.stepViewControllerContainer.frame.size.width, 0, blockself.stepViewControllerContainer.frame.size.width, blockself.stepViewControllerContainer.frame.size.height);
    } completion:^(BOOL finished) {
        [blockself.currentStepViewController.view removeFromSuperview];
        [blockself.currentStepViewController viewDidDisappear:YES];
        
        [aViewController viewDidAppear:YES];
        blockself.currentStepViewController = aViewController;
    }];
}

#pragma mark - Actions
- (void)showNextStep {
    NSInteger index = [self.childViewControllers indexOfObject:self.currentStepViewController];
    if(index < [self.childViewControllers count]-1) {
        UIViewController *nextStepViewController = [self.childViewControllers objectAtIndex:index+1];
        [self showStepViewController:nextStepViewController animated:YES];
    } else {
        [self finishedAllSteps];
    }
}

- (void)showPreviousStep {
    NSInteger index = [self.childViewControllers indexOfObject:self.currentStepViewController];
    if(index > 0) {
        UIViewController *nextStepViewController = [self.childViewControllers objectAtIndex:index-1];
        [self showStepViewController:nextStepViewController animated:YES];
    } else {
        [self canceled];
    }
}

- (void)finishedAllSteps {
    NSLog(@"Finished");
}

- (void)canceled {
    NSLog(@"Canceled");
}

#pragma mark - RMStepsBar Delegates
- (NSUInteger)numberOfStepsInStepsBar:(RMStepsBar *)bar {
    return [self.childViewControllers count];
}

- (RMStep *)stepsBar:(RMStepsBar *)bar stepAtIndex:(NSUInteger)index {
    return [(UIViewController *)[self.childViewControllers objectAtIndex:index] step];
}

- (void)stepsBarDidSelectCancelButton:(RMStepsBar *)bar {
    [self canceled];
}

- (void)stepsBar:(RMStepsBar *)bar shouldSelectStepAtIndex:(NSInteger)index {
    [self showStepViewController:[self.childViewControllers objectAtIndex:index] animated:YES];
}

@end
