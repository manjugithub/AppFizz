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

//    self.collectionView.layer.borderColor = [[UIColor redColor] CGColor];
//    self.collectionView.layer.borderWidth = 1.0;
//    self.collectionView.layer.cornerRadius = 5.0;
    
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
    
//    NSLog(@"colection size ==> %@",NSStringFromCGSize(self.collectionView.frame.size));
    return self.collectionView.frame.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    self.pageControl.numberOfPages = self.imagesList.count;
    
    (self.pageControl.numberOfPages < 2) ? (self.pageControl.hidden = YES) : (self.pageControl.hidden = NO);
    return self.imagesList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUHomeImagePreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BUHomeImagePreviewCell"
                                                                             forIndexPath:indexPath];
    
    [cell setFrameRect:self.collectionView.frame];
    [cell setImageURL:[self.imagesList objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.pageControl.currentPage = indexPath.row;
    NSLog(@"collectionView willDisplayCell: %ld",(long)indexPath.row);
}
@end
