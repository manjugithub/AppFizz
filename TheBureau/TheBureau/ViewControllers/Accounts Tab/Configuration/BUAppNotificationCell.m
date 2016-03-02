//
//  BUAppNotificationCell.m
//  TheBureau
//
//  Created by Manjunath on 01/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUAppNotificationCell.h"
#import <DigitsKit/DigitsKit.h>

@implementation BUAppNotificationCell

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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Your Account will be deactivated. Do you want to continue?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
            [self.parentVC.navigationController popToRootViewControllerAnimated:YES];
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Your Account will be deleted. Do you want to continue?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
            [self.parentVC.navigationController popToRootViewControllerAnimated:YES];
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
            [[Digits sharedInstance]logOut];

            [self.parentVC.navigationController popToRootViewControllerAnimated:YES];
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
