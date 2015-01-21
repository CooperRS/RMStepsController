RMStepsController
=============================

This is an iOS control for guiding users through a process step-by-step

## Screenshots
### Portrait
![Portrait](http://cooperrs.github.io/RMStepsController/Images/Screen1.png)

### Landscape
![Landscape](http://cooperrs.github.io/RMStepsController/Images/Screen2.png)

### Navigation Controller
![Navigation Controller](http://cooperrs.github.io/RMStepsController/Images/Screen3.png)

[Animated version](http://cooperrs.github.io/RMStepsController/Images/Screen3-animated.gif)

##Installation
###Manual
1. Check out the project
2. Add all files in `RMStepsController` folder to Xcode

###CocoaPods
```ruby
platform :ios, '7.0'
pod "RMStepsController", "~> 1.0.2"
```

##Usage
###Basic
1. Create a subclass of `RMStepsController` in your project.
	
	```objc
	#import "RMStepsController.h"
	
	@interface YourStepsController : RMStepsController
	@end
	```
	
	```objc
	#import "YourStepsController.h"
	
	@implementation YourStepsController
	@end
	```
	
2. Implement `-(NSArray *)stepViewControllers` and return the view controllers of your steps.
	
	```objc
	- (NSArray *)stepViewControllers {
   		UIViewController *firstStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep"];
	    firstStep.step.title = @"First";
 		
    	UIViewController *secondStep = [self.storyboard instantiateViewControllerWithIdentifier:@"SomeStep2"];
    	secondStep.step.title = @"Second";
    	
    	return @[firstStep, secondStep];
	}
	```
	
3. Implement `-(void)finishedAllSteps` and `-(void)canceled`
	
	```objc
	- (void)finishedAllSteps {
    	[self dismissViewControllerAnimated:YES completion:nil];
	}

	- (void)canceled {
    	[self dismissViewControllerAnimated:YES completion:nil];
	}
	```
	
4. Open `YourStepsController` by presenting it modally or pushing it in a navigation controller.

## Documentation
There is an additional documentation available provided by the CocoaPods team. Take a look at [cocoadocs.org](http://cocoadocs.org/docsets/RMStepsController/).

## Requirements
Works with:

* Xcode 5
* iOS 7 SDK
* ARC (You can turn it on and off on a per file basis)

May also work with previous Xcode and iOS SDK versions. But it will at least need a system capable of Autolayout (and I think it will look awful on iOS 6 ;)...)

## Apps using this control
Using this control in your app or know anyone who does?

Feel free to add the app to this list: [Apps using RMStepsController](https://github.com/CooperRS/RMStepsController/wiki/Apps-using-RMStepsController)

## Credits
Code:
* Evgeniy Shestakov (Bugfixing)
* Tilo Westermann (Action sheet for unlimited number of steps)
* Maciej Cupial (Convenience method for going back and property for hiding number label)
* Cihat Gündüz (Bugfixing)

Resources:
* Joshua Gourneau (GIF of the control in action)

I want to thank everyone who has contributed code and/or time to this project!

## License (MIT License)
Copyright (c) 2013 Roland Moers

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
