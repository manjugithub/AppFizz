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

@interface BULoginViewController ()<LYRClientDelegate>

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
    
    NSURL *appID = [NSURL URLWithString:@"layer:///apps/staging/238530d8-995f-11e5-9461-6ac9d8033a8c"];
    self.layerClient = [LYRClient clientWithAppID:appID];

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
                                                        
//                                                     [self loginLayer];
   
                                                        UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
                                                        BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
                                                        [self.navigationController pushViewController:vc animated:YES];
                                                        
//                                                                                               UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                                                                                               BUAccountCreationVC *vc = [sb instantiateViewControllerWithIdentifier:@"AccountCreationVC"];
//                                                                                               vc.socialChannel = self.socialChannel;
//                                                                                               [self.navigationController pushViewController:vc animated:YES];
                                                    }];
                         
                         [alertController addAction:okAction];
                         [self presentViewController:alertController animated:YES completion:nil];
                         
                     }
                     else
                     {
                         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[inResult valueForKey:@"response"] ];
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
                     [self startActivityIndicator:YES];
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
                                       
                                      [self loginLayer];
//                                       UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
//                                       BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
//                                       [self.navigationController pushViewController:vc animated:YES];

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
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Registration Failed"];
        [message addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"comfortaa" size:15]
                        range:NSMakeRange(0, message.length)];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:message forKey:@"attributedTitle"];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

-(void)didFail:(id)inResult;
{
    [self startActivityIndicator:YES];
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Login Failed"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Layer Authentication Methods

- (void)loginLayer
{
    [self startActivityIndicator:YES];

    [self.layerClient connectWithCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Failed to connect to Layer: %@", error);
        } else {
//            PFUser *user = [PFUser currentUser];
            NSString *userID = [BUWebServicesManager sharedManager].userID;
// Pass User ID HERE
            
            [self authenticateLayerWithUserID:userID completion:^(BOOL success, NSError *error) {
                if (!error){
                } else {
                    NSLog(@"Failed Authenticating Layer Client with error:%@", error);
                }
            }];
        }
    }];
}

- (void)authenticateLayerWithUserID:(NSString *)userID completion:(void (^)(BOOL success, NSError * error))completion
{
    // Check to see if the layerClient is already authenticated.
    if (self.layerClient.authenticatedUserID) {
        if ([self.layerClient.authenticatedUserID isEqualToString:userID]){
            NSLog(@"Layer Authenticated as User %@", self.layerClient.authenticatedUserID);
            [BUWebServicesManager sharedManager].layerClient = self.layerClient;
            
            [self stopActivityIndicator];

            if (completion) completion(YES, nil);
            {
        UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
     BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
        [self.navigationController pushViewController:vc animated:YES];
                
                return;}
        } else {
            //If the authenticated userID is different, then deauthenticate the current client and re-authenticate with the new userID.
            [self.layerClient deauthenticateWithCompletion:^(BOOL success, NSError *error) {
                if (!error){
                    [self authenticationTokenWithUserId:userID completion:^(BOOL success, NSError *error) {
                        if (completion){
                            
                                                      
                            completion(success, error);
                            
                            
                        }
                    }];
                } else {
                    if (completion){
                        completion(NO, error);
                    }
                }
            }];
        }
    } else {
        // If the layerClient isn't already authenticated, then authenticate.
        [self authenticationTokenWithUserId:userID completion:^(BOOL success, NSError *error) {
            if (completion){
                completion(success, error);
            }
        }];
    }
}

- (void)authenticationTokenWithUserId:(NSString *)userID completion:(void (^)(BOOL success, NSError* error))completion
{
    /*
     * 1. Request an authentication Nonce from Layer
     */
    [self.layerClient requestAuthenticationNonceWithCompletion:^(NSString *nonce, NSError *error) {
        if (!nonce) {
            if (completion) {
                completion(NO, error);
            }
            return;
        }
        
        /*
         * 2. Acquire identity Token from Layer Identity Service
         */
        
        NSDictionary *parameters = nil;
        parameters = @{@"userid": userID
                       ,@"nonce": nonce};
     //   NSDictionary *parameters = @{@"nonce" : nonce, @"userid" : userID};
        
        [[BUWebServicesManager sharedManager] getLayerAuthTokenwithParameters:parameters
                                                              successBlock:^(id inResult, NSError *error)
         {
            // [self stopActivityIndicator];
             if(nil != inResult && 0 < [inResult count])
             {
                 NSString *identityToken = [inResult valueForKey:@"identity_token"];
                 
                 [self.layerClient authenticateWithIdentityToken:identityToken completion:^(NSString *authenticatedUserID, NSError *error) {
                     if (authenticatedUserID) {
                         if (completion) {
                             completion(YES, nil);
                         }
                        
                         UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
                         BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
                         [self.navigationController pushViewController:vc animated:YES];

                     }
                     else
                     {
                         completion(NO, error);
                     }
                 }];

               
             }
             else
             {
                 NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
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
             [self startActivityIndicator:YES];
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];             [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
             [self presentViewController:alertController animated:YES completion:nil];
         }];

        // Should call Api here and add below block
        
        // [self.layerClient authenticateWithIdentityToken:identityToken completion:^(NSString *authenticatedUserID, NSError *error) {
        
        
//        [PFCloud callFunctionInBackground:@"generateToken" withParameters:parameters block:^(id object, NSError *error) {
//            if (!error){
//
        //NSString *identityToken =
        
//                [self.layerClient authenticateWithIdentityToken:identityToken completion:^(NSString *authenticatedUserID, NSError *error) {
//                    if (authenticatedUserID) {
//                        if (completion) {
//                            completion(YES, nil);
//                        }
//                        
//                    }
//                    else
//                    {
//                        completion(NO, error);
//                    }
//                }];
//            } else {
//                NSLog(@"Parse Cloud function failed to be called to generate token with error: %@", error);
//            }
//        }];
        
    }];
}




@end
