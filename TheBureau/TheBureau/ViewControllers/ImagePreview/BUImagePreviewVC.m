//
//  BUImagePreviewVC.m
//  TheBureau
//
//  Created by Manjunath on 01/04/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUImagePreviewVC.h"
#import "BUHomeImagePreviewCell.h"

@interface BUImagePreviewVC ()

@property(nonatomic, strong) IBOutlet UIPageControl *pageControl;
-(IBAction)closePreview:(id)sender;
@end

@implementation BUImagePreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
    [self performSelector:@selector(moveToCurrentPage) withObject:nil afterDelay:0.2];
}

-(void)moveToCurrentPage
{
    [self.collectionView scrollToItemAtIndexPath:self.indexPathToScroll atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
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
    self.pageControl.numberOfPages = self.imagesList.count;
    return self.imagesList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUHomeImagePreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BUHomeImagePreviewCell"
                                                                             forIndexPath:indexPath];
    
    [cell setFrameRect:self.collectionView.frame];

    if([[self.imagesList objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])
    {
        [cell setImageURL:[self.imagesList objectAtIndex:indexPath.row]];
    }
    else
    {
        [cell.profileImgView setImage:[self.imagesList objectAtIndex:indexPath.row]];
        cell.activityIndicatorView.hidden = YES;
    }

    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.pageControl.currentPage = indexPath.row;
    NSLog(@"collectionView willDisplayCell: %ld",(long)indexPath.row);
}

-(IBAction)closePreview:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
