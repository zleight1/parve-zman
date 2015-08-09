# UIColor-Hex-Swift

[![CI Status](http://img.shields.io/travis/Frederik Jacques/UIColor-Hex-Swift.svg?style=flat)](https://travis-ci.org/Frederik Jacques/UIColor-Hex-Swift)
[![Version](https://img.shields.io/cocoapods/v/UIColor-Hex-Swift.svg?style=flat)](http://cocoapods.org/pods/UIColor-Hex-Swift)
[![License](https://img.shields.io/cocoapods/l/UIColor-Hex-Swift.svg?style=flat)](http://cocoapods.org/pods/UIColor-Hex-Swift)
[![Platform](https://img.shields.io/cocoapods/p/UIColor-Hex-Swift.svg?style=flat)](http://cocoapods.org/pods/UIColor-Hex-Swift)

## What?
This Swift extension on UIColor is a port of the [Objective-C category](https://github.com/Inferis/UIColor-Hex) made by [Tom Adriaenssen](https://github.com/Inferis). I ported it because I had issues implementing the Objective-C version with a bridging header in a Swift project.

## Usage
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Methods
These methods will be added to the UIColor class.

* colorWithCSS( css:String )

* colorWithHex( hex:UInt )

## Requirements
Import the module in the file where you want to use the extension.

    import UIColor_Hex_Swift

## Installation

UIColor-Hex-Swift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UIColor-Hex-Swift"
```

## Author

Frederik Jacques, frederik@the-nerd.be

* [Twitter](http://www.twitter.com/thenerd_be)
* [Blog](http://www.the-nerd.be/blog)

## License

UIColor-Hex-Swift is available under the MIT license. See the LICENSE file for more info.
