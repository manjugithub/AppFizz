//
//  BULoginViewController.m
//  TheBureau
//
//  Created by Manjunath on 26/11/15.
//  Copyright © 2015 Bureau. All rights reserved.
//

#import "BULoginViewController.h"
#import "FBController.h"
#import "BUSocialChannel.h"
#import "BUConstants.h"
#import "BUAuthButton.h"
#import <DigitsKit/DigitsKit.h>
#import "BUAccountCreationVC.h"
#import "BUHomeTabbarController.h"
#import <LayerKit/LayerKit.h>
#import "BUWebServicesManager.h"
#import "BULayerHelper.h"
@interface BULoginViewController ()//<LYRClientDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overLayViewTapConstraint;
@property (assign, nonatomic) CGFloat layoutConstant;

@property (weak, nonatomic) IBOutlet UITextField *emailTF,*passwordTF;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageview;
@property (weak, nonatomic) IBOutlet BUAuthButton *loginBtn;
@property (strong, nonatomic) DGTAppearance *theme;
@property (strong, nonatomic) DGTAuthenticationConfiguration *configuration;

@property (nonatomic) LYRClient *layerClient;

-(IBAction)loginUsingFacebook:(id)sender;
-(IBAction)loginUsingEmail:(id)sender;

@end

@implementation BULoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // _configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:dgt];
    self.title = @"login";
    _configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:DGTAccountFieldsDefaultOptionMask];
    _configuration.appearance = [self makeTheme];

}

- (DGTAppearance *)makeTheme {
    DGTAppearance *theme = [[DGTAppearance alloc] init];
    theme.bodyFont = [UIFont fontWithName:@"Comfortaa-Bold" size:16];
    theme.labelFont = [UIFont fontWithName:@"Comfortaa-Bold" size:17];
    theme.accentColor = [UIColor colorWithRed:(213.0/255.0) green:(15/255.0) blue:(37/255.0) alpha:1];
    theme.backgroundColor = [UIColor whiteColor];
    theme.logoImage = [UIImage imageNamed:@"logo_splash"];
    return theme;
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
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;

    
}
-(void)viewDidAppear:(BOOL)animated
{
  //  [self.loginBtn setupButtonThemeWithTitle:@"Login Using Phonenumber"];
    self.layoutConstant = self.overLayViewTapConstraint.constant;
}

#pragma mark - FACEBOOK -
-(void)associateFacebook
{
    [[FBController sharedInstance]clearSession];
    [[FBController sharedInstance] authenticateWithCompletionHandler:^(BUSocialChannel *socialChannel, NSError *error, BOOL whetherAlreadyAuthenticated) {
        if (!error) {
            self.socialChannel = socialChannel;
            [self loginWithDigit];
        }else{
            [[FBController sharedInstance]clearSession];
        }
    }];
}
#pragma mark - TextField Delegates
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.overLayViewTapConstraint.constant = self.layoutConstant-kLoginTopLayoutOffset;
    } completion:^(BOOL finished) {
    }];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.overLayViewTapConstraint.constant = self.layoutConstant;
    } completion:^(BOOL finished) {
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.overLayViewTapConstraint.constant = self.layoutConstant;
    } completion:^(BOOL finished) {
    }];
    return YES;
}
#pragma mark - Action Methods

-(IBAction)loginUsingFacebook:(id)sender
{
    self.loginType = eLoginFromFB;
    [self associateFacebook];
}
-(IBAction)loginUsingEmail:(id)sender
{
    [self performSegueWithIdentifier:@"account creation" sender:self];
}

-(IBAction)loginUsingPhonenum:(id)sender
{
    self.loginType = eLoginFromDigit;
    [self loginWithDigit];
}


-(void)loginWithDigit
{
    [[Digits sharedInstance] authenticateWithViewController:nil configuration:_configuration completion:^(DGTSession *session, NSError *error) {
        if (session) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if(nil == self.socialChannel)
                    self.socialChannel = [[BUSocialChannel alloc] init];
                
                self.socialChannel.mobileNumber = session.phoneNumber;
                self.socialChannel.emailID = session.emailAddress;
                
                NSDictionary *parameters = nil;
                
                if(nil == self.socialChannel.profileDetails.fbID)
                {
                    self.loginType = eLoginFromDigit;
                }
                if(self.loginType == eLoginFromFB)
                {
                    parameters = @{@"login_type": @"fb",
                                   @"fb_id":self.socialChannel.profileDetails.fbID,
                                   @"digits":session.phoneNumber};
                }
                else
                {
//                    parameters = @{@"login_type": @"digits",
//                                   @"digits":@"334445556723"};
                    
                                        parameters = @{@"login_type": @"digits",
                                                       @"digits":session.phoneNumber};
                }
                [self startActivityIndicator:YES];
                [[BUWebServicesManager sharedManager] loginWithDelegeatewithParameters:parameters
                                                                          successBlock:^(id inResult, NSError *error)
                 {
                     [self stopActivityIndicator];
                     
                     if(YES == [[inResult valueForKey:@"msg"] isEqualToString:@"Success"])
                     {
                         
                        
                         
                         [BUWebServicesManager sharedManager].userID = [inResult valueForKey:@"userid"];
                         [BUWebServicesManager sharedManager].userName = [NSString stringWithFormat:@"%@ %@",[[[inResult valueForKey:@"profile_details"] valueForKey:@"first_name"] lastObject],[[[inResult valueForKey:@"profile_details"] valueForKey:@"last_name"] lastObject]];
                         //    [inResult valueForKey:@"userid"];
                         
                         [[BULayerHelper sharedHelper] setCurrentUserID:[inResult valueForKey:@"userid"]];
                         
                         //                         [[BULayerHelper sharedHelper] setCurrentUserID:@"126"];
                         
                         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Login Successful"];
                         [message addAttribute:NSFontAttributeName
                                         value:[UIFont fontWithName:@"comfortaa" size:15]
                                         range:NSMakeRange(0, message.length)];
                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                         [alertController setValue:message forKey:@"attributedTitle"];
                         
                         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                            style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction *action)
                                                    {
                                                        [self startActivityIndicator:YES];

                                                        [[BULayerHelper sharedHelper] authenticateLayerWithsuccessBlock:^(id response, NSError *error)
                                                         {
                                                             [self checkForAccountCreation];
                                                         } failureBlock:^(id response, NSError *error)
                                                         {
                                                             NSLog(@"Failed Authenticating Layer Client with error:%@", error);
                                                             [self stopActivityIndicator];
                                                             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Failed Authenticating Layer Client with error:%@", error]];
                                                             [message addAttribute:NSFontAttributeName
                                                                             value:[UIFont fontWithName:@"comfortaa" size:15]
                                                                             range:NSMakeRange(0, message.length)];
                                                             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                                                             [alertController setValue:message forKey:@"attributedTitle"];
                                                             [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                                                             [self presentViewController:alertController animated:YES completion:nil];
                                                             
                                                         }];
                                                    }];
                         
                         [alertController addAction:okAction];
                         [self presentViewController:alertController animated:YES completion:nil];
                         
                     }
                     else
                     {
                         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Login Failed"];
                         [message addAttribute:NSFontAttributeName
                                         value:[UIFont fontWithName:@"comfortaa" size:15]
                                         range:NSMakeRange(0, message.length)];
                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                         [alertController setValue:message forKey:@"attributedTitle"];
                         
                         [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                         [self presentViewController:alertController animated:YES completion:nil];
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
                
            });
        } else {
            NSLog(@"Authentication error: %@", error.localizedDescription);
        }
    }];
    
}

-(void)checkForAccountCreation
{
    NSDictionary *parameters = nil;
    
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID};

    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:@"http://app.thebureauapp.com/admin/ValidateUserAccount"
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
         }
         else
         {
             UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
             BUAccountCreationVC *vc = [sb instantiateViewControllerWithIdentifier:@"AccountCreationVC"];
             vc.socialChannel = self.socialChannel;
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

-(IBAction)logout:(id)sender
{
    
    [[Digits sharedInstance]logOut];

}


@end
