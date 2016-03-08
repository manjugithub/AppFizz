//
//  BUProfileHeritageInfoCell.m
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileHeritageInfoCell.h"

@implementation BUProfileHeritageInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)showPickerWithDataSource:(id)inResult
{
    [self.parentVC stopActivityIndicator];
    
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"CustomPicker" bundle:nil];
    self.customPickerView = [sb instantiateViewControllerWithIdentifier:@"PWCustomPickerView"];
    
    self.customPickerView.pickerDataSource = inResult;
    self.customPickerView.selectedHeritage = self.heritageList;
    [self.customPickerView showCusptomPickeWithDelegate:self];
    self.customPickerView.titleLabel.text = @"Physical Activity";
}

-(void)showFailureAlert
{
    [self.parentVC startActivityIndicator:YES];
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self.parentVC presentViewController:alertController animated:YES completion:nil];
}

-(IBAction)getReligion:(id)sender
{
    NSDictionary *parameters = nil;
    [self.parentVC startActivityIndicator:YES];
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
    [self.parentVC startActivityIndicator:YES];
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

        
        if(nil != self.parentVC)
            [self.parentVC.navigationController presentViewController:alertController  animated:YES completion:nil];
        else
            [self.prefVC.navigationController presentViewController:alertController  animated:YES completion:nil];

    }
    else
    {
        self.heritageList = eSpecificationList;
        NSDictionary *parameters = nil;
        parameters = @{@"family_origin_id": self.famliyID};
        [self.parentVC startActivityIndicator:YES];
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
        
        if(nil != self.parentVC)
            [self.parentVC.navigationController presentViewController:alertController  animated:YES completion:nil];
        else
            [self.prefVC.navigationController presentViewController:alertController  animated:YES completion:nil];

    }
    else
    {
        self.heritageList = eFamilyOriginList;
        NSDictionary *parameters = nil;
        parameters = @{@"religion_id": self.religionID};
        [self.parentVC startActivityIndicator:YES];
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
    
    [self.parentVC startActivityIndicator:YES];
    self.isUpdatingProfile = YES;
    [[BUWebServicesManager sharedManager] updateProfileHeritagewithParameters:parameters
                                                                 successBlock:^(id inResult, NSError *error)
     {
         self.isUpdatingProfile = NO;
         if(YES == [[inResult valueForKey:@"msg"] isEqualToString:@"Success"])
         {
             NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Updated Successfully"];
             [message addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"comfortaa" size:15]
                             range:NSMakeRange(0, message.length)];
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
             [alertController setValue:message forKey:@"attributedTitle"];
             [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
             [self.parentVC presentViewController:alertController animated:YES completion:nil];
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
             [self.parentVC presentViewController:alertController animated:YES completion:nil];
         }
     }
                                                                 failureBlock:^(id response, NSError *error) {
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
    
    
    NSDictionary *prefDict1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"Preferences"];
    
    NSMutableDictionary *preferenceDict = [[NSMutableDictionary alloc]initWithDictionary:prefDict1];
    
    [preferenceDict setValue:self.religionID forKey:@"religion_id"];
    [preferenceDict setValue:self.motherToungueID forKey:@"mother_tongue_id"];
    [preferenceDict setValue:self.famliyID forKey:@"family_origin_id"];

    [[NSUserDefaults standardUserDefaults] setValue:preferenceDict forKey:@"Preferences"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self endEditing:YES];
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)updateProfile
{
    
}

/*
 
 {
 [self.parentVC startActivityIndicator:YES];
 
 /*
 
 userid => User's ID
 first_name => First name of account holder
 last_name => Last name of account holder
 dob => date of birth (dd-mm-yyyy)
 gender => Gender - enum('Male', 'Female')
 phone_number => phone number of account holder
 email => email of account holder
 
 1. API for screen 4_profile_setup (Of the mockup screens)
 
 http://app.thebureauapp.com/admin/update_profile_step1
 
 Parameters to be sent to this API :
 
 userid => user id of user
 profile_for => profile for eg. self, brother, sister =>One of these values
 profile_first_name => first name for profile
 profile_last_name => last name for profile
 
 API to view the above details for a user :
 
 http://app.thebureauapp.com/admin/view_profile_step1
 
 Parameters to be sent :
 userid => user id of user
 
 As an output it will return all the fields (profile_for, profile_first_name, profile_last_name) with value in json format.
 
 2. API for screen 4a_profile_setup1 (Of the mockup screens)
 
 http://app.thebureauapp.com/admin/update_profile_step2
 
 Parameters to be sent :
 
 userid => user id of user
 profile_gender =>gender (Male,Female)
 profile_dob =>date of birth (dd-mm-yy format)
 country_residing => country residing (India, America) =>one of these values
 current_zip_code => current zip code
 height_feet => person height in feet
 height_inch => person height in inch
 maritial_status => marital status
 
 
 API to  view the above  :
 http://app.thebureauapp.com/admin/view_profile_step2
 
 Parameter => userid => user id of user
 
 * as an output it will return all the fields (profile_gender, profile_dob, country_residing, current_zip_code, height_feet, height_inch, maritial_status) with value.
 
 
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
 
 API to  view the above details for a user
 
 http://app.thebureauapp.com/admin/view_profile_step3
 
 Parameter
 userid => user id of user
 
 * as an output it will return all the fields (religion_id, mother_tongue_id, family_origin_id, specification_id, gothra) with value.
 
 
 4. API for screen 4c_profile_setup3
 
 API to  upload :
 http://app.thebureauapp.com/admin/update_profile_step4
 
 Parameter
 userid => user id of user
 diet => e.g. Vegetarian, Eggetarian, Non Vegetarian
 drinking => e.g. Socially, Never
 smoking => e.g. Yes, No
 
 API to  view the above
 http://app.thebureauapp.com/admin/view_profile_step4
 
 Parameter
 userid => user id of user
 
 * as an output it will return all the fields (diet, drinking, smoking) with value.
 
 5. API for screen 4d_profile_setup4
 
 API to  upload
 http://app.thebureauapp.com/admin/update_profile_step5
 
 Parameter
 
 userid => user id of user
 employment_status=> e.g. Employed, Unemployed
 position_title => position title
 company => company name
 highest_education=> e.g. Doctorate, Masters
 honors=> honors (text)
 major=> major
 college=> college
 graduated_year=> graduated year
 
 API to view the above  :
 
 http://app.thebureauapp.com/admin/view_profile_step5
 
 Parameter
 userid => user id of user
 
 * as an output it will return all the fields (employment_status,position_title,company,highest_education,honors,major,college,graduated_year) with value.
 
 6. API for screen 4e_profile_setup5
 
 API to call
 
 http://app.thebureauapp.com/admin/update_profile_step6
 
 Parameters
 
 userid => user id of user
 years_in_usa => e.g. 0 - 2, 2 - 6
 legal_status => e.g. Citizen/Green Card, Greencard
 
 * /
 
 
 
 //    gender => Gender - enum('Male', 'Female')
 //    userid => user id of user
 //    profile_first_name => first name for profile
 //        profile_last_name => last name for profile
 //            height_feet => person height in feet
 //            height_inch => person height in inch
 //            maritial_status => marital status
 
 
 NSDictionary *parameters = nil;
 parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
 @"gender": [BUWebServicesManager sharedManager].userID,
 @"height_feet": self.feetStr,
 @"height_inch":self.inchStr,
 @"maritial_status": self.maritalStatusTF.text,
 @"location": self.radiusLabel.text,
 
 };
 
 NSString *baseURl = @"http://app.thebureauapp.com/admin/update_profile_step1";
 [[BUWebServicesManager sharedManager] queryServer:nil
 baseURL:baseURl
 successBlock:^(id response, NSError *error)
 {
 [self.parentVC stopActivityIndicator];
 
 }
 failureBlock:^(id response, NSError *error) {
 [self.parentVC stopActivityIndicator];
 }
 ];
 }
 
 */
@end
