[![Build Status](http://img.shields.io/travis/onekiloparsec/KPCJumpBarControl.svg?style=flat)](https://travis-ci.org/onekiloparsec/KPCJumpBarControl)
![Version](https://img.shields.io/cocoapods/v/KPCJumpBarControl.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/KPCJumpBarControl.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/KPCJumpBarControl.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


KPCJumpBarControl
==============

A jump bar similar to Xcode's allowing to easily display and navigate across a tree of objects.

![Demo JumpBar](http://www.onekilopars.ec/s/KPCJumpBarControlDemo.gif) 


Installation
------------

Using [Carthage](https://github.com/Carthage/Carthage): add `github "onekiloparsec/KPCJumpBarControl"` to your `Cartfile` and then run `carthage update`.

Using [CocoaPods](http://cocoapods.org/): `pod 'KPCJumpBarControl'`


Usage
-----

KPCJumpBarControl is designed for you to use only the `JumpBarControl` class, and fill it with a tree of object
conforming to `JumpBarItemProtocol`. A helper class `JumpBarItem` is here for that, if you need one. 
Simply place a `NSView` in a storyboard or xib, where you need a jump bar, change its class to `JumpBarControl` and
that's it. To react when the jumbpar selection change, implement the `JumpBarControlDelegate` methods.

For instance:
```swift 
    let rootSegment = JumpBarItem.item(withTitle:"level 0", icon:NSImage(named:"Oval"))
    let segment1Item0 = JumpBarItem.item(withTitle:"level 1.0", icon:NSImage(named:"Polygon"))
    let segment1Item1 = JumpBarItem.item(withTitle:"level 1.1", icon:NSImage(named:"Rectangle"))
 
    rootSegment.children = [segment1Item0, segment1Item1]
  
    self.jumpBar?.useItemsTree([rootSegment])
    self.jumpBar?.delegate = self
```

Highlighting
------------

The jump bar control support the possibility to be highlighted. This is useful when you have multiple subviews, each with
jump bars, and you need to indicate to the user which subview is actually 'active'. (In the screenshot above, the upper
bar has a darker background than the lower ones).


Author
------

[Cédric Foellmi](https://github.com/onekiloparsec) ([@onekiloparsec](https://twitter.com/onekiloparsec))


LICENSE & NOTES
---------------

KPCJumpBarControl is licensed under the MIT license and hosted on GitHub at https://github.com/onekiloparsec/KPCJumpBarControl/
Fork the project and feel free to send pull requests with your changes!
