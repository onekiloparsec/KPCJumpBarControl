[![Build Status](http://img.shields.io/travis/onekiloparsec/KPCJumpBarControl.svg?style=flat)](https://travis-ci.org/onekiloparsec/KPCJumpBarControl)
![Version](https://img.shields.io/cocoapods/v/KPCJumpBarControl.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/KPCJumpBarControl.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/KPCJumpBarControl.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

 
KPCJumpBarControl
==============

 Borrowed initially from the excellent [LITabControl](https://github.com/monyschuk/LITabControl).



Installation
------------

Using [Carthage](https://github.com/Carthage/Carthage): add `github "onekiloparsec/KPCJumpBarControl"` to your `Cartfile` and then run `carthage update`.

Using [CocoaPods](http://cocoapods.org/): `pod 'KPCJumpBarControl'`
 

Usage
-----

KPCJumpBarControl is designed for you to use only the `KPCJumpBarControl` class, and its associated data source methods. 
Simply place a `NSView` in a xib, where you need a jump bar, change its class to `KPCJumpBarControl` and ...


Customization
-------------



Highlighting
------------

The tabs control support the possibility to be highlighted. This is useful when you have multiple subviews, each with 
jump bars, and you need to indicate to the user which subview is actually 'active'. (In the screenshot above, the upper 
bar has a darker background than the lower ones).


Author
------

[Cédric Foellmi](https://github.com/onekiloparsec) ([@onekiloparsec](https://twitter.com/onekiloparsec))


LICENSE & NOTES
---------------

KPCJumpBarControl is licensed under the MIT license and hosted on GitHub at https://github.com/onekiloparsec/KPCJumpBarControl/ 
Fork the project and feel free to send pull requests with your changes!


