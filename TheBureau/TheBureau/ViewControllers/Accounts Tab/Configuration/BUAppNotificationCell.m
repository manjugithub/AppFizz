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
#import "BUWebServicesManager.h"
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


-(void)updateBtnStatus
{
    BOOL status = NO;
    NSUserDefaults *usDef = [NSUserDefaults standardUserDefaults];
    switch (self.appNotificationCellType)
    {
        case BUAppNotificationCellTypeDailyMatch:
        {
         status =   [usDef boolForKey:@"BUAppNotificationCellTypeDailyMatch"];
            break;
        }
        case BUAppNotificationCellTypeChatNotifications:
        {
            status =[usDef boolForKey:@"BUAppNotificationCellTypeChatNotifications"];
            break;
        }
        case BUAppNotificationCellTypeCustomerService:
        {
            status =[usDef boolForKey:@"BUAppNotificationCellTypeCustomerService"];
            break;
        }
        case BUAppNotificationCellTypeBlogRelease:
        {
            status =[usDef boolForKey:@"BUAppNotificationCellTypeBlogRelease"];
            break;
        }
        case BUAppNotificationCellTypeSounds:
        {
            status =[usDef boolForKey:@"BUAppNotificationCellTypeSounds"];
            break;
        }
            
        default:
            break;
    }
    
    
    if(YES == status)
    {
        self.switchBtn.tag = 0;
        [self.switchBtn setImage:[UIImage imageNamed:@"switch_disable"]
                           forState:UIControlStateNormal];
    }
    else
    {
        [self.switchBtn setImage:[UIImage imageNamed:@"switch_ON"]
                           forState:UIControlStateNormal];
        self.switchBtn.tag = 1;
    }

}

- (IBAction)changeNotificationSettings:(UIButton *)sender
{
    NSString *baseURL;
    NSDictionary *parameters = nil;
    NSUserDefaults *usDef = [NSUserDefaults standardUserDefaults];
    switch (self.appNotificationCellType)
    {
        case BUAppNotificationCellTypeDailyMatch:
        {
            baseURL = @"http://app.thebureauapp.com/admin/conf_dailyMatch";
            if(0 == [sender tag])
            {
                sender.tag = 1;
                [sender setImage:[UIImage imageNamed:@"switch_ON"]
                        forState:UIControlStateNormal];

                [usDef setBool:NO forKey:@"BUAppNotificationCellTypeDailyMatch"];

                
                parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                               @"daily_match": @"YES"
                               };
            }
            else
            {
                [sender setImage:[UIImage imageNamed:@"switch_disable"]
                        forState:UIControlStateNormal];

                sender.tag = 0;
                [usDef setBool:YES forKey:@"BUAppNotificationCellTypeDailyMatch"];
                parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                               @"daily_match": @"NO"
                               };
            }
            
            break;
        }
        case BUAppNotificationCellTypeChatNotifications:
        {
            baseURL = @"http://app.thebureauapp.com/admin/conf_chatNotifications";
            if(0 == [sender tag])
            {
                sender.tag = 1;
                [sender setImage:[UIImage imageNamed:@"switch_ON"]
                        forState:UIControlStateNormal];
                [usDef setBool:NO forKey:@"BUAppNotificationCellTypeChatNotifications"];
                parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                               @"chat_notification": @"YES"
                               };
            }
            else
            {
                [sender setImage:[UIImage imageNamed:@"switch_disable"]
                        forState:UIControlStateNormal];
                sender.tag = 0;
                [usDef setBool:YES forKey:@"BUAppNotificationCellTypeChatNotifications"];
                parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                               @"chat_notification": @"NO"
                               };
            }
            
            break;
        }
        case BUAppNotificationCellTypeCustomerService:
        {
            baseURL = @"http://app.thebureauapp.com/admin/conf_customerService";
            if(0 == [sender tag])
            {
                sender.tag = 1;
                [sender setImage:[UIImage imageNamed:@"switch_ON"]
                        forState:UIControlStateNormal];
                [usDef setBool:NO forKey:@"BUAppNotificationCellTypeCustomerService"];
                parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                               @"customer_service": @"YES"
                               };
            }
            else
            {
                [sender setImage:[UIImage imageNamed:@"switch_disable"]
                        forState:UIControlStateNormal];
                sender.tag = 0;
                [usDef setBool:YES forKey:@"BUAppNotificationCellTypeCustomerService"];
                parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                               @"customer_service": @"NO"
                               };
            }
            
            break;
        }
        case BUAppNotificationCellTypeBlogRelease:
        {
            baseURL = @"http://app.thebureauapp.com/admin/conf_blogRelease";
            if(0 == [sender tag])
            {
                sender.tag = 1;
                [sender setImage:[UIImage imageNamed:@"switch_ON"]
                        forState:UIControlStateNormal];
                [usDef setBool:NO forKey:@"BUAppNotificationCellTypeBlogRelease"];
                parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                               @"blog_release": @"YES"
                               };
            }
            else
            {
                [sender setImage:[UIImage imageNamed:@"switch_disable"]
                        forState:UIControlStateNormal];
                sender.tag = 0;
                [usDef setBool:YES forKey:@"BUAppNotificationCellTypeBlogRelease"];
                parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                               @"blog_release": @"NO"
                               };
            }
            
            break;
        }
        case BUAppNotificationCellTypeSounds:
        {
            baseURL = @"http://app.thebureauapp.com/admin/conf_sound";
            if(0 == [sender tag])
            {
                sender.tag = 1;
                [sender setImage:[UIImage imageNamed:@"switch_ON"]
                        forState:UIControlStateNormal];
                [usDef setBool:NO forKey:@"BUAppNotificationCellTypeSounds"];
                parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                               @"sound": @"YES"
                               };
            }
            else
            {
                [sender setImage:[UIImage imageNamed:@"switch_disable"]
                        forState:UIControlStateNormal];
                sender.tag = 0;
                [usDef setBool:YES forKey:@"BUAppNotificationCellTypeSounds"];
                parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                               @"sound": @"NO"
                               };
            }
            
            break;
        }
            
        default:
            break;
    }
    
    [usDef synchronize];
    
    
    
    [self.parentVC startActivityIndicator:YES];
    
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:baseURL
                                         successBlock:^(id response, NSError *error)
    {
        [self.parentVC stopActivityIndicator];

        
                                         } failureBlock:^(id response, NSError *error)
    {
        [self.parentVC stopActivityIndicator];
        
    }];

    
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
                [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"userid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [BUWebServicesManager sharedManager].userID = nil;
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
                [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"userid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [BUWebServicesManager sharedManager].userID = nil;
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
                [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"userid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [BUWebServicesManager sharedManager].userID = nil;
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
