Navigation Drawer - Swift 
===================
An easy to use android like navigation drawer library for iOS written in Swift. 

Installation
-------------
Just add NavigationDrawer.swift and NavigationDrawerOptions.swift file to your project. Both files are present inside NavigationDrawer-Swift directory.

##Screenshot##
![Screenshot-navigation-drawer](/Screenshots/Screenshot-1.png?raw=true)


## How to use
1. Customize your navigation drawer with the help of NavigationDrawerOptions class
2. Pass that options to NavigationDrawer instance and set the controller for navigation drawer.
3. That's it

1.
During its initialization, default options are set for navigation drawer. So just this single line is enough if you want to use default configuration.

```
let options = NavigationDrawerOptions()
```
You can also further customize it such as, 
```
//If I want my drawer to show from left side of the screen
options.navigationDrawerType = .LeftDrawer

//If i want my drawer to show, when swiped in only from the left edge of the screen
options.navigationDrawerOpenDirection = .LeftEdge

//and many more
```
2. 
```
/*
Setting up Navigation Drawer. NOTE: This step is required only once. You can perform it in your first view controller. Instead of creating the new instance you use the shared instance of Navigation Drawer
*/
let navigationDrawer = NavigationDrawer.sharedInstance

//setting up this drawer with our options.
navigationDrawer.setup(withOptions: options)

//Providing the view controller for navigation drawer
navigationDrawer.setNavigationDrawerController(vc)


```
```
/*
After setting up navigation drawer, You can use it directly anytime from any view controller. Just override viewWillAppear method and use initialize method on NavigationDrawer Instance.
*/ 

override func viewWillAppear(animated:Bool)
{
	super.viewWillAppear(animated)
	NavigationDrawer.sharedInstance.initialize(forViewController:self)
}

//To show/hide drawer
NavigationDrawer.sharedInstance.toggleNavigationDrawer(completionHandler:nil)

```
That's it.  You can also conform to **NavigationDrawerDelegate** to get additional feedbacks.

```
navigationDrawer.delegate = self
```
Called when navigation drawer is shown completely
```
optional func navigationDrawerDidShow(didShow:Bool)
```
Called when navigation drawer is hidden completely
```
optional func navigationDrawerDidHide(didHide:Bool)
```
##Customization##

Width of the Navigation Drawer. Default is the (width - 100) of the View Controller to which the navigation drawer is attached to.
``` 
navigationDrawerWidth:CGFloat
``` 
Height of the Navigation Drawer. Default is the height of the view controller to which the navigation drawer is attached to.
```
navigationDrawerHeight:CGFloat
```

X position of Navigation Drawer inside view controller frame. Default is 0
```
navigationDrawerXPosition:CGFloat
```
Y position of Navigation Drawer inside view controller frame. Default is 0.  If this causes the Drawer to get hidden inside Navigation Bar, you can set it the height of Navigation Bar.

```
navigationDrawerYPosition:CGFloat
```
Background color of navigation drawer. Default is White
```
navigationDrawerBackgroundColor: UIColor
```
Type of the Navigation Drawer.  Default type is LeftDrawer which causes Navigation Drawer to appear on the Left side of screen.
```
navigationDrawerType:NavigationDrawerType
```
How do you want to open Navigation Drawer. Swiping from LeftEdge or RightEdge or AnyWhere in the screen.
```
navigationDrawerOpenDirection:NavigationDrawerOpenDirection
```
Distance to be swiped while opening drawer from edges of the screen. Default is 20
```
navigationDrawerEdgeSwipeDistance:CGFloat
```

##License##
The MIT License (MIT)

Copyright (c) 2016 nrlnishan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.