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
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getGoldDetails];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tapToContinueBtn.hidden = YES;

    [self getMatchPoolFortheDay];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)showProfileDetails:(id)sender
{
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    BUPoolProfileDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUPoolProfileDetailsVC"];
    vc.datasourceList = [[NSMutableDictionary alloc] initWithDictionary:[self.datasourceList objectAtIndex:self.pageControl.currentPage]];
    [vc cookupDataSource];
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



-(void)getMatchPoolFortheDay
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID
                   };

//    parameters = @{@"userid": @"327"};

    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] matchPoolForTheDaywithParameters:parameters
                                                              successBlock:^(id inResult, NSError *error)
    {
        [self stopActivityIndicator];
        
        self.datasourceList = [[NSMutableArray alloc] init];
        self.imagesList = [[NSMutableArray alloc] init];

        if([inResult valueForKey:@"msg"] != nil && [[inResult valueForKey:@"msg"] isEqualToString:@"Error"])
        {
            [self stopActivityIndicator];
            NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[inResult valueForKey:@"response"]];
            [message addAttribute:NSFontAttributeName
                            value:[UIFont fontWithName:@"comfortaa" size:15]
                            range:NSMakeRange(0, message.length)];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController setValue:message forKey:@"attributedTitle"];            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            [self.collectionView reloadData];
            return;
        }
        else
        {
            self.tapToContinueBtn.hidden = NO;
            
            for (NSString *key in [inResult allKeys])
            {
                if((NO == [[inResult valueForKey:key] isKindOfClass:[NSNull class]]) && (NO == [[inResult valueForKey:key] isKindOfClass:[NSString class]]))
                {
                    [self.datasourceList addObject:[inResult valueForKey:key]];
                    if([[[self.datasourceList lastObject] valueForKey:@"img_url"] count] > 0)
                    {
                        [self.imagesList addObject:[[[self.datasourceList lastObject] valueForKey:@"img_url"] firstObject]];
                    }
                    else
                    {
                        [self.imagesList addObject:@"https://camo.githubusercontent.com/9ba96d7bcaa2481caa19be858a58f180ef236c7b/687474703a2f2f692e696d6775722e636f6d2f7171584a3246442e6a7067"];

                    }
                }
            }
            
            [self.collectionView reloadData];
        }
    }
                                                              failureBlock:^(id response, NSError *error)
    {
        [self stopActivityIndicator];
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

-(void)getGoldDetails
{
    
    //    [self startActivityIndicator:YES];
    
    
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID
                   };
    
    
    NSString *baseURl = @"http://dev.thebureauapp.com/admin/getGoldAvailable";
    
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:baseURl
                                         successBlock:^(id response, NSError *error) {
                                             
                                             [[NSUserDefaults standardUserDefaults] setInteger:[[response valueForKey:@"available_gold"] intValue] forKey:@"purchasedGold"];
                                             [[NSUserDefaults standardUserDefaults] synchronize];
                                             
                                             
                                             [(BUHomeTabbarController *)[self tabBarController] updateGoldValue:[[response valueForKey:@"available_gold"] integerValue]];
                                         }
                                         failureBlock:^(id response, NSError *error) {
                                             
                                         }];
    
}

@end
