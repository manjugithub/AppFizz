//
//  BUImagePreviewVC.m
//  TheBureau
//
//  Created by Manjunath on 01/04/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUImagePreviewVC.h"
#import "BUHomeImagePreviewCell.h"
#import "BUWebServicesManager.h"
#import "LQSViewController.h"
@interface BUImagePreviewVC ()

@property(nonatomic, strong) IBOutlet UIPageControl *pageControl;
-(IBAction)closePreview:(id)sender;
-(IBAction)removeImage:(id)sender;
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

-(IBAction)removeImage:(id)sender
{
    if(self.isHoroscope)
    {
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setValue:[BUWebServicesManager sharedManager].userID forKey:@"userid"];
        
        [self startActivityIndicator:YES];

        [[BUWebServicesManager sharedManager] queryServer:parameters
                                                  baseURL:@"http://dev.thebureauapp.com/admin/deleteHoroscope"
                                             successBlock:^(id response, NSError *error)
         {
             [self stopActivityIndicator];
             
             
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[response valueForKey:@"response"]];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];
             
             [alertController addAction:({
                 UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     NSLog(@"OK");
                     
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"kupdateProfile" object:nil];
                     [self dismissViewControllerAnimated:NO completion:nil];
                 }];
                 
                 action;
             })];
             
             [self presentViewController:alertController  animated:YES completion:nil];
             
         }
                                             failureBlock:^(id response, NSError *error)
         {
             [self stopActivityIndicator];
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
             [self presentViewController:alertController animated:YES completion:nil];
         }];
    }
    else
    {
        [self.chatVC deletePhotoAtIndex:self.currentIndex];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

@end
