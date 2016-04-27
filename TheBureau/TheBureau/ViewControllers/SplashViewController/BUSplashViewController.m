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
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"splash_new" withExtension:@"gif"];
    self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
    self.navigationController.navigationBarHidden = YES;
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    
   splashTimer  = [NSTimer scheduledTimerWithTimeInterval:6.2 target:self selector:@selector(setSplashTimer) userInfo:nil repeats:NO];

    
}

-(void)setSplashTimer
{
    [splashTimer invalidate];
    
    
//    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"ProfileCreation" bundle:nil];
//    BUProfileDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUProfileDetailsVC"];
//    [self.navigationController pushViewController:vc animated:YES];

    if(0)//(nil != [BUWebServicesManager sharedManager].userID)
    {
        [Localytics tagEvent:@"Login Successful"];
        [Localytics setCustomerId:[BUWebServicesManager sharedManager].userID];;

        UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
        BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self performSegueWithIdentifier:@"main" sender:self];
    }
    
    
//    {
//        UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
//        BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
//        [self.navigationController pushViewController:vc animated:YES];
    
//

    
    
//    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    BUAccountCreationVC *vc = [sb instantiateViewControllerWithIdentifier:@"AccountCreationVC"];
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
//
//    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"ProfileCreation" bundle:nil];
//    BUProfileSelectionVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUProfileSelectionVC"];
//    [self.navigationController pushViewController:vc animated:YES];

    
//  UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Connections" bundle:nil];
//   BUContactListViewController *vc = [sb instantiateViewControllerWithIdentifier:@"BUContactListViewController"];
//   [self.navigationController pushViewController:vc animated:YES];
    
//    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
//    BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
//    [self.navigationController pushViewController:vc animated:YES];
    

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
