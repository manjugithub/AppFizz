//
//  BUProfileRematchVC.m
//  TheBureau
//
//  Created by Accion Labs on 16/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileRematchVC.h"
#import "BURematchCollectionViewCell.h"

@interface BUProfileRematchVC ()

@property(nonatomic) NSArray * imageArray;

@end

@implementation BUProfileRematchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray = [[NSArray alloc]initWithObjects:@"img_photo1",@"img_photo1",@"img_photo1",@"img_photo1", @"img_photo2",@"img_photo2",@"img_photo2",@"img_photo2",nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [_imageArray count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   BURematchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BURematchCollectionViewCell" forIndexPath:indexPath];
    cell.userImageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.item]];
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    [self performSegueWithIdentifier:@"details" sender:self];
}
#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat picDimension = self.view.frame.size.width/2;
    if (self.view.frame.size.width == 375) {
        return CGSizeMake(110, 110);
   
    }
    if (self.view.frame.size.width == 320) {
        return CGSizeMake(90, 90);
        
    }
    return CGSizeMake(110, 110);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    //CGFloat leftRightInset = self.view.frame.size.width / 14.0f;
    return UIEdgeInsetsMake(0, 10, 0, 10);
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
