<h3 align="center">
    <img src="http://onekilopars.ec/wp-content/uploads/2018/07/1kpcProComponents.001.png" width="100%" />
</h3>
<p align="center">
  <a href="https://github.com/onekiloparsec/KPCTabsControl">KPCTabsControl</a> &bull;
  <b>KPCJumpBarControl</b> &bull;
  <a href="https://github.com/onekiloparsec/KPCSplitPanes">KPCSplitPanes</a> &bull;
  <a href="https://github.com/onekiloparsec/KPCAppTermination">KPCAppTermination</a> &bull;
  <a href="https://github.com/onekiloparsec/KPCSearchableOutlineView">KPCSearchableOutlineView</a> &bull;
  <a href="https://github.com/onekiloparsec/KPCImportSheetController">KPCImportSheetController</a>
</p>

-------

KPCJumpBarControl
==============

![](https://img.shields.io/badge/Swift-3.0-blue.svg?style=flat)
[![Build Status](http://img.shields.io/travis/onekiloparsec/KPCJumpBarControl.svg?style=flat)](https://travis-ci.org/onekiloparsec/KPCJumpBarControl)
![Version](https://img.shields.io/cocoapods/v/KPCJumpBarControl.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/KPCJumpBarControl.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/KPCJumpBarControl.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A jump bar similar to Xcode's allowing to easily display and navigate across a tree of objects.

![Demo Jump Bar Screenshot](http://onekilopars.ec/wp-content/uploads/2018/11/KPCJumpBarControlScreenshot2.png)

![Demo JumpBar](http://onekilopars.ec/wp-content/uploads/2018/11/KPCJumpBarControlDemo.gif) 


Installation
------------

Using [Carthage](https://github.com/Carthage/Carthage): add `github "onekiloparsec/KPCJumpBarControl"` to your `Cartfile` and then run `carthage update`.

Using [CocoaPods](http://cocoapods.org/): `pod 'KPCJumpBarControl'`


Usage
-----

KPCJumpBarControl is designed for you to use only the `JumpBarControl` class, and fill it with a tree of object
conforming to `JumpBarItem`. A helper class `JumpBarSegment` is here for that, if you need one. 
Simply place a `NSView` in a storyboard or xib, where you need a jump bar, change its class to `JumpBarControl` and
that's it. To react when the jumbpar selection change, implement the `JumpBarControlDelegate` methods.

For instance:
```swift 
    let rootSegment = JumpBarItem(withTitle:"level 0", icon:NSImage(named:"Oval"))
    let segment1Item0 = JumpBarItem(withTitle:"level 1.0", icon:NSImage(named:"Polygon"))
    let segment1Item1 = JumpBarItem(withTitle:"level 1.1", icon:NSImage(named:"Rectangle"))
 
    rootSegment.children = [segment1Item0, segment1Item1]
  
    self.jumpBar?.useItemsTree([rootSegment])
    self.jumpBar?.delegate = self
```

Highlighting
------------

The jump bar control support the possibility to be highlighted. This is useful when you have multiple subviews, for instance using <a href="https://github.com/onekiloparsec/KPCSplitPanes">KPCSplitPanes</a>, each with jump bars, and you need to indicate to the user which subview is actually 'active'. 


Author
------

[Cédric Foellmi](https://github.com/onekiloparsec) ([@onekiloparsec](https://twitter.com/onekiloparsec))


LICENSE & NOTES
---------------

KPCJumpBarControl is licensed under the MIT license and hosted on GitHub at https://github.com/onekiloparsec/KPCJumpBarControl/
Fork the project and feel free to send pull requests with your changes!
