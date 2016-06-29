//
//  BUReferalVC.m
//  TheBureau
//
//  Created by Manjunath on 27/06/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUReferalVC.h"
#import "BUHomeTabbarController.h"
#import "BUWebServicesManager.h"
@interface BUReferalVC ()

@end

@implementation BUReferalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


-(IBAction)skipReferal:(id)sender
{
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)continueClicked:(id)sender
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                   @"referral_code":self.referalTF.text
                   };
    
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager]queryServer:parameters
                                             baseURL:@"http://dev.thebureauapp.com/admin/checkReferralCode"
                                        successBlock:^(id response, NSError *error)
     {
         
         [self stopActivityIndicator];

         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[response valueForKey:@"response"]];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action)
                                    {
                                        if(NO == [[[response valueForKey:@"msg"] lowercaseString] isEqualToString:@"error"])
                                        {
                                            UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
                                            BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
                                            [self.navigationController pushViewController:vc animated:YES];
                                        }
                                    }];
         
         [alertController addAction:okAction];
         [self presentViewController:alertController animated:YES completion:nil];
         

         
         
     }
                                        failureBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         
         [self showFailureAlert];
     }];
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
