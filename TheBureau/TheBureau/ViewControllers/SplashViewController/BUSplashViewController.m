//
//  BUSplashViewController.m
//  TheBureau
//
//  Created by Accion Labs on 18/01/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUSplashViewController.h"
#import "UIImage+animatedGIF.h"
#import "BUProfileOccupationVC.h"
#import "BUProfileSelectionVC.h"
#import "BUProfileDetailsVC.h"
#import "BUAccountCreationVC.h"
#import "BUHomeTabbarController.h"
#import "BUProfileLegalStatusVC.h"
#import "BUProfileDietVC.h"
#import "BUProfileHeritageVC.h"
#import "BUProfileRematchVC.h"
#import "BUContactListViewController.h"
#import "Localytics.h"
#import "BULayerHelper.h"
@interface BUSplashViewController ()
{
    
    NSTimer *splashTimer;

}
@property (strong, nonatomic) IBOutlet UIImageView *dataImageView;
@end

@implementation BUSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"splash_new_iPhone" withExtension:@"gif"];
    
    if ( IDIOM == IPAD )
    {
        url = [[NSBundle mainBundle] URLForResource:@"splash_new_iPad" withExtension:@"gif"];
    }
    else
    {
        url = [[NSBundle mainBundle] URLForResource:@"splash_new_iPhone" withExtension:@"gif"];
    }

    self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
    self.navigationController.navigationBarHidden = YES;
    
    
    splashTimer  = [NSTimer scheduledTimerWithTimeInterval:6.2 target:self selector:@selector(setSplashTimer) userInfo:nil repeats:NO];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    if(nil == splashTimer)
    {
        [self setSplashTimer];
    }
}

-(void)checkForAccountCreation
{
    NSDictionary *parameters = nil;
    
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID};
    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:@"http://dev.thebureauapp.com/admin/ValidateUserAccount"
                                         successBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         [self stopActivityIndicator];
         [self stopActivityIndicator];
         [self stopActivityIndicator];
         if(YES == [[response valueForKey:@"msg"] isEqualToString:@"Success"])
         {
             UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
             BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
             [self.navigationController pushViewController:vc animated:YES];
             [[BULayerHelper sharedHelper] setCurrentUserID:[BUWebServicesManager sharedManager].userID];
             
             [self startActivityIndicator:YES];
             
             [[BULayerHelper sharedHelper] authenticateLayerWithsuccessBlock:^(id response, NSError *error)
              {
                  
              }
                                                                failureBlock:^(id response, NSError *error)
              {
                  NSLog(@"Failed Authenticating Layer Client with error:%@", error);
                  [self stopActivityIndicator];
                  return ;
              }];
         }
         else
         {
             UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
             BUAccountCreationVC *vc = [sb instantiateViewControllerWithIdentifier:@"AccountCreationVC"];
             vc.socialChannel = nil;
             [self.navigationController pushViewController:vc animated:YES];
         }
     }
                                         failureBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Login Failed"];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alertController animated:YES completion:nil];
     }];
}

-(void)setSplashTimer
{
    [splashTimer invalidate];
    splashTimer = nil;

//    [self performSegueWithIdentifier:@"main" sender:self];
//    return;
    
//    [BUWebServicesManager sharedManager].userID = @"39";
//    7
    if(nil != [BUWebServicesManager sharedManager].userID)
    {
        
        [BUWebServicesManager sharedManager].userName =        [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];

        [self checkForAccountCreation];
    }
    else
    {
        [self performSegueWithIdentifier:@"main" sender:self];
    }

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
