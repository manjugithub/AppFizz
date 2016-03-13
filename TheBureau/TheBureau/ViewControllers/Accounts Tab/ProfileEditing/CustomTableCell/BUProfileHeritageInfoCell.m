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

-(void)setDatasource:(NSMutableDictionary *)inBasicInfoDict
{
    
}


-(void)showPickerWithDataSource:(id)inResult
{
    [self.parentVC stopActivityIndicator];
    
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"CustomPicker" bundle:nil];
    self.customPickerView = [sb instantiateViewControllerWithIdentifier:@"PWCustomPickerView"];
    
    self.customPickerView.pickerDataSource = inResult;
    self.customPickerView.selectedHeritage = self.heritageList;
    [self.customPickerView showCusptomPickeWithDelegate:self];
    self.customPickerView.titleLabel.text = @"Heritage";
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
//{
//    [self.parentVC startActivityIndicator:YES];
//
//    NSDictionary *parameters = nil;
//    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
//                   @"gender": @"Male",
//                   @"height_feet": self.feetStr,
//                   @"height_inch":self.inchStr,
//                   @"maritial_status": self.maritalStatusTF.text,
//                   @"location": self.radiusLabel.text,
//
//                   };
//
//    NSString *baseURl = @"http://app.thebureauapp.com/admin/update_profile_step1";
//    [[BUWebServicesManager sharedManager] queryServer:parameters
//                                              baseURL:baseURl
//                                         successBlock:^(id response, NSError *error)
//     {
//         [self.parentVC stopActivityIndicator];
//
//     }
//                                         failureBlock:^(id response, NSError *error) {
//                                             [self.parentVC stopActivityIndicator];
//                                         }
//     ];
//}


@end
