//
//  BUProfileSocialHabitsInfoCell.m
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileSocialHabitsInfoCell.h"
#import "BUConstants.h"
@implementation BUProfileSocialHabitsInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)setDatasource:(NSMutableDictionary *)inBasicInfoDict
{
    
}


#pragma mark -
#pragma mark - Social habits

-(IBAction)setDiet:(id)sender{
    
    UIButton *setYearBtn = (UIButton *)sender;
    
    if (setYearBtn.tag == ButtonTypeVegetarian) {
        
        [_vegetarianBtn setSelected:YES];
        [_eegetarianBtn setSelected:NO];
        [_nonVegetarianBtn setSelected:NO];
        [_veganBtn setSelected:NO];
        
    }
    else if (setYearBtn.tag == ButtonTypeEegetarian){
        
        [_vegetarianBtn setSelected:NO];
        [_eegetarianBtn setSelected:YES];
        [_nonVegetarianBtn setSelected:NO];
        [_veganBtn setSelected:NO];
        
    }
    else if (setYearBtn.tag == ButtonTypeNonvegetarian){
        
        [_vegetarianBtn setSelected:NO];
        [_eegetarianBtn setSelected:NO];
        [_nonVegetarianBtn setSelected:YES];
        [_veganBtn setSelected:NO];
        
    }
    else{
        [_vegetarianBtn setSelected:NO];
        [_eegetarianBtn setSelected:NO];
        [_nonVegetarianBtn setSelected:NO];
        [_veganBtn setSelected:YES];
        
        
    }
    
    
    
}

-(IBAction)setDrinking:(id)sender
{
    NSString *switchBtnStr;
    
    if(0 == self.drinkingSelectionBtn.tag)
    {
        _sociallyLabel.textColor = [UIColor lightGrayColor];
        _neverLabel.textColor = [UIColor blackColor];
        
        switchBtnStr = @"switch_ON";
        self.drinkingSelectionBtn.tag = 1;
    }
    else
    {
        self.drinkingSelectionBtn.tag = 0;
        _sociallyLabel.textColor = [UIColor blackColor];
        _neverLabel.textColor = [UIColor lightGrayColor];
        
        switchBtnStr = @"switch_OFF";
    }
    
    [self.drinkingSelectionBtn setBackgroundImage:[UIImage imageNamed:switchBtnStr]
                                         forState:UIControlStateNormal];
    
}

-(IBAction)setSmoking:(id)sender
{
    NSString *switchBtnStr;
    
    if(0 == self.smokingSelectionBtn.tag)
    {
        
        _yesLabel.textColor = [UIColor blackColor];
        _noLabel.textColor = [UIColor lightGrayColor];
        
        switchBtnStr = @"switch_ON";
        self.smokingSelectionBtn.tag = 1;
    }
    else
    {
        self.smokingSelectionBtn.tag = 0;
        _yesLabel.textColor = [UIColor lightGrayColor];
        _noLabel.textColor = [UIColor blackColor];
        
        switchBtnStr = @"switch_OFF";
    }
    
    [self.smokingSelectionBtn setBackgroundImage:[UIImage imageNamed:switchBtnStr]
                                        forState:UIControlStateNormal];
    
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
