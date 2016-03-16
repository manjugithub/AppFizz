//
//  BUAppNotificationCell.m
//  TheBureau
//
//  Created by Manjunath on 01/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUAppNotificationCell.h"
#import <DigitsKit/DigitsKit.h>
#import "BULayerHelper.h"

@implementation BUAppNotificationCell

/*
 
 Logout API
 
 URL: http://app.thebureauapp.com/admin/logout_ws
 Parameter:
 userid => id of a user
 
 Deactivate account API
 
 URL: http://app.thebureauapp.com/admin/deactivate_account_ws
 Parameter:
 userid => id of a user

 */
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changeNotificationSettings:(UIButton *)sender
{
    if(0 == [sender tag])
    {
        sender.tag = 1;
        [sender setImage:[UIImage imageNamed:@"switch_disable"]
                forState:UIControlStateNormal];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"switch_ON"]
                forState:UIControlStateNormal];
        sender.tag = 0;
    }
    
}

- (IBAction)deactivateAccount:(id)sender
{
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Do you wish to leave this appication? Your Information has not been saved"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
            [self.parentVC startActivityIndicator:YES];
            [[Digits sharedInstance]logOut];
            [[BULayerHelper sharedHelper]deauthenticateWithCompletion:^(BOOL success, NSError * _Nullable error) {
                [self.parentVC stopActivityIndicator];
                [self.parentVC.navigationController popToRootViewControllerAnimated:YES];
            }];
        }];
        
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
        }];
        
        action;
    })];
    [self.parentVC presentViewController:alertController  animated:YES completion:nil];
}
- (IBAction)deleteAccount:(id)sender
{
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Your Account will be deleted. Do you want to continue?"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];

    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
            [self.parentVC startActivityIndicator:YES];
            [[Digits sharedInstance]logOut];
            [[BULayerHelper sharedHelper]deauthenticateWithCompletion:^(BOOL success, NSError * _Nullable error) {
                [self.parentVC stopActivityIndicator];
                [self.parentVC.navigationController popToRootViewControllerAnimated:YES];
            }];
        }];
        
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
        }];
        
        action;
    })];
    [self.parentVC presentViewController:alertController  animated:YES completion:nil];
}
- (IBAction)logout:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Your will be Logged out. Do you want to continue?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
            [self.parentVC startActivityIndicator:YES];
            [[Digits sharedInstance]logOut];
            [[BULayerHelper sharedHelper]deauthenticateWithCompletion:^(BOOL success, NSError * _Nullable error) {
                [self.parentVC stopActivityIndicator];
                [self.parentVC.navigationController popToRootViewControllerAnimated:YES];
            }];
        }];
        
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
        }];
        
        action;
    })];
    [self.parentVC presentViewController:alertController  animated:YES completion:nil];
}

@end
