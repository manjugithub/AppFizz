//
//  BUMatchPoolViewController.m
//  TheBureau
//
//  Created by Manjunath on 22/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUMatchPoolViewController.h"
#import "BUHomeImagePreviewCell.h"
#import "BUPoolProfileDetailsVC.h"

@interface BUMatchPoolViewController ()
@property(nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property(nonatomic, strong) NSMutableArray *datasourceList;
@property(nonatomic, strong) NSMutableArray *imagesList;

@end

@implementation BUMatchPoolViewController
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMatchPoolFortheDay];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)showProfileDetails:(id)sender
{
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    BUPoolProfileDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUPoolProfileDetailsVC"];
    vc.datasourceList = [self.datasourceList objectAtIndex:self.pageControl.currentPage];
    [self.tabBarController.navigationController pushViewController:vc animated:NO];
    
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
    [cell setImageURL:[self.imagesList objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.pageControl.currentPage = indexPath.row;
    NSLog(@"collectionView willDisplayCell: %ld",(long)indexPath.row);
}



-(void)getMatchPoolFortheDay
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid": @"8"
                   };
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] matchPoolForTheDaywithParameters:parameters
                                                              successBlock:^(id inResult, NSError *error)
    {
        [self stopActivityIndicator];
        if(nil != inResult && 0 < [inResult count])
        {
            self.datasourceList = inResult;
            
            self.imagesList = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in inResult)
            {
                [self.imagesList addObject:[[dict valueForKey:@"img_url"] firstObject]];
            }
            
            [self.collectionView reloadData];
        }
        else
        {
            NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
            [message addAttribute:NSFontAttributeName
                            value:[UIFont fontWithName:@"comfortaa" size:15]
                            range:NSMakeRange(0, message.length)];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController setValue:message forKey:@"attributedTitle"];            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
                                                              failureBlock:^(id response, NSError *error)
    {
        [self startActivityIndicator:YES];
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
        [message addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"comfortaa" size:15]
                        range:NSMakeRange(0, message.length)];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:message forKey:@"attributedTitle"];        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}



-(void)didSuccess:(id)inResult;
{
    [self stopActivityIndicator];
    if(nil != inResult && 0 < [inResult count])
    {
        self.datasourceList = inResult;
        
        self.imagesList = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in inResult)
        {
            [self.imagesList addObject:[[dict valueForKey:@"img_url"] firstObject]];
        }
        
        [self.collectionView reloadData];
    }
    else
    {
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
        [message addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"comfortaa" size:15]
                        range:NSMakeRange(0, message.length)];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:message forKey:@"attributedTitle"];        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)didFail:(id)inResult;
{
    [self startActivityIndicator:YES];
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
