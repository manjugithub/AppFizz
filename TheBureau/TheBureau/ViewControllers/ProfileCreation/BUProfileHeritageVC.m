
//
//  BUProfileHeritageVC.m
//  TheBureau
//
//  Created by Manjunath on 25/01/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileHeritageVC.h"
#import "BUProfileOccupationVC.h"
#import "BUProfileDietVC.h"

@interface BUProfileHeritageVC ()
@property(nonatomic, strong) PWCustomPickerView *customPickerView;
@property(nonatomic, strong) NSString *religionID,*famliyID,*specificationID,*motherToungueID;

@property(nonatomic, strong) IBOutlet UITextField *religionTF,*motherToungueTF,*specificationTF,*gothraTF,*familyOriginTF;

@property(nonatomic) eHeritageList heritageList;
@property(nonatomic, assign) BOOL isUpdatingProfile;
@end

@implementation BUProfileHeritageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Heritage";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:self action:@selector(viewPopOnBackButton)];
    
    self.gothraTF.enabled = YES;
    self.navigationItem.leftBarButtonItem = backButton;
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


-(void)showPickerWithDataSource:(id)inResult
{
    [self stopActivityIndicator];
    
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"CustomPicker" bundle:nil];
    self.customPickerView = [sb instantiateViewControllerWithIdentifier:@"PWCustomPickerView"];
    
    self.customPickerView.pickerDataSource = inResult;
    self.customPickerView.selectedHeritage = self.heritageList;
    [self.customPickerView showCusptomPickeWithDelegate:self];
    self.customPickerView.titleLabel.text = @"Physical Activity";
}



-(IBAction)getReligion:(id)sender
{
    NSDictionary *parameters = nil;
    [self startActivityIndicator:YES];
    self.heritageList = eReligionList;
    [[BUWebServicesManager sharedManager] getReligionListwithParameters:parameters successBlock:^(id response, NSError *error) {
        [self showPickerWithDataSource:response];
    } failureBlock:^(id response, NSError *error) {
        [self showFailureAlert];

    }];
}


-(IBAction)getMotherToungue:(id)sender
{
    NSDictionary *parameters = nil;
    [self startActivityIndicator:YES];
    self.heritageList = eMotherToungueList;
    [[BUWebServicesManager sharedManager] getMotherTongueListwithParameters:parameters successBlock:^(id response, NSError *error) {
        [self showPickerWithDataSource:response];
    } failureBlock:^(id response, NSError *error) {
        [self showFailureAlert];

    }];
}

-(IBAction)getSpecificationList:(id)sender
{
    
    
    if(nil == self.famliyID)
    {
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Please Select Family Origin"];
        [message addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"comfortaa" size:15]
                        range:NSMakeRange(0, message.length)];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:message forKey:@"attributedTitle"];
        [alertController addAction:({
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            action;
        })];
        [self.navigationController presentViewController:alertController  animated:YES completion:nil];

    }
    else
    {
        self.heritageList = eSpecificationList;
        NSDictionary *parameters = nil;
        parameters = @{@"family_origin_id": self.famliyID};
        [self startActivityIndicator:YES];
        [[BUWebServicesManager sharedManager] getSpecificationListwithParameters:parameters successBlock:^(id response, NSError *error) {
            [self showPickerWithDataSource:response];

        } failureBlock:^(id response, NSError *error) {
            [self showFailureAlert];

        }];
    }
}

-(IBAction)getFamilyOrigin:(id)sender
{
    if(nil == self.religionID)
    {
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Please Select Relegion"];
        [message addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"comfortaa" size:15]
                        range:NSMakeRange(0, message.length)];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:message forKey:@"attributedTitle"];
        [alertController addAction:({
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            action;
        })];
        [self.navigationController presentViewController:alertController  animated:YES completion:nil];

    }
    else
    {
        self.heritageList = eFamilyOriginList;
        NSDictionary *parameters = nil;
        parameters = @{@"religion_id": self.religionID};
        [self startActivityIndicator:YES];
        [[BUWebServicesManager sharedManager] getFamilyOriginListwithParameters:parameters successBlock:^(id response, NSError *error) {
            [self showPickerWithDataSource:response];

        } failureBlock:^(id response, NSError *error) {
            [self showFailureAlert];

        }];
    }
}

-(IBAction)continueClicked:(id)sender
{
    NSDictionary *parameters = nil;
    /*
     
     3. API for screen 4b_profile_setup2
     
     API  to  Call
     http://app.thebureauapp.com/admin/update_profile_step3
     
     Parameter
     userid => user id of user
     religion_id =>religion id
     mother_tongue_id => mother tongue id
     family_origin_id => family origin id
     specification_id => specification id
     gothra => gothra(text) 
     
     */
    
    if(self.religionID == nil ||
       self.motherToungueID == nil ||
       self.famliyID == nil ||
       self.specificationID == nil ||
       [self.gothraTF.text isEqualToString:@""])
    {
        return;
    }
    
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                   @"religion_id":self.religionID,
                   @"mother_tongue_id":self.motherToungueID,
                   @"family_origin_id":self.famliyID,
                   @"specification_id":self.specificationID,
                   @"gothra":self.gothraTF.text
                   };
    
    [self startActivityIndicator:YES];
    self.isUpdatingProfile = YES;
    [[BUWebServicesManager sharedManager] updateProfileHeritagewithParameters:parameters
                                                                 successBlock:^(id inResult, NSError *error)
     {
         [self stopActivityIndicator];

         self.isUpdatingProfile = NO;
         if(YES == [[inResult valueForKey:@"msg"] isEqualToString:@"Success"])
         {
             UIStoryboard *sb =[UIStoryboard storyboardWithName:@"ProfileCreation" bundle:nil];
             BUProfileDietVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUProfileDietVC"];
             [self.navigationController pushViewController:vc animated:YES];
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
                                                                 failureBlock:^(id response, NSError *error) {
                                                                     [self stopActivityIndicator];

                                                                     [self showFailureAlert];
    }];
}


- (void)didItemSelected:(NSMutableDictionary *)inSelectedRow
{
    switch (self.heritageList)
    {
        case eReligionList:
        {
            self.religionTF.text = [inSelectedRow valueForKey:@"religion_name"];
            self.religionID = [inSelectedRow valueForKey:@"religion_id"];
            break;
        }
        case eMotherToungueList:
        {
            self.motherToungueTF.text = [inSelectedRow valueForKey:@"mother_tongue"];
            self.motherToungueID = [inSelectedRow valueForKey:@"mother_tongue_id"];
            break;
        }
        case eFamilyOriginList:
        {
            
            self.familyOriginTF.text = [inSelectedRow valueForKey:@"family_origin_name"];
            self.famliyID = [inSelectedRow valueForKey:@"family_origin_id"];
            break;
        }
        case eSpecificationList:
        {
            self.specificationTF.text = [inSelectedRow valueForKey:@"specification_name"];
            self.specificationID = [inSelectedRow valueForKey:@"specification_id"];
            break;
        }
        case eGothraList:
        {
            
            break;
        }
            
        default:
            break;
    }
}


-(void)viewPopOnBackButton {
    
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Do you wish to leave this appication? Your Information has not been saved"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController setValue:message forKey:@"attributedTitle"];
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"cancel");
            //NSLog(@"%@",picker.date);
            
        }];
        
        action;
    })];
    
    [self presentViewController:alertController  animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


@end
