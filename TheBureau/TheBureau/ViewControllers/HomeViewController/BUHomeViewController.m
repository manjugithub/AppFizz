//
//  BUHomeViewController.m
//  TheBureau
//
//  Created by Manjunath on 08/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUHomeViewController.h"
#import "BUHomeProfileImgPrevCell.h"
#import "BUMatchInfoCell.h"
#import "BUAboutMeCell.h"
#import "BUCreatedByCell.h"
#import "AFHTTPSessionManager.h"
#import "Localytics.h"
@interface BUHomeViewController ()
@property(nonatomic, strong) NSMutableArray *imagesList;
@property(nonatomic, strong) IBOutlet UITableView *imgScrollerTableView;
@property(nonatomic, strong) NSMutableDictionary *datasourceList;
@property(nonatomic, strong) NSMutableArray *keysList;
@property(nonatomic, strong) NSString *matchUserID;
//@property(nonatomic, strong) NSDictionary *datasourceList;
@property(nonatomic, strong) IBOutlet UIImageView *noProfileImgView;

@property(nonatomic, strong) IBOutlet UIButton *matchBtn,*passBtn;
@property (weak, nonatomic) IBOutlet UIImageView *profileStatusImgView;

@property (weak, nonatomic) IBOutlet UIButton *flagBtn;





@end

@implementation BUHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.imagesList = [NSMutableArray arrayWithObjects:@"1",@"5",@"4",@"3",@"2", nil];
    self.datasourceList = nil;
    // Do any additional setup after loading the view.
    
    self.imgScrollerTableView.hidden = YES;

    self.profileStatusImgView.hidden = YES;

    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;    
    [self getGoldDetails];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.noProfileImgView.hidden = NO;
    NSLog(@"Table view size frame: %@",NSStringFromCGRect(self.imgScrollerTableView.bounds));
    self.imgScrollerTableView.hidden = NO;
    [self.imgScrollerTableView reloadData];
    [self getMatchMakingfortheDay];
    

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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(0 == indexPath.row)
    {
        return self.imgScrollerTableView.frame.size.height;
    }
    if(self.keysList.count  == indexPath.row)
    {
        return 100;
    }
    return 20;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.keysList.count > 0 ? self.keysList.count + 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(0 == indexPath.row)
    {
        BUHomeProfileImgPrevCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUHomeProfileImgPrevCell"];
        [cell setImagesListToScroll:self.imagesList];
        return cell;

    }
    else
    {
        
        if(1 == indexPath.row)
        {
            BUCreatedByCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUCreatedByCell"];
            NSString *key = [self.keysList objectAtIndex:indexPath.row - 1];
            
            cell.matchDescritionLabel.text = [NSString stringWithFormat:@"Created by: %@",[self.datasourceList valueForKey:key]];
            return cell;
        }
        if(self.keysList.count  == indexPath.row)
        {
            BUAboutMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUAboutMeCell"];
            NSString *key = [self.keysList objectAtIndex:indexPath.row - 1];
            
            
            {
                cell.matchTitleLabel.text = [NSString stringWithFormat:@"    %@",key];
            }
            cell.aboutMeDetailTV.text = [NSString stringWithFormat:@"%@",[self.datasourceList valueForKey:key]];
            return cell;
        }
        else{
            BUMatchInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUMatchInfoCell"];
            NSString *key = [self.keysList objectAtIndex:indexPath.row - 1];
            
            
            if([key isEqualToString:@"Honors"] || [key isEqualToString:@"Major"] || [key isEqualToString:@"College"] || [key isEqualToString:@"Year"])
            {
                cell.matchTitleLabel.text = [NSString stringWithFormat:@"            %@",key];
            }
            else
            {
                cell.matchTitleLabel.text = [NSString stringWithFormat:@"    %@",key];
            }
            cell.matchDescritionLabel.text = [NSString stringWithFormat:@"    %@",[self.datasourceList valueForKey:key]];
            return cell;
        }
        
    }
    return nil;
}


-(void)getMatchMakingfortheDay
{
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID
                   };
    
//    parameters = @{@"userid": @"152"
//                   };

    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] matchMakingForTheDaywithParameters:parameters successBlock:^(id response, NSError *error) {
        [self stopActivityIndicator];
        
        if([response isKindOfClass:[NSDictionary class]])
        {
            NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[response valueForKey:@"response"]];
            [message addAttribute:NSFontAttributeName
                            value:[UIFont fontWithName:@"comfortaa" size:15]
                            range:NSMakeRange(0, message.length)];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController setValue:message forKey:@"attributedTitle"];            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
        if(nil != response && 0 < [response count])
        {
            
            self.noProfileImgView.hidden = YES;
            
//            self.datasourceList = respDict ;
            
            self.datasourceList = [[NSMutableDictionary alloc] init];
            [self.keysList removeAllObjects];
            [self.imagesList removeAllObjects];
            NSDictionary *respDict  = [response firstObject];
            {
                
                self.matchBtn.hidden = NO;
                self.passBtn.hidden = NO;
                self.profileStatusImgView.hidden = NO;
                
                NSString *userAction = [respDict valueForKey:@"user_action"];
                
                if([userAction isKindOfClass:[NSNull class]])
                {
                    self.matchBtn.hidden = NO;
                    self.passBtn.hidden = NO;
                    self.profileStatusImgView.hidden = YES;
                }
                else if([userAction isEqualToString:@"Passed"])
                {
                    self.matchBtn.hidden = YES;
                    self.passBtn.hidden = YES;
                    self.profileStatusImgView.hidden = YES;
                    self.profileStatusImgView.image = [UIImage imageNamed:@"btn_passed"];
                }
                else if([userAction isEqualToString:@"Liked"])
                {
                    self.matchBtn.hidden = YES;
                    self.passBtn.hidden = YES;
                    self.profileStatusImgView.hidden = YES;
                    self.profileStatusImgView.image = [UIImage imageNamed:@"btn_liked"];
                }
//                else
                {
                    self.noProfileImgView.hidden = YES;

                    self.keysList = [[NSMutableArray alloc] init];
                    self.matchUserID = [respDict valueForKey:@"userid"];
                    
                    
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"created_by"] forKey:@"created_by"];
                    [self.keysList addObject:@"created_by"];
                    
                    NSString *profileName = [NSString stringWithFormat:@"%@ %@",[respDict valueForKey:@"profile_first_name"],[respDict valueForKey:@"profile_last_name"]];
                    
                    [self.datasourceList setValue:profileName forKey:@"Name"];
                    [self.keysList addObject:@"Name"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"age"] forKey:@"Age"];
                    [self.keysList addObject:@"Age"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"location"] forKey:@"Location"];
                    [self.keysList addObject:@"Location"];
                    
                    
                    NSString *height = [NSString stringWithFormat:@"%@' %@\"",[respDict valueForKey:@"height_feet"],[respDict valueForKey:@"height_inch"]];
                    [self.datasourceList setValue:height forKey:@"Height"];
                    [self.keysList addObject:@"Height"];
                    
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"mother_tongue"] forKey:@"Mother Toungue"];
                    [self.keysList addObject:@"Mother Toungue"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"religion_name"] forKey:@"Religion"];
                    [self.keysList addObject:@"Religion"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"family_origin_name"] forKey:@"Family Origin"];
                    [self.keysList addObject:@"Family Origin"];
                    
                    [self.datasourceList setValue:@"" forKey:@"Specification"];
                    [self.keysList addObject:@"Specification"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"highest_education"] forKey:@"Education"];
                    [self.keysList addObject:@"Education"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"honors"] forKey:@"Honors"];
                    [self.keysList addObject:@"Honors"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"major"] forKey:@"Major"];
                    [self.keysList addObject:@"Major"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"college"] forKey:@"College"];
                    [self.keysList addObject:@"College"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"graduated_year"] forKey:@"Year"];
                    [self.keysList addObject:@"Year"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"employment_status"] forKey:@"Occupation"];
                    [self.keysList addObject:@"Occupation"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"company"] forKey:@"Employer"];
                    [self.keysList addObject:@"Employer"];
                    
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"diet"] forKey:@"Diet"];
                    [self.keysList addObject:@"Diet"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"smoking"] forKey:@"Smoking"];
                    [self.keysList addObject:@"Smoking"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"drinking"] forKey:@"Drinking"];
                    [self.keysList addObject:@"Drinking"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"years_in_usa"] forKey:@"Years in USA"];
                    [self.keysList addObject:@"Years in USA"];
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"legal_status"] forKey:@"Legal Status"];
                    [self.keysList addObject:@"Legal Status"];
                    
                    NSString *userAction = [respDict valueForKey:@"user_action"];
                    
                    if([userAction isKindOfClass:[NSNull class]])
                    {
                        self.matchBtn.hidden = NO;
                        self.passBtn.hidden = NO;
                        self.profileStatusImgView.hidden = YES;
                    }
                    else if([[userAction lowercaseString] isEqualToString:@"connected"])
                    {
                        [self.datasourceList setValue:[respDict valueForKey:@"profile_dob"] forKey:@"Date of Birth"];
                        [self.keysList addObject:@"Date of Birth"];
                        
                        [self.datasourceList setValue:@"" forKey:@"Time of Birth"];
                        [self.keysList addObject:@"Time of Birth"];
                    }
                    
                    
                    [self.datasourceList setValue:[respDict valueForKey:@"about_me"] forKey:@"About Me"];
                    [self.keysList addObject:@"About Me"];
                    
                    
                    
                    
                    
                    
                    if([[respDict valueForKey:@"img_url"] count] > 0)
                    {
                        [self.imagesList addObject:[[respDict valueForKey:@"img_url"] firstObject]];
                    }
                    else
                    {
                        [self.imagesList addObject:@"https://camo.githubusercontent.com/9ba96d7bcaa2481caa19be858a58f180ef236c7b/687474703a2f2f692e696d6775722e636f6d2f7171584a3246442e6a7067"];
                        
                    }

                    
                    
                    
                    
                    self.matchBtn.hidden = NO;
                    self.passBtn.hidden = NO;
                    self.profileStatusImgView.hidden = YES;
                    
                    
                    if([userAction isKindOfClass:[NSNull class]])
                    {
                        self.matchBtn.hidden = NO;
                        self.passBtn.hidden = NO;
                        self.profileStatusImgView.hidden = YES;
                    }
                    else if([userAction isEqualToString:@"Passed"])
                    {
                        self.matchBtn.hidden = YES;
                        self.passBtn.hidden = YES;
                        self.profileStatusImgView.hidden = NO;
                        self.profileStatusImgView.image = [UIImage imageNamed:@"btn_passed"];
                    }
                    else if([userAction isEqualToString:@"Liked"])
                    {
                        self.matchBtn.hidden = YES;
                        self.passBtn.hidden = YES;
                        self.profileStatusImgView.hidden = NO;
                        self.profileStatusImgView.image = [UIImage imageNamed:@"btn_liked"];
                    }
                    else if([[userAction lowercaseString] isEqualToString:@"connected"])
                    {
                        self.matchBtn.hidden = YES;
                        self.passBtn.hidden = YES;
                        self.profileStatusImgView.hidden = NO;
                        self.profileStatusImgView.image = [UIImage imageNamed:@"btn_connected"];
                    }
                    
                    
                    [self.imgScrollerTableView reloadData];
                    return;
                }

                
                
            }
//            NSDictionary *respDict = respDict ;
            
//            [self.imgScrollerTableView reloadData];
        }
        else
        {
            self.flagBtn.hidden = YES;
            NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
            [message addAttribute:NSFontAttributeName
                            value:[UIFont fontWithName:@"comfortaa" size:15]
                            range:NSMakeRange(0, message.length)];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController setValue:message forKey:@"attributedTitle"];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } failureBlock:^(id response, NSError *error) {
        [self stopActivityIndicator];
        
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
        [message addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"comfortaa" size:15]
                        range:NSMakeRange(0, message.length)];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:message forKey:@"attributedTitle"];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
     
     }






-(IBAction)match:(id)sender
{

    NSDictionary *parameters = nil;
    parameters = @{@"passed_by": [BUWebServicesManager sharedManager].userID,
                   @"userid_passed":self.matchUserID,
                   @"action_taken": @"Liked"
                   };
    

    [self startActivityIndicator:YES];
    [self matchWithparameters:parameters];

}
-(void)matchWithparameters:(NSDictionary *)inParams;
{
    
    NSString *baseURL = @"http://dev.thebureauapp.com/admin/pass_like_matches";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self stopActivityIndicator];
         
         if([responseObject valueForKey:@"msg"] != nil && [[responseObject valueForKey:@"msg"] isEqualToString:@"Error"])
         {
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[responseObject valueForKey:@"response"]];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];
             
             [alertController addAction:({
                 UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     NSLog(@"OK");
                     
                 }];
                 
                 action;
             })];
             
             [self presentViewController:alertController  animated:YES completion:nil];
             
         }
         else
         {
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[responseObject valueForKey:@"response"]];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];
             
             [alertController addAction:({
                 UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     NSLog(@"OK");
                     
                     self.matchBtn.hidden = YES;
                     self.passBtn.hidden = YES;
                     self.profileStatusImgView.hidden = NO;
                     self.profileStatusImgView.image = [UIImage imageNamed:@"btn_liked"];
                     
                     [self getGoldDetails];
                 }];
                 
                 action;
             })];
             
             [self presentViewController:alertController  animated:YES completion:nil];
             
         }
         
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self stopActivityIndicator];
         NSLog(@"Error: %@", error);
     }];
}

-(IBAction)pass:(id)sender
{
    

    /*
     http://dev.thebureauapp.com/admin/passMatches
     
     Parameters :
     
     passed_by => user id of the logged in user
     userid_passed => user id of the user that has been passed / skipped
     action_taken => Passed or Liked (Send one of these two options )
*/
    
    NSDictionary *parameters = nil;
    parameters = @{@"passed_by": [BUWebServicesManager sharedManager].userID,
                   @"userid_passed":self.matchUserID,
                   @"action_taken": @"Passed"
                   };
    
    [self startActivityIndicator:YES];

    
    
    NSString *baseURL = @"http://dev.thebureauapp.com/admin/pass_like_matches";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:parameters
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self stopActivityIndicator];
         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[responseObject valueForKey:@"response"]];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         
         [alertController addAction:({
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                 NSLog(@"OK");
                 
                 self.matchBtn.hidden = YES;
                 self.passBtn.hidden = YES;
                 self.profileStatusImgView.hidden = NO;
                 self.profileStatusImgView.image = [UIImage imageNamed:@"btn_passed"];
                 [self getGoldDetails];
             }];
             
             action;
         })];
         
         [self presentViewController:alertController  animated:YES completion:nil];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self stopActivityIndicator];
         NSLog(@"Error: %@", error);
     }];

    
    
}


-(void)getGoldDetails
{
    
    //    [self startActivityIndicator:YES];
    
    
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID
                   };
    
    
    NSString *baseURl = @"http://dev.thebureauapp.com/admin/getGoldAvailable";
    
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:baseURl
                                         successBlock:^(id response, NSError *error) {
                                             
                                             [[NSUserDefaults standardUserDefaults] setInteger:[[response valueForKey:@"available_gold"] intValue] forKey:@"purchasedGold"];
                                             [[NSUserDefaults standardUserDefaults] synchronize];
                                             
                                             
                                             [(BUHomeTabbarController *)[self tabBarController] updateGoldValue:[[response valueForKey:@"available_gold"] integerValue]];
                                         }
                                         failureBlock:^(id response, NSError *error) {
                                             
                                         }];
    
}

-(IBAction)flagUSer:(id)sender

{
    UIAlertController *alertControllerK2 = [UIAlertController
                                            alertControllerWithTitle:@"\u00A0"
                                            message:@"Please provide reason"
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *K2okAction = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     // access text from text field
                                     NSString *text = ((UITextField *)[alertControllerK2.textFields firstObject]).text;
                                     [self flagWithText:text];
                                     
                                 }];
    [alertControllerK2 addTextFieldWithConfigurationHandler:^(UITextField *K2TextField)
     {
         K2TextField.placeholder = NSLocalizedString(@"Please provide reason", @"Please provide reason");
     }];
    [alertControllerK2 addAction:K2okAction];
    [self presentViewController:alertControllerK2 animated:YES completion:nil];
}


-(void)flagWithText:(NSString *)inText
{
    
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                   @"flagged_userid":self.matchUserID,
                   @"reason":inText
                   };
    [self startActivityIndicator:YES];
    
    NSString *baseURl = @"http://dev.thebureauapp.com/admin/flagUsers";
    
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:baseURl
                                         successBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[response valueForKey:@"response"]];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alertController animated:YES completion:nil];
     }
                                         failureBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error!"];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         
         [alertController addAction:({
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                 NSLog(@"OK");
                 
                 self.matchBtn.hidden = YES;
                 self.passBtn.hidden = YES;
                 self.profileStatusImgView.hidden = NO;
                 self.profileStatusImgView.image = [UIImage imageNamed:@"btn_liked"];
             }];
             
             action;
         })];
         
         [self presentViewController:alertController  animated:YES completion:nil];
         
     }];
    
}


@end
