//
//  BUSignUpViewController.m
//  TheBureau
//
//  Created by Apple on 27/11/15.
//  Copyright © 2015 Bureau. All rights reserved.
//

#import "BUSignUpViewController.h"
#import "FBController.h"
#import "BUSocialChannel.h"
#import "BUConstants.h"
#import "BUAccountCreationVC.h"
#import <DigitsKit/DigitsKit.h>
#import "BULayerHelper.h"


@interface BUSignUpViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overLayViewTapConstraint;
@property (assign, nonatomic) CGFloat layoutConstant;


@property (weak, nonatomic) IBOutlet UITextField *emailTF,*passwordTF,*confirmPaswordTF;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageview;
@property (strong, nonatomic) DGTAuthenticationConfiguration *configuration;
@property(nonatomic) eNavigatedFrom navFrom;



-(IBAction)signupUsingFacebook:(id)sender;
-(IBAction)signupUsingEmail:(id)sender;

@end

@implementation BUSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:DGTAccountFieldsDefaultOptionMask];
  //  _configuration.appearance = [self makeTheme];
    
    self.title =@"Sign Up";
    
    _configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:DGTAccountFieldsEmail];
    
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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewDidAppear:(BOOL)animated
{
    
    self.layoutConstant = self.overLayViewTapConstraint.constant;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - FACEBOOK -
-(void)associateFacebook
{
    [[FBController sharedInstance]clearSession];
    [[FBController sharedInstance] authenticateWithCompletionHandler:^(BUSocialChannel *socialChannel, NSError *error, BOOL whetherAlreadyAuthenticated) {
        if (!error) {
            self.navFrom = eNavFromFb;
            self.socialChannel = socialChannel;
            
            
                        [self regiserWithDigits];
        }else{
            [[FBController sharedInstance]clearSession];
        }
    }];
}
#pragma mark - TextField Delegates
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.overLayViewTapConstraint.constant = self.layoutConstant-kSignupTopLayoutOffset;
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

-(IBAction)signupUsingFacebook:(id)sender
{
    self.registrationType = eRegistrationFromFB;
    [self associateFacebook];
}
-(IBAction)signupUsingEmail:(id)sender
{
    [self performSegueWithIdentifier:@"ShowAccount" sender:self];
}

-(IBAction)signUpUsingPhonenum:(id)sender{
    
    self.registrationType = eRegistrationFromDigit;
    [self regiserWithDigits];
}

-(void)regiserWithDigits
{
    [[Digits sharedInstance] authenticateWithViewController:nil configuration:_configuration completion:^(DGTSession *session, NSError *error) {
        if (session) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // TODO: associate the session userID with your user model
                
                if(nil == self.socialChannel)
                    self.socialChannel = [[BUSocialChannel alloc] init];

                self.socialChannel.mobileNumber = session.phoneNumber;
                self.socialChannel.emailID = session.emailAddress;
                
                NSDictionary *parameters = nil;
                
                if(nil == self.socialChannel.profileDetails.fbID)
                {
                    self.registrationType = eRegistrationFromDigit;
                }

                if(self.registrationType == eRegistrationFromFB)
                {
                   parameters =  @{@"reg_type": @"fb",
                      @"digits":session.phoneNumber,
                                   @"fb_id":self.socialChannel.profileDetails.fbID};
                }
                else
                {
                   parameters =  @{@"reg_type": @"digits",
                                 @"digits":session.phoneNumber};
//                    parameters =  @{@"reg_type": @"digits",
//                                    @"digits":@"990292473210"};
                }
                [self startActivityIndicator:YES];
                
                [[BUWebServicesManager sharedManager] signUpWithDelegeatewithParameters:parameters
                                                                           successBlock:^(id inResult, NSError *error)
                 {
                     [self stopActivityIndicator];
                     
                     if(YES == [[inResult valueForKey:@"msg"] isEqualToString:@"Success"])
                     {
                         [[NSUserDefaults standardUserDefaults] setValue:[inResult valueForKey:@"userid"] forKey:@"userid"];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                         [BUWebServicesManager sharedManager].userID = [inResult valueForKey:@"userid"];
                         [[BULayerHelper sharedHelper] setCurrentUserID:[inResult valueForKey:@"userid"]];

                         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Registration Successful"];
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
                                                        

                                                        [[BULayerHelper sharedHelper] authenticateLayerWithsuccessBlock:^(id response, NSError *error) {
                                                            [self stopActivityIndicator];
                                                            
                                                            UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                            BUAccountCreationVC *vc = [sb instantiateViewControllerWithIdentifier:@"AccountCreationVC"];
                                                            vc.socialChannel = self.socialChannel;
                                                            [self.navigationController pushViewController:vc animated:YES];
                                                        } failureBlock:^(id response, NSError *error) {
                                                            {
                                                                [self stopActivityIndicator];
                                                                NSLog(@"Failed Authenticating Layer Client with error:%@", error);
                                                                NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Failed Authenticating Layer Client with error:%@", error]];
                                                                [message addAttribute:NSFontAttributeName
                                                                                value:[UIFont fontWithName:@"comfortaa" size:15]
                                                                                range:NSMakeRange(0, message.length)];
                                                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                                                                [alertController setValue:message forKey:@"attributedTitle"];
                                                                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                                                                [self presentViewController:alertController animated:YES completion:nil];
                                                                
                                                            }                                                        }];
                                                        
                                                    }];
                         
                         [alertController addAction:okAction];
                         [self presentViewController:alertController animated:YES completion:nil];
                         
                     }
                     else
                     {
                         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[inResult valueForKey:@"response"]];
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
                     NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Registration Failed"];
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

-(void)didSuccess:(id)inResult;
{
    [self stopActivityIndicator];

    if(YES == [[inResult valueForKey:@"msg"] isEqualToString:@"Success"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:[inResult valueForKey:@"userid"] forKey:@"userid"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [BUWebServicesManager sharedManager].userID = [inResult valueForKey:@"userid"];

        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Registration Successful"];
        [message addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"comfortaa" size:15]
                        range:NSMakeRange(0, message.length)];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:message forKey:@"attributedTitle"];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                       BUAccountCreationVC *vc = [sb instantiateViewControllerWithIdentifier:@"AccountCreationVC"];
                                       vc.socialChannel = self.socialChannel;
                                       [self.navigationController pushViewController:vc animated:YES];
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
        [alertController setValue:message forKey:@"attributedTitle"];        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

-(void)didFail:(id)inResult;
{
    [self stopActivityIndicator];
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Registration Failed"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
