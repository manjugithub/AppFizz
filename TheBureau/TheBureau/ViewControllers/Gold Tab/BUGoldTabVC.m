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
@interface BUGoldTabVC ()<FBSDKAppInviteDialogDelegate>

@property(nonatomic, weak) IBOutlet UILabel *totalGoldLabel;
@property(nonatomic, strong) NSArray *products;
@property(nonatomic, weak) IBOutlet UIButton *inviteFriendButton,*likeUsOnFBButton;

-(IBAction)inviteFriend:(id)sender;
-(IBAction)likeUsOnFB:(id)sender;
@end

@implementation BUGoldTabVC


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self reload];
}

- (void)reload {
    _products = nil;
    
    [self startActivityIndicator:YES];
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

    self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];

    
    self.inviteFriendButton.layer.cornerRadius = 5.0;
    self.inviteFriendButton.layer.borderWidth = 1.0;
    self.inviteFriendButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.inviteFriendButton.layer.shadowOffset = CGSizeMake(2, 2);
    self.inviteFriendButton.layer.shadowColor = [[UIColor darkGrayColor]CGColor];


    self.likeUsOnFBButton.layer.cornerRadius = 5.0;
    self.likeUsOnFBButton.layer.borderWidth = 1.0;
    self.likeUsOnFBButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.likeUsOnFBButton.layer.shadowOffset = CGSizeMake(2, 2);
    self.likeUsOnFBButton.layer.shadowColor = [[UIColor darkGrayColor]CGColor];
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
    return 4;
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
            cell.goldLabel.text = @"750";
            cell.priceLabel.text = @"$ 7.99";
            break;
        case 2:
            cell.goldLabel.text = @"500";
            cell.priceLabel.text = @"$ 4.99";
            break;
        case 3:
            cell.goldLabel.text = @"100";
            cell.priceLabel.text = @"$ 1.99";
            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"collectionView willDisplayCell: %ld",indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
    NSInteger purchasedGold = 0;

    switch (indexPath.row)
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

    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You have purchased %ld Gold, Your total purchased gold is %ld",purchasedGold,gold]];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];
    
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];
        }];
        
        action;
    })];
    [self presentViewController:alertController  animated:YES completion:nil];
    
}

-(IBAction)inviteFriend:(id)sender
{
    
        FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
        content.appLinkURL = [NSURL URLWithString:@"https://app.cancerlife.com/fb.html"];
    
        [FBSDKAppInviteDialog showFromViewController:self withContent:content delegate:self];
        //    [_facebookLoginButton setEnabled:NO];
        //    _activeIndicator.hidden = NO;
        //    [_activeIndicator startAnimating];
        //    [NB_FBLoginPaser login:self];
    
}
-(void)showSuccessMessage
{
    NSInteger gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
    NSInteger purchasedGold = 100;
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:gold + purchasedGold forKey:@"purchasedGold"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
    
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You have Earned %ld Gold, Your total purchased gold is %ld",purchasedGold,gold]];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];
    
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];
        }];
        
        action;
    })];
    [self presentViewController:alertController  animated:YES completion:nil];
    
}
-(IBAction)likeUsOnFB:(id)sender
{
    
//    FBSDKLikeControl *likeButton = [[FBSDKLikeControl alloc]initWithFrame:CGRectMake(20, 294, 560, 40)];
//    likeButton.objectID = @"https://www.facebook.com/FacebookDevelopers";
//    
//    [self.view addSubview:likeButton];
    
//    NSInteger gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
//    NSInteger purchasedGold = 100;
//    
//    
//    [[NSUserDefaults standardUserDefaults] setInteger:gold + purchasedGold forKey:@"purchasedGold"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    gold = [[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"];
//    
//    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You have Earned %ld Gold, Your total purchased gold is %ld",purchasedGold,gold]];
//    [message addAttribute:NSFontAttributeName
//                    value:[UIFont fontWithName:@"comfortaa" size:15]
//                    range:NSMakeRange(0, message.length)];
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
//    [alertController setValue:message forKey:@"attributedTitle"];
//    
//    
//    [alertController addAction:({
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            NSLog(@"OK");
//            self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];
//        }];
//        
//        action;
//    })];
//    [self presentViewController:alertController  animated:YES completion:nil];
    
}

@end
