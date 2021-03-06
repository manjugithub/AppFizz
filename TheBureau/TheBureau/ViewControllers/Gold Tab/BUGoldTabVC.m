//
//  BUGoldTabVC.m
//  TheBureau
//
//  Created by Manjunath on 07/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUGoldTabVC.h"
#import "BUGoldTabCell.h"
#import "PWInAppHelper.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "InstagramMedia.h"
#import "InstagramKit.h"
#import "IKLoginViewController.h"

@interface BUGoldTabVC ()<FBSDKAppInviteDialogDelegate>

@property(nonatomic, weak) IBOutlet UICollectionView *goldCollectionView;
@property(nonatomic, weak) IBOutlet UILabel *totalGoldLabel;
@property(nonatomic, strong) NSArray *products;
@property(nonatomic, weak) IBOutlet UIButton *inviteFriendButton,*followFriendButton;
@property(nonatomic, weak) IBOutlet FBSDKLikeButton *likeUsOnFBButton;

@property (nonatomic, strong)   InstagramPaginationInfo *currentPaginationInfo;
@property (nonatomic, weak)     InstagramEngine *instagramEngine;

-(IBAction)inviteFriend:(id)sender;
-(IBAction)likeUsOnFB:(id)sender;
-(IBAction)followUsInInstagram:(id)sender;
@end

@implementation BUGoldTabVC


//https://www.instagram.com/itsthebureau/



-(void)resetGoldTable
{
    
//    NSString *titleStr = @"";
//    UIImage *statusImg = [UIImage imageNamed:@""];
//    titleStr = [NSString stringWithFormat:@"     Invite a Friend"];
//    NSMutableAttributedString *statusString = [[NSMutableAttributedString alloc] init];
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:titleStr];
//    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//    textAttachment.image = statusImg;
//    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
//    
//    [statusString appendAttributedString:attrStringWithImage];
//    [statusString appendAttributedString:attributedString];

//    [followFriendButton setAttributedTitle:<#(nullable NSAttributedString *)#> forState:<#(UIControlState)#>]
    
    [self.goldCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft
                                            animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.likeUsOnFBButton.objectID = @"https://www.facebook.com/thebureauapp/";
    
    self.likeUsOnFBButton.backgroundColor = [UIColor clearColor];

    

    
    
    [self.goldCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft
                                            animated:YES];

    [self performSelector:@selector(resetGoldTable) withObject:nil afterDelay:0.6];
    
    

    
    [self getGoldDetails];
    
    
}

- (void)reload {
    _products = nil;

    [PWInAppHelper sharedInstance].parentCtrllr = self;
    [[PWInAppHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
        }
        [self stopActivityIndicator];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FBSDKLikeControl *likeButton = [[FBSDKLikeControl alloc]initWithFrame:CGRectMake(20, 294, 560, 40)];
    likeButton.objectID = @"https://www.facebook.com/thebureauapp/";
    
    [self.view addSubview:likeButton];

    likeButton.hidden = YES;
    self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];

    
    self.inviteFriendButton.layer.cornerRadius = 5.0;
    self.inviteFriendButton.layer.borderWidth = 1.0;
    self.inviteFriendButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.inviteFriendButton.layer.shadowOffset = CGSizeMake(2, 2);
    self.inviteFriendButton.layer.shadowColor = [[UIColor darkGrayColor]CGColor];

    
    self.followFriendButton.layer.cornerRadius = 5.0;
    self.followFriendButton.layer.borderWidth = 1.0;
    self.followFriendButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.followFriendButton.layer.shadowOffset = CGSizeMake(2, 2);
    self.followFriendButton.layer.shadowColor = [[UIColor darkGrayColor]CGColor];

    
//    self.likeUsOnFBButton.layer.cornerRadius = 5.0;
//    self.likeUsOnFBButton.layer.borderWidth = 1.0;
//    self.likeUsOnFBButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
//    self.likeUsOnFBButton.layer.shadowOffset = CGSizeMake(2, 2);
//    self.likeUsOnFBButton.layer.shadowColor = [[UIColor darkGrayColor]CGColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

static NSString * const reuseIdentifier = @"Cell";
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100, 80);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUGoldTabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BUGoldTabCell"
                                                                             forIndexPath:indexPath];
    
    switch (indexPath.row)
    {
        case 0:
            cell.goldLabel.text = @"1000";
            cell.priceLabel.text = @"$ 9.99";
            break;
        case 1:
            cell.goldLabel.text = @"100";
            cell.priceLabel.text = @"$ 1.99";
            break;
        case 2:
            cell.goldLabel.text = @"250";
            cell.priceLabel.text = @"$ 2.99";
            break;
        case 3:
            cell.goldLabel.text = @"300";
            cell.priceLabel.text = @"$ 3.99";
            break;
        case 4:
            cell.goldLabel.text = @"500";
            cell.priceLabel.text = @"$ 4.99";
            break;
        case 5:
            cell.goldLabel.text = @"750";
            cell.priceLabel.text = @"$ 6.99";
            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"collectionView willDisplayCell: %ld",(long)indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.selectedIndexPath = indexPath;
    NSInteger purchasedGold = 0;

    switch (indexPath.row)
    {
        case 0:
            purchasedGold = 1000;
            break;
        case 1:
            purchasedGold = 100;
            break;
        case 2:
            purchasedGold = 250;
            break;
        case 3:
            purchasedGold = 300;
            break;
        case 4:
            purchasedGold = 500;
            break;
        case 5:
            purchasedGold = 750;
            break;
            
        default:
            break;
    }
    
    
    
    [[PWInAppHelper sharedInstance] buyProduct:[self.products objectAtIndex:indexPath.row]];
    
    return;
    
    
    
    
}

-(IBAction)followUsInInstagram:(id)sender
{
    if (![self.instagramEngine isSessionValid])
    {
        IKLoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNavigationViewController"];
        loginViewController.parentController = self;
        UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        
        [self presentViewController:navCtr animated:YES completion:nil];
    }
    else
    {
        [self.instagramEngine logout];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"InstagramKit" message:@"You are now logged out." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }

}

-(IBAction)inviteFriend:(id)sender
{
        FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
        content.appLinkURL = [NSURL URLWithString:@"https://app.cancerlife.com/fb.html"];
        [FBSDKAppInviteDialog showFromViewController:self withContent:content delegate:self];
}

/*!
 @abstract Sent to the delegate when the app invite completes without error.
 @param appInviteDialog The FBSDKAppInviteDialog that completed.
 @param results The results from the dialog.  This may be nil or empty.
 */
- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results;
{
    [self updateGold:100];
}
/*!
 @abstract Sent to the delegate when the app invite encounters an error.
 @param appInviteDialog The FBSDKAppInviteDialog that completed.
 @param error The error.
 */
- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error;
{
    [self updateGold:100];
}


-(void)showSuccessMessageWithGold:(NSInteger)purchasedGold
{
    NSInteger gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:gold + purchasedGold forKey:@"purchasedGold"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
    
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You have Earned %ld Gold, Your total purchased gold is %ld",(long)purchasedGold,gold]];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];
    
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
            [self updateGold:purchasedGold];
            NSLog(@"OK");
            self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];
            
            [(BUHomeTabbarController *)[self tabBarController] updateGoldValue:[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];
        }];
        
        action;
    })];
    [self presentViewController:alertController  animated:YES completion:nil];
    
}



-(void)updateGold:(NSInteger)purchasedGold
{
    /*
     API to  upload :
     http://dev.thebureauapp.com/admin/update_profile_step6
     
     Parameters
     
     userid => user id of user
     years_in_usa => e.g. 0 - 2, 2 - 6
     legal_status => e.g. Citizen/Green Card, Greencard
     
     */
    
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                   @"gold_to_add":[NSString stringWithFormat:@"%ld",(long)purchasedGold]
                   };
    
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager]queryServer:parameters
                                             baseURL:@"http://dev.thebureauapp.com/admin/add_Gold"
                                        successBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         
         
         NSInteger gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];

         [[NSUserDefaults standardUserDefaults] setInteger:gold + purchasedGold forKey:@"purchasedGold"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You have purchased %ld Gold, Your total purchased gold is %ld",(long)purchasedGold,gold]];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         
         
         [alertController addAction:({
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                 NSLog(@"OK");
                 self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];
                 
                 [(BUHomeTabbarController *)[self tabBarController] updateGoldValue:[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];

             }];
             
             action;
         })];
         [self presentViewController:alertController  animated:YES completion:nil];
         
     }
                                        failureBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         NSInteger gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
         
         [[NSUserDefaults standardUserDefaults] setInteger:gold + purchasedGold forKey:@"purchasedGold"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You have purchased %ld Gold, Your total purchased gold is %ld",(long)purchasedGold,gold]];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         
         
         [alertController addAction:({
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                 NSLog(@"OK");
                 self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];
                 
                 [(BUHomeTabbarController *)[self tabBarController] updateGoldValue:[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];

             }];
             
             action;
         })];
         [self presentViewController:alertController  animated:YES completion:nil];
         
     }];
}


-(IBAction)likeUsOnFB:(id)sender
{
    
 
}


-(void)purchaseSuccess
{
    /*
     API to  upload :
     http://dev.thebureauapp.com/admin/update_profile_step6
     
     Parameters
     
     userid => user id of user
     years_in_usa => e.g. 0 - 2, 2 - 6
     legal_status => e.g. Citizen/Green Card, Greencard
     
     */
    
    NSInteger purchasedGold = 0;
    
    
    switch (self.selectedIndexPath.row)
    {
        case 0:
            purchasedGold = 1000;
            break;
        case 1:
            purchasedGold = 100;
            break;
        case 2:
            purchasedGold = 250;
            break;
        case 3:
            purchasedGold = 300;
            break;
        case 4:
            purchasedGold = 500;
            break;
        case 5:
            purchasedGold = 750;
            break;
            
        default:
            break;
    }
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                   @"gold_to_add":[NSString stringWithFormat:@"%ld",(long)purchasedGold]
                   };
    
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager]queryServer:parameters
                                             baseURL:@"http://dev.thebureauapp.com/admin/add_Gold"
                                        successBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         
         
         NSInteger gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
         NSInteger purchasedGold = 0;
         
         
         switch (self.selectedIndexPath.row)
         {
             case 0:
                 purchasedGold = 1000;
                 break;
             case 1:
                 purchasedGold = 100;
                 break;
             case 2:
                 purchasedGold = 250;
                 break;
             case 3:
                 purchasedGold = 300;
                 break;
             case 4:
                 purchasedGold = 500;
                 break;
             case 5:
                 purchasedGold = 750;
                 break;
                 
             default:
                 break;
         }
         
         [[NSUserDefaults standardUserDefaults] setInteger:gold + purchasedGold forKey:@"purchasedGold"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You have purchased %ld Gold, Your total purchased gold is %ld",(long)purchasedGold,gold]];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         
         
         [alertController addAction:({
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                 NSLog(@"OK");
                 self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];
                 
                 [(BUHomeTabbarController *)[self tabBarController] updateGoldValue:[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];

             }];
             
             action;
         })];
         [self presentViewController:alertController  animated:YES completion:nil];
         
     }
                                        failureBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         NSInteger gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
         NSInteger purchasedGold = 0;
         
         
         switch (self.selectedIndexPath.row)
         {
             case 0:
                 purchasedGold = 1000;
                 break;
             case 1:
                 purchasedGold = 750;
                 break;
             case 2:
                 purchasedGold = 500;
                 break;
             case 3:
                 purchasedGold = 100;
                 break;
                 
             default:
                 break;
         }
         
         [[NSUserDefaults standardUserDefaults] setInteger:gold + purchasedGold forKey:@"purchasedGold"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You have purchased %ld Gold, Your total purchased gold is %ld",(long)purchasedGold,gold]];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         
         
         [alertController addAction:({
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                 NSLog(@"OK");
                 self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];
                 
                 [(BUHomeTabbarController *)[self tabBarController] updateGoldValue:[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];

             }];
             
             action;
         })];
         [self presentViewController:alertController  animated:YES completion:nil];
         
     }];
    //         {
    //             [self stopActivityIndicator];
    //
    //             [self showFailureAlert];
    //         }];
    
    
    
}

-(void)purchaseFailed
{
    
}



-(void)getGoldDetails
{
    
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID
                   };
    [self startActivityIndicator:YES];

    
    NSString *baseURl = @"http://dev.thebureauapp.com/admin/getGoldAvailable";
    
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:baseURl
                                         successBlock:^(id response, NSError *error)
     {
         
         
         [[NSUserDefaults standardUserDefaults] setInteger:[[response valueForKey:@"available_gold"] intValue] forKey:@"purchasedGold"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         self.totalGoldLabel.text = [NSString stringWithFormat:@"%d",[[response valueForKey:@"available_gold"] intValue]];
         
         [(BUHomeTabbarController *)[self tabBarController] updateGoldValue:[[response valueForKey:@"available_gold"] intValue]];

         [self reload];
                                         }
                                         failureBlock:^(id response, NSError *error) {
                                             
                                             [self stopActivityIndicator];

                                             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error!"];
                                             [message addAttribute:NSFontAttributeName
                                                             value:[UIFont fontWithName:@"comfortaa" size:15]
                                                             range:NSMakeRange(0, message.length)];
                                             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                                             [alertController setValue:message forKey:@"attributedTitle"];
                                             
                                             [alertController addAction:({
                                                 UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                                                          {
                                                                              [self startActivityIndicator:YES];
                                                                              [self reload];
                                                     
                                                 }];
                                                 
                                                 action;
                                             })];
                                             
                                             [self presentViewController:alertController  animated:YES completion:nil];
                                             
                                         }];
    
}
@end
