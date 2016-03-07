//
//  BUGoldTabVC.m
//  TheBureau
//
//  Created by Manjunath on 07/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUGoldTabVC.h"
#import "BUGoldTabCell.h"
@interface BUGoldTabVC ()

@property(nonatomic, weak) IBOutlet UILabel *totalGoldLabel;

@property(nonatomic, weak) IBOutlet UIButton *inviteFriendButton,*likeUsOnFBButton;

-(IBAction)inviteFriend:(id)sender;
-(IBAction)likeUsOnFB:(id)sender;
@end

@implementation BUGoldTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.totalGoldLabel.text = [NSString stringWithFormat:@"%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"purchasedGold"]];

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

@end
