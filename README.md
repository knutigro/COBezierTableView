# COBezierTableView [![codebeat badge](https://codebeat.co/badges/c92594f9-6b0f-4f40-b62b-04bf2cd04fe4)](https://codebeat.co/projects/github-com-knutigro-cobeziertableview)

[![Build Status](https://travis-ci.org/knutigro/COBezierTableView.svg?branch=master)](https://travis-ci.org/knutigro/COBezierTableView)
[![Version](https://img.shields.io/cocoapods/v/COBezierTableView.svg?style=flat)](http://cocoadocs.org/docsets/COBezierTableView)
[![License](https://img.shields.io/cocoapods/l/COBezierTableView.svg?style=flat)](http://cocoadocs.org/docsets/COBezierTableView)
[![Platform](https://img.shields.io/cocoapods/p/COBezierTableView.svg?style=flat)](http://cocoadocs.org/docsets/COBezierTableView)

UITableView modification written in Swift where cells are scrolling in an arc defined by a BezierPath. 

Project even include classes for editing BezierPaths. When you are happy with your path, insert the static points to the `BezierPoints` struct in `UView+Bezier.swift`.

![Output sample](https://raw.githubusercontent.com/knutigro/COBezierTableView/master/Media/COBezier.gif)

## Usage

COBezierTableView can be imported into both Swift and Objective-C projects.

Objective-C: 

```Objective-C
#import "COBezierTableView/COBezierTableView-Swift.h"
```

## Installation

COBezierTableView is available through [CocoaPod](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate COBezierTableView into your Xcode project using CocoaPods, specify it in your Podfile:

```
pod 'COBezierTableView', '~> 0.1'
```

Then, run the following command:

```
$ pod install
```

## Author

Knut Inge Grosland, ”hei@knutinge.com”

## License

COBezierTableView is available under the MIT license. See the LICENSE file for more info.

