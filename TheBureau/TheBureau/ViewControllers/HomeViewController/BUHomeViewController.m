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
#import "AFHTTPSessionManager.h"
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

@end

@implementation BUHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.imagesList = [NSMutableArray arrayWithObjects:@"1",@"5",@"4",@"3",@"2", nil];
    self.datasourceList = nil;
    // Do any additional setup after loading the view.
    
    self.imgScrollerTableView.hidden = YES;

    self.profileStatusImgView.hidden = YES;

    [self getGoldDetails];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;    
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
    return nil;
}


-(void)getMatchMakingfortheDay
{
    NSDictionary *parameters = nil;
//    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID
//                   };
    
    parameters = @{@"userid": @"152"
                   };

    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager] matchMakingForTheDaywithParameters:parameters successBlock:^(id response, NSError *error) {
        [self stopActivityIndicator];
        
        if([response isKindOfClass:[NSDictionary class]])
        {
            [self stopActivityIndicator];
            NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"No matches found yet"];
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
            
//            self.datasourceList = [response lastObject];
            
            self.datasourceList = [[NSMutableDictionary alloc] init];
            
            NSDictionary *respDict = [response lastObject];
            
            self.keysList = [[NSMutableArray alloc] init];
            self.matchUserID = [respDict valueForKey:@"userid"];
            NSString *profileName = [NSString stringWithFormat:@"%@ %@",[respDict valueForKey:@"profile_first_name"],[respDict valueForKey:@"profile_last_name"]];
            
            [self.datasourceList setValue:profileName forKey:@"Name"];
            [self.keysList addObject:@"Name"];

            [self.datasourceList setValue:[respDict valueForKey:@"age"] forKey:@"Age"];
            [self.keysList addObject:@"Age"];
            
            [self.datasourceList setValue:[respDict valueForKey:@"profile_gender"] forKey:@"Gender"];
            [self.keysList addObject:@"Gender"];
            
            [self.datasourceList setValue:[respDict valueForKey:@"location"] forKey:@"Location"];
            [self.keysList addObject:@"Location"];
            

            NSString *height = [NSString stringWithFormat:@"%@' %@\"",[respDict valueForKey:@"height_feet"],[respDict valueForKey:@"height_inch"]];
            [self.datasourceList setValue:height forKey:@"Height"];
            [self.keysList addObject:@"Height"];
            
            
            [self.datasourceList setValue:[respDict valueForKey:@"profile_dob"] forKey:@"Date of Birth"];
            [self.keysList addObject:@"Date of Birth"];
            

            [self.datasourceList setValue:[respDict valueForKey:@"mother_tongue"] forKey:@"Mother Toungue"];
            [self.keysList addObject:@"Mother Toungue"];
            
            [self.datasourceList setValue:[respDict valueForKey:@"religion_name"] forKey:@"Religion"];
            [self.keysList addObject:@"Religion"];
            
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
            
            
            
            
            
            
            if([[[response lastObject]valueForKey:@"img_url"] isKindOfClass:[NSDictionary class]])
            {
                self.imagesList = [[NSMutableArray alloc] initWithArray:[[[response lastObject]valueForKey:@"img_url"] allValues]];
            }
            else
            {
                self.imagesList = [[NSMutableArray alloc] initWithArray:[[response lastObject]valueForKey:@"img_url"]];
                
            }

            
            NSString *userAction = [[response lastObject]valueForKey:@"user_action"];
            
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
            [self.imgScrollerTableView reloadData];
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
    parameters = @{@"userid1": [BUWebServicesManager sharedManager].userID,
                   @"userid2": self.matchUserID
                   };
    
    [self startActivityIndicator:YES];
    [self matchWithparameters:parameters];

}
-(void)matchWithparameters:(NSDictionary *)inParams;
{
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/isMatched";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self stopActivityIndicator];
         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Your interest is sent!"];
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
     http://app.thebureauapp.com/admin/passMatches
     
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

    
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/passMatches";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:parameters
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self stopActivityIndicator];
         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"You have passed the profile!"];
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
    
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID
                   };
    
    
    NSString *baseURl = @"http://app.thebureauapp.com/admin/getGoldAvailable";
    
    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:baseURl
                                         successBlock:^(id response, NSError *error) {
                                             [[NSUserDefaults standardUserDefaults] setInteger:[[response valueForKey:@"available_gold"] intValue] forKey:@"purchasedGold"];
                                             [[NSUserDefaults standardUserDefaults] synchronize];
                                         }
                                         failureBlock:^(id response, NSError *error) {
                                             
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
