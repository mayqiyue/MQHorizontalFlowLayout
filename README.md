##Purpose
MQHorizontalFlowLayout inherites from UICollectionViewFlowLayout!    
Based on the WWDC 2012 videos on UICollectionView, it appears that if you use Flow Layout with vertical scrolling, your layout lines are horizontal, and if you scroll horizontally, your layout lines are vertical. If you want **horizontal layout lines** in a **horizontally-scrolling** collection view. ***OK, that's the MQHorizontalFlowLayout!***

##Supported OS & SDK Versions

* Supported build target - iOS 7.0    

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this OS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.

##Installation

To use the MQHorizontalFlowLayout class in an app, just drag the MQHorizontalFlowLayout class files into your project.

##Property
###The MQHorizontalFlowLayout only has the following two properties:
 
    @property (assign, nonatomic) NSInteger rowCount;
 This property defines the number of rows per page! And default is 3!

    @property (assign, nonatomic) NSInteger columnCount;
 This property defines the number of column per page! And default is 3!


##Contact

If you have any problem, just contact with me: xu20121013@gmail.com! I would pleasure for that!     
And here is one of my app used MQHorizontalFlowLayout: [SweetSounds](https://itunes.apple.com/app/id952649748)
