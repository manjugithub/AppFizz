//
//  BUProfileBasicInfoCell.m
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileBasicInfoCell.h"
#import "UIView+FLKAutoLayout.h"

@implementation BUProfileBasicInfoCell

- (void)awakeFromNib {
    // Initialization code
    self.feetMutableArray = [[NSMutableArray alloc]init];
    self.inchesMutableArray = [[NSMutableArray alloc]init];

    self.ageArray = [[NSMutableArray alloc]init];
    self.radiusArray = [[NSMutableArray alloc]init];

    for (int i=0; i < 12; i++) {
        NSString *inches = [NSString stringWithFormat:@"%d\"",i ];
        [self.inchesMutableArray addObject:inches];
    }
    
    for (int i=4; i < 8; i++) {
        NSString *feet = [NSString stringWithFormat:@"%d'",i ];
        [self.feetMutableArray addObject:feet];
    }
    
    
    for (int i=18; i < 55; i++) {
        NSString *inches = [NSString stringWithFormat:@"%d",i ];
        [self.ageArray addObject:inches];
    }
    
    
    for (int i=1; i < 50; i++) {
        NSString *inches = [NSString stringWithFormat:@"%d",i ];
        [self.radiusArray addObject:inches];
    }

    
    _maritalStatusArray = [NSArray arrayWithObjects:@"Never Married",@"Married",@"Divorced",nil];

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

#pragma mark - Gender selection


-(IBAction)setGender:(id)sender
{
    NSString *femaleImgName,*maleImgName,*genderImgName;
    
    if(0 == self.genderSelectionBtn.tag)
    {
        femaleImgName = @"ic_female_s2.png";
        maleImgName = @"ic_male_s1.png";
        genderImgName = @"switch_female.png";
        self.genderSelectionBtn.tag = 1;
    }
    else
    {
        self.genderSelectionBtn.tag = 0;
        femaleImgName = @"ic_female_s1.png";
        maleImgName = @"ic_male_s2.png";
        genderImgName = @"switch_male.png";
    }
    
    self.femaleImgView.image = [UIImage imageNamed:femaleImgName];
    self.maleImgView.image = [UIImage imageNamed:maleImgName];
    [self.genderSelectionBtn setImage:[UIImage imageNamed:genderImgName]
                             forState:UIControlStateNormal];
    
}

#pragma mark -
#pragma mark - Height selection

-(IBAction)setheight {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Height\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIPickerView *picker = [[UIPickerView alloc] init];
    [alertController.view addSubview:picker];
    [picker alignCenterYWithView:alertController.view predicate:@"0.0"];
    [picker alignCenterXWithView:alertController.view predicate:@"0.0"];
    [picker constrainWidth:@"270" ];
    picker.dataSource = self;
    picker.delegate = self ;
    
    
    [picker reloadAllComponents];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
            NSUInteger numComponents = [[picker dataSource] numberOfComponentsInPickerView:picker];
            
            NSMutableString * text = [NSMutableString string];
            for(NSUInteger i = 0; i < numComponents; ++i) {
                NSString *title = [self pickerView:picker titleForRow:[picker selectedRowInComponent:i] forComponent:i];
                [text appendFormat:@"%@", title];
            }
            
            NSLog(@"%@", text);
            self.heighTextField.text = text;
        }];
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"cancel");
        }];
        action;
    })];
    [self.parentVC presentViewController:alertController  animated:YES completion:nil];
}

#pragma mark- Picker View Delegate
#pragma mark -
#pragma mark - Age selection

-(IBAction)setAge {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Age\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.tag = 100;
    [alertController.view addSubview:picker];
    [picker alignCenterYWithView:alertController.view predicate:@"0.0"];
    [picker alignCenterXWithView:alertController.view predicate:@"0.0"];
    [picker constrainWidth:@"270" ];
    picker.dataSource = self;
    picker.delegate = self ;
    
    
    [picker reloadAllComponents];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
            NSUInteger numComponents = [[picker dataSource] numberOfComponentsInPickerView:picker];
            
            NSMutableString * text = [NSMutableString string];
            for(NSUInteger i = 0; i < numComponents; ++i) {
                NSString *title = [self pickerView:picker titleForRow:[picker selectedRowInComponent:i] forComponent:i];
                [text appendFormat:@"%@", title];
            }
            
            NSLog(@"%@", text);
            self.ageLabel.text = [NSString stringWithFormat:@"%@ years",text];
        }];
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"cancel");
        }];
        action;
    })];
    [self.parentVC presentViewController:alertController  animated:YES completion:nil];
}


#pragma mark -
#pragma mark - Radius selection

-(IBAction)setRadius {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location Radius\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.tag = 101;
    [alertController.view addSubview:picker];
    [picker alignCenterYWithView:alertController.view predicate:@"0.0"];
    [picker alignCenterXWithView:alertController.view predicate:@"0.0"];
    [picker constrainWidth:@"270" ];
    picker.dataSource = self;
    picker.delegate = self ;
    
    
    [picker reloadAllComponents];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            
            NSUInteger numComponents = [[picker dataSource] numberOfComponentsInPickerView:picker];
            
            NSMutableString * text = [NSMutableString string];
            for(NSUInteger i = 0; i < numComponents; ++i) {
                
                NSString *title = [self pickerView:picker titleForRow:[picker selectedRowInComponent:i] forComponent:i];
                [text appendFormat:@"%@", title];
            }
            
            NSLog(@"%@", text);
            self.radiusLabel.text = [NSString stringWithFormat:@"%@ miles",text];
        }];
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"cancel");
        }];
        action;
    })];
    [self.parentVC presentViewController:alertController  animated:YES completion:nil];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    
    if(pickerView.tag == 100)
    {
    }
    else if(pickerView.tag == 101)
    {
    }
    else
    {
        
        if (component == 1)
        {
            self.inchStr = [_inchesMutableArray objectAtIndex:row];
            
        }
        else
        {
            self.feetStr = [_feetMutableArray objectAtIndex:row];
        }
    }
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component
{
    
    if(pickerView.tag == 100)
    {
        return [self.ageArray objectAtIndex:row];
    }
    else if(pickerView.tag == 101)
    {
        return [self.radiusArray objectAtIndex:row];
    }
    else
    {
        if (component ==1) {
            return [_inchesMutableArray objectAtIndex:row];
        }
        else
        {
            
            return [_feetMutableArray objectAtIndex:row];
        }
    }
}


#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if(pickerView.tag == 100)
    {
        return 1;
    }
    else if(pickerView.tag == 101)
    {
        return 1;
    }
    return 2;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    if(pickerView.tag == 100)
    {
        return [self.ageArray count];
    }
    else if(pickerView.tag == 101)
    {
        return [self.radiusArray count];
    }
    else
    {
        if (component ==1) {
            return [_inchesMutableArray count];
        }
        else
        {
            
            return [_feetMutableArray count];
        }
    }
}


#pragma mark - Account selection

-(IBAction)selectMarital:(id)sender
{
    
    [self.parentVC.view endEditing:YES];
    
    UIActionSheet *acSheet = [[UIActionSheet alloc] initWithTitle:@"Select Marital Status" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    acSheet.tag = 100;
    
    for (NSString *str in self.maritalStatusArray)
    {
        [acSheet addButtonWithTitle:str];
    }
    
    [acSheet showInView:self.parentVC.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
            self.maritalStatusTF.text = self.maritalStatusArray[buttonIndex - 1];
    }
}


-(void)setDatasource:(NSMutableDictionary *)inBasicInfoDict
{
    
    self.nameTF.text = [inBasicInfoDict valueForKey:@"name"];
    
    self.ageLabel.text = [inBasicInfoDict valueForKey:@"dob"];
    
    self.maritalStatusTF.text = [inBasicInfoDict valueForKey:@"gender"];
    self.radiusLabel.text = [inBasicInfoDict valueForKey:@"location"];
    
    self.heighTextField.text = [NSString stringWithFormat:@"%@' %@''",[inBasicInfoDict valueForKey:@"height_feet"],[inBasicInfoDict valueForKey:@"height_inch"]];
    self.maritalStatusTF.text = [inBasicInfoDict valueForKey:@"maritial_status"];
    
}


-(void)updateProfile
{
    [self.parentVC startActivityIndicator:YES];
    
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                   @"gender": @"Male",
                   @"height_feet": self.feetStr,
                   @"height_inch":self.inchStr,
                   @"maritial_status": self.maritalStatusTF.text,
                   @"location": self.radiusLabel.text,
                   
                   };

    NSString *baseURl = @"http://app.thebureauapp.com/admin/update_profile_step1";
    [[BUWebServicesManager sharedManager] queryServer:parameters
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
@end
