//
//  BUPrefHeritageCell.m
//  TheBureau
//
//  Created by Manjunath on 18/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUPrefHeritageCell.h"
#import "UIView+FLKAutoLayout.h"


@implementation BUPrefHeritageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    if(pickerView.tag == 0)
        return [self.religionList count];
    else if(pickerView.tag == 1)
        return [self.motherToungueList count];
    else
    return [self.famliyList count];
    
}

#pragma mark- Picker View Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag == 0)
        return [self.religionList objectAtIndex:row];
    else if(pickerView.tag == 1)
        return [self.motherToungueList objectAtIndex:row];
    else
    return [self.famliyList objectAtIndex:row];
}




-(IBAction)showReligionList:(id)inSender
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Selected Relegion\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.tag = 0;
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
        }];
        action;
    })];
    [self.prefVC presentViewController:alertController  animated:YES completion:nil];
    
}

-(IBAction)showMotherToungueList:(id)inSender
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Selected Mother toungue\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.tag = 1;
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
        }];
        action;
    })];
    [self.prefVC presentViewController:alertController  animated:YES completion:nil];
    
}

-(IBAction)showFamilyOriginList:(id)inSender
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Selected Family origin\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.tag = 2;
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
        }];
        action;
    })];
    [self.prefVC presentViewController:alertController  animated:YES completion:nil];
    
}

-(void)showPickerWithDataSource:(id)inResult
{
    [self.prefVC stopActivityIndicator];
    
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"CustomPicker" bundle:nil];
    self.customPickerView = [sb instantiateViewControllerWithIdentifier:@"PWCustomPickerView"];
    
    self.customPickerView.pickerDataSource = inResult;
    self.customPickerView.allowMultipleSelection = YES;
    self.customPickerView.selectedHeritage = self.heritageList;
    [self.customPickerView showCusptomPickeWithDelegate:self];
    self.customPickerView.titleLabel.text = @"Heritage";
}

-(void)showFailureAlert
{
    [self.prefVC startActivityIndicator:YES];
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self.prefVC presentViewController:alertController animated:YES completion:nil];
}

-(IBAction)getReligion:(id)sender
{
    NSDictionary *parameters = nil;
    [self.prefVC startActivityIndicator:YES];
    self.heritageList = eReligionList;
    [[BUWebServicesManager sharedManager] getReligionListwithParameters:parameters successBlock:^(id response, NSError *error)
     {
         self.religionTF.text = @"";
         [self.religionIDList removeAllObjects];
         [self.religionList removeAllObjects];

         
         self.familyOriginTF.text = @"";
         [self.famliyIDList removeAllObjects];
         [self.famliyList removeAllObjects];

         
         [self.heritageDict setValue:self.religionIDList forKey:@"religion_id"];
         [self.heritageDict setValue:self.famliyIDList forKey:@"family_origin_id"];

         
        [self showPickerWithDataSource:response];
    } failureBlock:^(id response, NSError *error) {
        [self showFailureAlert];
        
    }];
}


-(IBAction)getMotherToungue:(id)sender
{
    NSDictionary *parameters = nil;
    [self.prefVC startActivityIndicator:YES];
    self.heritageList = eMotherToungueList;
    [[BUWebServicesManager sharedManager] getMotherTongueListwithParameters:parameters successBlock:^(id response, NSError *error) {
        [self showPickerWithDataSource:response];
        self.familyOriginTF.text = @"";
        [self.famliyIDList removeAllObjects];
        [self.famliyList removeAllObjects];
        
        
        [self.heritageDict setValue:self.famliyIDList forKey:@"family_origin_id"];
    } failureBlock:^(id response, NSError *error) {
        [self showFailureAlert];
        
    }];
}


-(IBAction)getFamilyOrigin:(id)sender
{
    if(nil == self.religionIDList || self.religionIDList.count == 0)
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
        
            [self.prefVC.navigationController presentViewController:alertController  animated:YES completion:nil];
    }
    else
    {
        self.heritageList = eFamilyOriginList;
        NSDictionary *parameters = nil;
        parameters = @{@"religionids": self.religionIDList};
        [self.prefVC startActivityIndicator:YES];
        [[BUWebServicesManager sharedManager] getMultipleFamilyOriginListwithParameters:parameters successBlock:^(id response, NSError *error) {
            [self showPickerWithDataSource:response];
            
        } failureBlock:^(id response, NSError *error) {
            [self showFailureAlert];
            
        }];
    }
}

- (void)didItemDeselectedSelected:(NSMutableDictionary *)inSelectedRow;
{
    
    switch (self.heritageList)
    {
        case eReligionList:
        {
            self.religionTF.text = [NSString stringWithFormat:@"%@",[self.religionTF.text stringByReplacingOccurrencesOfString:[inSelectedRow valueForKey:@"religion_name"] withString:@""]];
            [self.religionIDList removeObject:[inSelectedRow valueForKey:@"religion_id"]];
            [self.religionList removeObject:[inSelectedRow valueForKey:@"religion_name"]];

            break;
        }
        case eMotherToungueList:
        {
            self.motherToungueTF.text = [NSString stringWithFormat:@"%@",[self.motherToungueTF.text stringByReplacingOccurrencesOfString:[inSelectedRow valueForKey:@"mother_tongue"] withString:@""]];
            
            [self.motherToungueIDList removeObject:[inSelectedRow valueForKey:@"mother_tongue_id"]];
            [self.motherToungueList removeObject:[inSelectedRow valueForKey:@"mother_tongue"]];
            break;
        }
        case eFamilyOriginList:
        {
            
            self.familyOriginTF.text = [NSString stringWithFormat:@"%@",[self.familyOriginTF.text stringByReplacingOccurrencesOfString:[inSelectedRow valueForKey:@"family_origin_name"] withString:@""]];
            
            [self.famliyIDList removeObject:[inSelectedRow valueForKey:@"family_origin_id"]];
            [self.famliyList removeObject:[inSelectedRow valueForKey:@"family_origin_name"]];
            break;
        }
        default:
            break;
    }
    
    [self.heritageDict setValue:self.religionIDList forKey:@"religion_id"];
    [self.heritageDict setValue:self.motherToungueIDList forKey:@"mother_tongue_id"];
    [self.heritageDict setValue:self.famliyIDList forKey:@"family_origin_id"];
    
}

- (void)didItemSelected:(NSMutableDictionary *)inSelectedRow
{
    
    switch (self.heritageList)
    {
        case eReligionList:
        {
            self.religionTF.text = [NSString stringWithFormat:@"%@  %@",self.religionTF.text,[inSelectedRow valueForKey:@"religion_name"]];
            [self.religionIDList addObject:[inSelectedRow valueForKey:@"religion_id"]];
            [self.religionList addObject:[inSelectedRow valueForKey:@"religion_name"]];
            
            break;
        }
        case eMotherToungueList:
        {
            self.motherToungueTF.text = [NSString stringWithFormat:@"%@   %@",self.motherToungueTF.text,[inSelectedRow valueForKey:@"mother_tongue"]];
            [self.motherToungueIDList addObject:[inSelectedRow valueForKey:@"mother_tongue_id"]];
            [self.motherToungueList addObject:[inSelectedRow valueForKey:@"mother_tongue"]];
            break;
        }
        case eFamilyOriginList:
        {
            
            self.familyOriginTF.text = [NSString stringWithFormat:@"%@   %@",self.familyOriginTF.text,[inSelectedRow valueForKey:@"family_origin_name"]];
            [self.famliyIDList addObject:[inSelectedRow valueForKey:@"family_origin_id"]];
            [self.famliyList addObject:[inSelectedRow valueForKey:@"family_origin_name"]];
            break;
        }
        default:
            break;
    }
    
    [self.heritageDict setValue:self.religionIDList forKey:@"religion_id"];
    [self.heritageDict setValue:self.motherToungueIDList forKey:@"mother_tongue_id"];
    [self.heritageDict setValue:self.famliyIDList forKey:@"family_origin_id"];
    
}



-(void)setPreference:(NSMutableDictionary *)inBasicInfoDict
{
    /*
     family_origin_data":[{"family_origin_id":"1","family_origin_name":"Brahmin"}],
     "religion_data":[{"religion_id":"1","religion_name":"Hinduism"}],
     "mother_tongue_data":[{"mother_tongue_id":"4","mother_tongue":"Kannada"}]
     */
    

    
    self.heritageDict = inBasicInfoDict;
    self.famliyIDList = [[NSMutableArray alloc] init];
    self.famliyList = [[NSMutableArray alloc] init];
    for (NSDictionary *familyOriginDict in [self.heritageDict valueForKey:@"family_origin_data"])
    {
        self.familyOriginTF.text = [NSString stringWithFormat:@"%@   %@",self.familyOriginTF.text,[familyOriginDict valueForKey:@"family_origin_name"]];
        [self.famliyIDList addObject:[familyOriginDict valueForKey:@"family_origin_id"]];
        [self.famliyList addObject:[familyOriginDict valueForKey:@"family_origin_name"]];
    }
    

    
    self.religionIDList = [[NSMutableArray alloc] init];
    self.religionList = [[NSMutableArray alloc] init];
    for (NSDictionary *familyOriginDict in [self.heritageDict valueForKey:@"religion_data"])
    {
        self.religionTF.text = [NSString stringWithFormat:@"%@   %@",self.religionTF.text,[familyOriginDict valueForKey:@"religion_name"]];
        [self.religionIDList addObject:[familyOriginDict valueForKey:@"religion_id"]];
        [self.religionList addObject:[familyOriginDict valueForKey:@"religion_name"]];
    }


    self.motherToungueIDList = [[NSMutableArray alloc] init];
    self.motherToungueList = [[NSMutableArray alloc] init];
    for (NSDictionary *familyOriginDict in [self.heritageDict valueForKey:@"mother_tongue_data"])
    {
        self.motherToungueTF.text = [NSString stringWithFormat:@"%@   %@",self.motherToungueTF.text,[familyOriginDict valueForKey:@"mother_tongue"]];
        [self.motherToungueIDList addObject:[familyOriginDict valueForKey:@"mother_tongue_id"]];
        [self.motherToungueList addObject:[familyOriginDict valueForKey:@"mother_tongue"]];
    }

    [self.heritageDict setValue:self.religionIDList forKey:@"religion_id"];
    [self.heritageDict setValue:self.motherToungueIDList forKey:@"mother_tongue_id"];
    [self.heritageDict setValue:self.famliyIDList forKey:@"family_origin_id"];
}
@end
