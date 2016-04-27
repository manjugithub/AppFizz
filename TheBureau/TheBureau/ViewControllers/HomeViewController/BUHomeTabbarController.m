//
//  BUHomeTabbarController.m
//  TheBureau
//
//  Created by Manjunath on 08/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUHomeTabbarController.h"
#import "AirshipLib.h"
#import "AirshipKit.h"
#import "AirshipCore.h"

@interface BUHomeTabbarController ()<UAPushNotificationDelegate>

@end

@implementation BUHomeTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"TheBureau";
    
    self.navigationItem.hidesBackButton = YES;
    // Call takeOff (which creates the UAirship singleton)
    [UAirship takeOff];
    
    // User notifications will not be enabled until userPushNotificationsEnabled is
    // set YES on UAPush. Once enabled, the setting will be persisted and the user
    // will be prompted to allow notifications. Normally, you should wait for a more
    // appropriate time to enable push to increase the likelihood that the user will
    // accept notifications.
    [UAirship push].userPushNotificationsEnabled = YES;
    
    [UAirship push].pushNotificationDelegate = self;
    
    
}



- (void)displayNotificationAlert:(NSString *)alertMessage
{
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:alertMessage];
    [titleStr addAttribute:NSFontAttributeName
                     value:[UIFont fontWithName:@"comfortaa" size:15]
                     range:NSMakeRange(0, titleStr.length)];
    
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Do you want to View?"];
    
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:titleStr
                       forKey:@"attributedTitle"];
    
    [alertController setValue:message
                       forKey:@"attributedMessage"];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action)
                                 {
                                     NSLog(@"OK");
                                     
                                 }];
        
        action;
    })];
    
//    [alertController addAction:({
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Not now"
//                                                         style:UIAlertActionStyleDefault
//                                                       handler:^(UIAlertAction *action) {
//                                                           NSLog(@"OK");
//                                                           
//                                                       }];
//        
//        action;
//    })];
    
    [self.navigationController.topViewController presentViewController:alertController animated:YES completion:nil];
    
    NSLog(@"displayNotificationAlert ==> %@",alertMessage);
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

@end
