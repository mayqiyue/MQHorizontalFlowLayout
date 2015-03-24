//
//  MQHorizontalFlowLayout.h
//  mSounds
//
//  Created by Mayqiyue on 12/11/14.
//  Copyright (c) 2014 Mayqiyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MQHorizontalFlowLayout : UICollectionViewFlowLayout

//default is 3
@property (assign, nonatomic) NSInteger rowCount;
//default is 3
@property (assign, nonatomic) NSInteger columnCount;

@end
