//
//  MQHorizontalFlowLayout.m
//  mSounds
//
//  Created by Mayqiyue on 12/11/14.
//  Copyright (c) 2014 Mayqiyue. All rights reserved.
//

#import "MQHorizontalFlowLayout.h"

/**
 * CollectionViewLayout for an horizontal flow type:
 *
 *  |--marginx--  0  1  2  ---marginx--|
 *
 */
#define kPageMarginXForPad   160.0f
#define kPageMarginXForPhone ((35.0f/320.0f)*[UIScreen mainScreen].bounds.size.width)

#define isIPhone4s ([UIScreen mainScreen].bounds.size.height < 500.0f)
#define isIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@interface MQHorizontalFlowLayout()
{
    CGFloat _pageMarginX;
}
@property (nonatomic, assign) NSUInteger cellCount;
@property (nonatomic, strong) NSArray *layoutInfo;

@end

@implementation MQHorizontalFlowLayout

#pragma mark - private methods

- (void)setRowCount:(NSInteger)rowCount
{
    _rowCount = rowCount ? rowCount : 3;
}

- (void)setColumnCount:(NSInteger)columnCount
{
    _columnCount = columnCount ? columnCount : 3;
}

- (void)setup
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGSize size = CGSizeZero;
    if (isIPad)
    {
        _pageMarginX = kPageMarginXForPad;
        self.minimumInteritemSpacing = 50.0f;
        self.minimumLineSpacing = 80.0f;
    }
    else
    {
        _pageMarginX = kPageMarginXForPhone;
        self.minimumInteritemSpacing = 25.0f;
        if (isIPhone4s)
        {
            self.minimumInteritemSpacing = 5.0f;
        }
        self.minimumLineSpacing = 20.0f;
    }
    size.width  = (self.collectionView.frame.size.width - 2*_pageMarginX - (_columnCount > 1 ? (_columnCount - 1)*self.minimumLineSpacing : 0))/_columnCount;
    size.height  = (self.collectionView.frame.size.height - (_rowCount > 1 ? (_rowCount - 1)*self.minimumInteritemSpacing : 0))/_rowCount;
    
//    NSLog(@"the size of item is %@",NSStringFromCGSize(size));
    self.itemSize = size;
    
    return ;
}

- (CGRect)_frameForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize canvasSize = self.collectionView.frame.size;
    
    CGFloat pageMarginX = _pageMarginX;
    CGFloat pageMarginY = (canvasSize.height - _rowCount * self.itemSize.height - (_rowCount > 1 ? (_rowCount - 1) * self.minimumInteritemSpacing : 0)) / 2.0f;
    
    //get the item's location {page,row,column}
    NSUInteger page = indexPath.row / (_rowCount * _columnCount);
    NSUInteger remainder = indexPath.row - page * (_rowCount * _columnCount);
    NSUInteger row = remainder / _columnCount;
    NSUInteger column = remainder - row * _columnCount;
//    NSLog(@"the item:%ld 's location {page,row,column} ={%ld,%ld,%ld}",indexPath.row,page,row,column);
    
    CGRect cellFrame = CGRectZero;
    cellFrame.origin.x = pageMarginX + column * (self.itemSize.width + self.minimumLineSpacing);
    cellFrame.origin.y = pageMarginY + row * (self.itemSize.height + self.minimumInteritemSpacing);
    cellFrame.size.width = self.itemSize.width;
    cellFrame.size.height = self.itemSize.height;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal)
    {
        cellFrame.origin.x += page * canvasSize.width;
    }
    
    return cellFrame;
}

#pragma mark - Layout

- (void)prepareLayout
{
    [self setup];
    _cellCount = [self.collectionView.dataSource collectionView:self.collectionView
                                               numberOfItemsInSection:0];
    
    NSMutableArray *cellLayoutInfo = [NSMutableArray new];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    for (NSUInteger item = 0; item < _cellCount; item++)
    {
        indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        itemAttributes.frame = [self _frameForItemAtIndexPath:indexPath];
        [cellLayoutInfo addObject:itemAttributes];
    }
    self.layoutInfo = cellLayoutInfo;
}

- (CGSize)collectionViewContentSize
{
    // Only support single section for now;Only support Horizontal scroll
    CGSize canvasSize = self.collectionView.frame.size;
    CGSize contentSize = canvasSize;
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal)
    {
        NSUInteger page = ceil((CGFloat)_cellCount / (_rowCount * _columnCount));
        contentSize.width = page * canvasSize.width;
    }
    
    return contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.layoutInfo objectAtIndex:indexPath.row];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attrs = [NSMutableArray array];
    
    [self.layoutInfo enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attr, NSUInteger idx, BOOL *stop) {
        if (CGRectIntersectsRect(attr.frame, rect))
        {
            [attrs addObject:attr];
        }
    }];
   
    return attrs;
}

@end
