//
//  BUHomeCollectionVC.m
//  TheBureau
//
//  Created by Manjunath on 09/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUHomeCollectionVC.h"
#import "BUHomeImagePreviewCell.h"
@interface BUHomeCollectionVC ()
@property(nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property(nonatomic, strong) NSDictionary *datasourceDict;
@end

@implementation BUHomeCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.collectionView.frame.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.pageControl.numberOfPages = 10;
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUHomeImagePreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BUHomeImagePreviewCell"
                                                                             forIndexPath:indexPath];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.pageControl.currentPage = indexPath.row;
    NSLog(@"collectionView willDisplayCell: %ld",indexPath.row);
}
@end
