#UIViewController-Modal ![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

Determine whether UIViewController is presented as modal.

[![Build Status](https://api.travis-ci.org/NZN/UIViewController-Modal.png)](https://api.travis-ci.org/NZN/UIViewController-Modal.png)
[![Cocoapods](https://cocoapod-badges.herokuapp.com/v/UIViewController-Modal/badge.png)](http://beta.cocoapods.org/?q=name%3Auiviewcontroller%20name%3Amodal%2A)
[![Cocoapods](https://cocoapod-badges.herokuapp.com/p/UIViewController-Modal/badge.png)](http://beta.cocoapods.org/?q=name%3Auiviewcontroller%20name%3Amodal%2A)

## Requirements

UIViewController-Modal works on iOS 6.0+ version and is compatible with ARC projects. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* Foundation.framework
* UIKit.framework

You will need LLVM 3.0 or later in order to build UIViewController-Modal.

## Adding UIViewController-Modal to your project

### Cocoapods

[CocoaPods](http://cocoapods.org) is the recommended way to add UIViewController-Modal to your project.

* Add a pod entry for UIViewController-Modal to your Podfile `pod 'UIViewController-Modal'`
* Install the pod(s) by running `pod install`.

### Source files

Alternatively you can directly add source files to your project.

1. Download the [latest code version](https://github.com/NZN/UIViewController-Modal/archive/master.zip) or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop all files at `UIViewController-Modal` folder onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.

## Usage

* Import `UIViewController+Modal.h` or add this to your project prefix header `*-Prefix.pch`.

```objective-c
#import "UIViewController+Modal.h"
...
@implementation UIViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self isModal]) {
        // modal
    } else {
        // not modal
    }
}

@end
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each UIViewController-Modal release can be found on the [wiki](https://github.com/NZN/UIViewController-Modal/wiki/Change-log).
