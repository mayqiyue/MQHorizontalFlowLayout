//
//  ViewController.m
//  MQHorizontalFlowLayoutDemo
//
//  Created by Mayqiyue on 3/20/15.
//  Copyright (c) 2015 mayqiyue. All rights reserved.
//

#import "ViewController.h"
#import "MQHorizontalFlowLayout.h"
#import "CollectionViewCell.h"


static NSString *CellId = @"CollectionViewCell";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MQHorizontalFlowLayout *flowLayout = [[MQHorizontalFlowLayout alloc] init];
    flowLayout.rowCount = 3;
    flowLayout.columnCount = 3;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView.showsHorizontalScrollIndicator = YES;
    _collectionView.showsVerticalScrollIndicator = YES;
    _collectionView.pagingEnabled = YES;
    _collectionView.decelerationRate = 0.0f;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    cell.label.backgroundColor = [UIColor blueColor];
    return cell;
}

@end
