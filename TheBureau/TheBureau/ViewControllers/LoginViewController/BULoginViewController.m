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
@interface BULoginViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overLayViewTapConstraint;
@property (assign, nonatomic) CGFloat layoutConstant;

@property (weak, nonatomic) IBOutlet UITextField *emailTF,*passwordTF;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageview;
@property (weak, nonatomic) IBOutlet BUAuthButton *loginBtn;
@property (strong, nonatomic) DGTAppearance *theme;
@property (strong, nonatomic) DGTAuthenticationConfiguration *configuration;

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
                
                
                /*
                 
                 Hello Manjunaht , Vinay  ,
                 
                 Please hit the below url from your end to check for login creds :
                 
                 http://app.thebureauapp.com/login/checkLogin
                 
                 Parameters to be POSTED :
                 
                 - login_type : Takes either 'fb' or 'digits' as input
                 
                 - if login_type is 'fb' , then the parameter to be posted is 'fb_id'  , else if login_type is 'digits' , parameter to be posted is 'digits'
                 
                 So for example , if login_type = fb and fb_id = 'asdj2312312kjas'
                 
                 The sample output will like below in the JSON format :
                 
                 {"msg":"Success","userid":"1","profile_details":[{"first_name":"Siddharth","last_name":"Raghunath","dob":"2016-01-14","gender":"Male","phone_number":"9591314204","email":"siddharth@zolipe.com"}]}
                 */
                
                
                NSDictionary *parameters = nil;
                
                if(self.loginType == eLoginFromFB)
                {
                    parameters = @{@"login_type": @"fb",
                                   @"fb_id":self.socialChannel.profileDetails.fbID,
                                   @"digits":session.phoneNumber};
                }
                else
                {
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
                         
                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Login Successful" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                         
                         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                            style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction *action)
                                                    {
                                                        
                                                        
                                                        UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
                                                        BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
                                                        [self.navigationController pushViewController:vc animated:YES];
                                                        
                                                        //                                       UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                        //                                       BUAccountCreationVC *vc = [sb instantiateViewControllerWithIdentifier:@"AccountCreationVC"];
                                                        //                                       vc.socialChannel = self.socialChannel;
                                                        //                                       [self.navigationController pushViewController:vc animated:YES];
                                                    }];
                         
                         [alertController addAction:okAction];
                         [self presentViewController:alertController animated:YES completion:nil];
                         
                     }
                     else
                     {
                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Login Failed" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                         [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                         [self presentViewController:alertController animated:YES completion:nil];
                     }
                     
                 }
                                                                          failureBlock:^(id response, NSError *error)
                 {
                     [self startActivityIndicator:YES];
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Login Failed" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                     [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                     [self presentViewController:alertController animated:YES completion:nil];
                 }];
                
            });
        } else {
            NSLog(@"Authentication error: %@", error.localizedDescription);
        }
    }];

}

-(IBAction)logout:(id)sender
{
    
    [[Digits sharedInstance]logOut];

}


-(void)didSuccess:(id)inResult;
{
    [self stopActivityIndicator];
    
    if(YES == [[inResult valueForKey:@"msg"] isEqualToString:@"Success"])
    {
        
        [BUWebServicesManager sharedManager].userID = [inResult valueForKey:@"userid"];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Login Successful" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       
                                       
                                       UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
                                       BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
                                       [self.navigationController pushViewController:vc animated:YES];

//                                       UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                                       BUAccountCreationVC *vc = [sb instantiateViewControllerWithIdentifier:@"AccountCreationVC"];
//                                       vc.socialChannel = self.socialChannel;
//                                       [self.navigationController pushViewController:vc animated:YES];
                                   }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Registration Failed" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

-(void)didFail:(id)inResult;
{
    [self startActivityIndicator:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Login Failed" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
