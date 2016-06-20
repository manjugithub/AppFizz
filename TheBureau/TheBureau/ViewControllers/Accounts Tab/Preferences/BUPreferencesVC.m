//
//  BUPreferencesVC.m
//  TheBureau
//
//  Created by Manjunath on 01/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUPreferencesVC.h"
#import "UIView+FLKAutoLayout.h"
#import "BUConstants.h"
#import "BUUtilities.h"
#import "BUWebServicesManager.h"
#import "UIColor+APColor.h"
#import "BUPrefAgeSeekCell.h"
#import "BUPrefHeritageCell.h"
@interface BUPreferencesVC ()<UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (assign, nonatomic) BOOL shouldAddPref;
@property (strong, nonatomic) NSMutableDictionary *profDict,*religionListDict,*originListDict,*motherToungueListDict;
@property (strong, nonatomic) NSMutableArray *maritalStatusList,*dietList;
@property (weak, nonatomic) IBOutlet BUPrefAgeSeekCell *ageCell;
@property (weak, nonatomic) IBOutlet BUPrefAgeSeekCell *heightCell;
@property (weak, nonatomic) IBOutlet BUPrefAgeSeekCell *radiusCell;
@property (weak, nonatomic) IBOutlet BUPrefHeritageCell *heritageCell;



#pragma mark - Account selection
@property (weak, nonatomic) IBOutlet UILabel *relationLabel;
@property(nonatomic,strong)NSArray* relationCircle,*educationLevelArray;
-(IBAction)dropDownBtn:(id)sender;
#pragma mark -
#pragma mark - Gender selection
@property(nonatomic,weak) IBOutlet UIImageView *femaleImgView,*maleImgView;
@property(nonatomic,weak) IBOutlet UIButton *genderSelectionBtn;
-(IBAction)setGender:(id)sender;
#pragma mark -
#pragma mark - Education selection
@property (weak, nonatomic) IBOutlet UITextField *educationlevelLbl;

#pragma mark -
#pragma mark - Height Information

@property(nonatomic) NSMutableArray *feetMutableArray;
@property(nonatomic) NSMutableArray *inchesMutableArray;
@property(nonatomic) NSMutableArray *ageArray;
@property(nonatomic) NSMutableArray *radiusArray;
@property(nonatomic,weak) NSString *feetStr,*inchStr,*maritalStatus,*dietStr,*genderStr;
@property (weak, nonatomic) IBOutlet UITextField *heighTextField;

#pragma mark -
#pragma mark - Social habits

@property(nonatomic,weak)IBOutlet UIButton *vegetarianBtn;
@property(nonatomic,weak)IBOutlet UIButton *eegetarianBtn;

@property(nonatomic,weak)IBOutlet UIButton *veganBtn;
@property(nonatomic,weak)IBOutlet UIButton *nonVegetarianBtn;

@property(nonatomic,weak)IBOutlet UIButton *drinkingSelectionBtn;
@property(nonatomic,weak)IBOutlet UIButton *smokingSelectionBtn;

@property(nonatomic,weak)IBOutlet UILabel *sociallyLabel;
@property(nonatomic,weak)IBOutlet UILabel *neverLabel;

@property(nonatomic,weak)IBOutlet UILabel *yesLabel;
@property(nonatomic,weak)IBOutlet UILabel *noLabel;

@property(nonatomic,weak) IBOutlet UIButton *btn_USA;
@property(nonatomic,weak) IBOutlet UIButton *btn_India;


@property(nonatomic,weak)IBOutlet UITextField *ageLabel,*radiusLabel;


@property(nonatomic,weak) IBOutlet UIButton *neverMarriedBtn;
@property(nonatomic,weak) IBOutlet UIButton *divorcedBtn;
@property(nonatomic,weak) IBOutlet UIButton *widowedBtn;


@end

@implementation BUPreferencesVC





-(IBAction)setUSA:(id)sender
{
    
    UIButton *selectedBtn = (UIButton *)sender;
    
    if (selectedBtn.tag == 0)
    {
        [self.btn_USA setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.btn_USA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if([[[self.profDict valueForKey:@"country"] uppercaseString] containsString:@"INDIA"])
        {
            [self.profDict setValue:@"Both" forKey:@"country"];
        }
        else
        {
            [self.profDict setValue:@"USA" forKey:@"country"];
        }
        
        selectedBtn.tag = 1;
    }
    else
    {
        [self.btn_USA setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        [self.btn_USA setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        if([[[self.profDict valueForKey:@"country"] uppercaseString] containsString:@"USA"])
        {
            [self.profDict setValue:@"" forKey:@"country"];
        }
        else
        {
            [self.profDict setValue:@"INDIA" forKey:@"country"];
        }
        
        selectedBtn.tag = 0;
    }
    
}

-(IBAction)setIndia:(id)sender
{
    
    UIButton *selectedBtn = (UIButton *)sender;
    
    if (selectedBtn.tag == 0)
    {
        [self.btn_India setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.btn_India setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if([[[self.profDict valueForKey:@"country"] uppercaseString] containsString:@"USA"])
        {
            [self.profDict setValue:@"Both" forKey:@"country"];
        }
        else
        {
            [self.profDict setValue:@"INDIA" forKey:@"country"];
        }
        selectedBtn.tag = 1;
    }
    else
    {
        [self.btn_India setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        [self.btn_India setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if([[[self.profDict valueForKey:@"country"] uppercaseString] containsString:@"INDIA"])
        {
            [self.profDict setValue:@"" forKey:@"country"];
        }
        else
        {
            [self.profDict setValue:@"USA" forKey:@"country"];
        }
        selectedBtn.tag = 0;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Preferences";

    
    NSDictionary *prefDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"Preferences"];
    
    if(nil == prefDict)
    {
        self.preferenceDict = [[NSMutableDictionary alloc] init];
    }
    else
    {
        self.preferenceDict = [[NSMutableDictionary alloc] initWithDictionary:prefDict];
    }

    self.feetMutableArray = [[NSMutableArray alloc]init];
    
    self.inchesMutableArray = [[NSMutableArray alloc]init];
    self.ageArray = [[NSMutableArray alloc]init];
    self.radiusArray = [[NSMutableArray alloc]init];
    self.dietList = [[NSMutableArray alloc] init];
    self.maritalStatusList = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    _relationCircle = [NSArray arrayWithObjects:@"Self",@"Other",@"Both",nil];

    _educationLevelArray = [[NSArray alloc]initWithObjects:@"Doctorate",@"Masters",@"Bachelors",@"Associates",@"Grade School", nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(editProfileDetails:)];
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


#pragma mark - Gender selection

-(IBAction)setGender:(id)sender
{
    NSString *femaleImgName,*maleImgName,*genderImgName;
    
    if(1 == self.genderSelectionBtn.tag)
    {
        femaleImgName = @"ic_female_s2.png";
        maleImgName = @"ic_male_s1.png";
        genderImgName = @"switch_female.png";
        self.genderSelectionBtn.tag = 0;
        self.genderStr = @"Female";
    }
    else
    {
        self.genderSelectionBtn.tag = 1;
        femaleImgName = @"ic_female_s1.png";
        maleImgName = @"ic_male_s2.png";
        genderImgName = @"switch_male.png";
        self.genderStr = @"Male";
    }
    
    self.femaleImgView.image = [UIImage imageNamed:femaleImgName];
    self.maleImgView.image = [UIImage imageNamed:maleImgName];
    [self.genderSelectionBtn setImage:[UIImage imageNamed:genderImgName]
                             forState:UIControlStateNormal];
    
    [self.profDict setValue:self.genderStr forKey:@"gender"];
}


#pragma mark - Account selection

-(IBAction)dropDownBtn:(id)sender
{
    [self.view endEditing:YES];
    UIActionSheet *acSheet = [[UIActionSheet alloc] initWithTitle:@"Select Relationship" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    acSheet.tag = 100;
    
    for (NSString *str in _relationCircle)
    {
        [acSheet addButtonWithTitle:str];
    }
    
    [acSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex != 0)
    {
        if(actionSheet.tag == 100)
        {
            self.relationLabel.text = _relationCircle[buttonIndex - 1];
            [self.profDict setValue:_relationCircle[buttonIndex - 1] forKey:@"account_created_by"];
        }
        else if(actionSheet.tag == 101)
        {
            self.educationlevelLbl.text = _educationLevelArray[buttonIndex - 1];
            [self.profDict setValue:_educationLevelArray[buttonIndex - 1] forKey:@"minimum_education_requirement"];
        }
        
    }
}


#pragma mark -
#pragma mark - Education selection

-(IBAction)selectEducationLevel{
    UIActionSheet *acSheet = [[UIActionSheet alloc] initWithTitle:@"Select Education Level" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    
    acSheet.tag = 101;
    for (NSString *str in _educationLevelArray)
    {
        [acSheet addButtonWithTitle:str];
    }
    
    [acSheet showInView:self.view];
    
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
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


    [BUUtilities removeLogo:self.navigationController];
    

    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(editProfileDetails:)];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    
    [self readPreferences];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [BUUtilities setNavBarLogo:self.navigationController image:[UIImage imageNamed:@"logo44"]];
//    self.navigationItem.rightBarButtonItem = nil;
}



#pragma mark -
#pragma mark - Social habits


-(IBAction)resetDiet:(id)sender
{
    
    [_vegetarianBtn setSelected:NO];
    _vegetarianBtn.tag = 0;
    [_eegetarianBtn setSelected:NO];
    _eegetarianBtn.tag = 0;
    [_nonVegetarianBtn setSelected:NO];
    _nonVegetarianBtn.tag = 0;
    [_veganBtn setSelected:NO];
    _veganBtn.tag = 0;

    [self.dietList removeAllObjects];
}


-(IBAction)vegeterianBtnClicked:(id)sender
{
    if([sender tag] == 0)
    {
        [_vegetarianBtn setSelected:YES];
        _vegetarianBtn.tag = 1;
        [self.dietList addObject:self.vegetarianBtn.titleLabel.text];
    }
    else
    {
        [_vegetarianBtn setSelected:NO];
        _vegetarianBtn.tag = 0;
        [self.dietList removeObject:self.vegetarianBtn.titleLabel.text];
    }
    
}
-(IBAction)eggtarianBtnClicked:(id)sender
{
    if([sender tag] == 0)
    {
        [_eegetarianBtn setSelected:YES];
        _eegetarianBtn.tag = 1;
        [self.dietList addObject:self.eegetarianBtn.titleLabel.text];
    }
    else
    {
        [_eegetarianBtn setSelected:NO];
        _eegetarianBtn.tag = 0;
        [self.dietList removeObject:self.eegetarianBtn.titleLabel.text];
    }
    
}
-(IBAction)nonVegBtnClicked:(id)sender
{
    if([sender tag] == 0)
    {
        [_nonVegetarianBtn setSelected:YES];
        _nonVegetarianBtn.tag = 1;
        [self.dietList addObject:self.nonVegetarianBtn.titleLabel.text];
    }
    else
    {
        [_nonVegetarianBtn setSelected:NO];
        _nonVegetarianBtn.tag = 0;
        [self.dietList removeObject:self.nonVegetarianBtn.titleLabel.text];
    }
    
}

-(IBAction)veganBtnClicked:(id)sender
{
    if([sender tag] == 0)
    {
        [_veganBtn setSelected:YES];
        _veganBtn.tag = 1;
        [self.dietList addObject:self.veganBtn.titleLabel.text];
    }
    else
    {
        [_veganBtn setSelected:NO];
        _veganBtn.tag = 0;
        [self.dietList removeObject:self.veganBtn.titleLabel.text];
    }
    
}

- (IBAction)editProfileDetails:(id)sender
{
        [self updatePrefernceValues];
}




#pragma mark - Martial status



-(IBAction)divorceClicked:(id)sender
{
    if(self.divorcedBtn.tag == 0)
    {
        [self.divorcedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.divorcedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.divorcedBtn.tag = 1;
        [self.maritalStatusList addObject:self.divorcedBtn.titleLabel.text];
    }
    else
    {
        [self.divorcedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        [self.divorcedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.divorcedBtn.tag = 0;
        [self.maritalStatusList removeObject:self.divorcedBtn.titleLabel.text];
    }
    
}

-(IBAction)widowedBtnClcked:(id)sender
{
    if(self.widowedBtn.tag == 0)
    {
        [self.widowedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.widowedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.widowedBtn.tag = 1;
        [self.maritalStatusList addObject:self.widowedBtn.titleLabel.text];
    }
    else
    {
        [self.widowedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        [self.widowedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.widowedBtn.tag = 0;
        [self.maritalStatusList removeObject:self.widowedBtn.titleLabel.text];
    }
    
}

-(IBAction)neverMarriedBtnClicked:(id)sender
{
    if(self.neverMarriedBtn.tag == 0)
    {
        [self.neverMarriedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.neverMarriedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.neverMarriedBtn.tag = 1;
        [self.maritalStatusList addObject:self.neverMarriedBtn.titleLabel.text];
    }
    else
    {
        [self.neverMarriedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        [self.neverMarriedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.neverMarriedBtn.tag = 0;
        [self.maritalStatusList removeObject:self.neverMarriedBtn.titleLabel.text];
    }
    
}

-(void)updatePrefernceValues
{

    [self.profDict setValue:[BUWebServicesManager sharedManager].userID forKey:@"userid"];

    [self.profDict setValue:self.maritalStatusList forKey:@"marital_status"];
    [self.profDict setValue:self.dietList forKey:@"diet"];
 
    NSString *baseURl = @"http://dev.thebureauapp.com/admin/add_match_preference_ws";
    if(self.shouldAddPref == NO)
    {
     baseURl = @"http://dev.thebureauapp.com/admin/update_match_preference_ws";
    }
    
    [self startActivityIndicator:YES];

    [[BUWebServicesManager sharedManager] queryServer:self.profDict
                                              baseURL:baseURl
                                         successBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         
         
         NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Preferences updated"];
         [message addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"comfortaa" size:15]
                         range:NSMakeRange(0, message.length)];
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
         [alertController setValue:message forKey:@"attributedTitle"];
         
         [alertController addAction:({
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                 NSLog(@"OK");
                 self.shouldAddPref = NO;
                 
                 [self.navigationController popViewControllerAnimated:YES];
             }];
             
             action;
         })];
         
         [self presentViewController:alertController  animated:YES completion:nil];
         
     }
                                         failureBlock:^(id response, NSError *error)
    {
                                             [self stopActivityIndicator];
        
        
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Preferences updated"];
        [message addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"comfortaa" size:15]
                        range:NSMakeRange(0, message.length)];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:message forKey:@"attributedTitle"];
        
        [alertController addAction:({
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"OK");
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            action;
        })];
        
        [self presentViewController:alertController  animated:YES completion:nil];

    }
     ];
}



-(void)readPreferences
{
    /*
     
     {"age_from":"7","age_to":"30","gender":"Female","location_radius":"40","account_created_by":"Self","country":null,"height_from_feet":null,"height_from_inch":null,"height_to_feet":null,"height_to_inch":null,"minimum_education_requirement":"","years_in_usa":null,"legal_status":null,"marital_status":null,"diets":null,"family_origin_data":[{"family_origin_id":"1","family_origin_name":"Brahmin"}],"religion_data":[{"religion_id":"1","religion_name":"Hinduism"}],"mother_tongue_data":[{"mother_tongue_id":"4","mother_tongue":"Kannada"}]}
     
     */
    
    
    self.shouldAddPref = NO;
    [self startActivityIndicator:YES];
    NSString *baseURl = @"http://dev.thebureauapp.com/admin/readPreference";
    
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID
                   };

    [[BUWebServicesManager sharedManager] queryServer:parameters
                                              baseURL:baseURl
                                         successBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         

         if([[response valueForKey:@"msg"] isEqualToString:@"Error"])
         {
             self.profDict = [[NSMutableDictionary alloc] initWithDictionary:response];
             
             
             for (NSString *key in [self.profDict allKeys])
             {
                 id str =   (([self.profDict valueForKey:key] == nil || [[self.profDict valueForKey:key] isKindOfClass:[NSNull class]]) ? @"" : [self.profDict valueForKey:key]);
                 [self.profDict setValue:str forKey:key];
                 if([str isKindOfClass:[NSString class]])
                     if([str isEqualToString:@""] && ([key isEqualToString:@"diets"] || [key isEqualToString:@"marital_status"]  || [key isEqualToString:@"years_in_usa"]))
                         [self.profDict setValue:[[NSArray alloc] init] forKey:key];
             }
             
             NSInteger locRadius = (([self.profDict valueForKey:@"location_radius"] == nil || [[self.profDict valueForKey:@"location_radius"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"location_radius"] isEqualToString:@""]) ? 300 : [[self.profDict valueForKey:@"location_radius"] intValue]);
             
             NSInteger ageFrom = (([self.profDict valueForKey:@"age_from"] == nil || [[self.profDict valueForKey:@"age_from"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"age_from"] isEqualToString:@""]) ? 18 : [[self.profDict valueForKey:@"age_from"] intValue]);
             
             
             NSInteger ageTo = (([self.profDict valueForKey:@"age_to"] == nil || [[self.profDict valueForKey:@"age_to"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"age_to"] isEqualToString:@""]) ? 40 : [[self.profDict valueForKey:@"age_to"] intValue]);
             
             
             NSInteger feet = (([self.profDict valueForKey:@"height_from_feet"] == nil || [[self.profDict valueForKey:@"height_from_feet"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"height_from_feet"] isEqualToString:@""]) ? 4 : [[self.profDict valueForKey:@"height_from_feet"] intValue]);
             
             NSInteger inch = (([self.profDict valueForKey:@"height_from_inch"] == nil || [[self.profDict valueForKey:@"height_from_inch"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"height_from_inch"] isEqualToString:@""]) ? 0 : [[self.profDict valueForKey:@"height_from_inch"] intValue]);
             NSInteger feet1 = (([self.profDict valueForKey:@"height_to_feet"] == nil || [[self.profDict valueForKey:@"height_to_feet"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"height_to_feet"] isEqualToString:@""]) ? 7 : [[self.profDict valueForKey:@"height_to_feet"] intValue]);
             
             
             NSInteger inch1 = (([self.profDict valueForKey:@"height_to_inch"] == nil || [[self.profDict valueForKey:@"height_to_inch"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"height_to_inch"] isEqualToString:@""]) ? 0 : [[self.profDict valueForKey:@"height_to_inch"] intValue]);
             
             self.shouldAddPref = NO;
             
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)locRadius] forKey:@"location_radius"];
             
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)ageFrom] forKey:@"age_from"];
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)ageTo] forKey:@"age_to"];
             
             
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)feet] forKey:@"height_from_feet"];
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)inch] forKey:@"height_from_inch"];
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)feet1] forKey:@"height_to_feet"];
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)inch1] forKey:@"height_to_inch"];
             
             
             
             
             NSString *femaleImgName,*maleImgName,*genderImgName;
             
             
             NSString *genderStr = (([self.profDict valueForKey:@"gender"] == nil || [[self.profDict valueForKey:@"gender"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"gender"] isEqualToString:@""]) ? @"Female" : [self.profDict valueForKey:@"gender"]);
             
             if([genderStr containsString:@"Female"])
             {
                 self.genderSelectionBtn.tag = 0;
                 femaleImgName = @"ic_female_s2.png";
                 maleImgName = @"ic_male_s1.png";
                 genderImgName = @"switch_female.png";
                 self.genderStr = @"Female";
             }
             else
             {
                 femaleImgName = @"ic_female_s1.png";
                 maleImgName = @"ic_male_s2.png";
                 genderImgName = @"switch_male.png";
                 self.genderSelectionBtn.tag = 1;
                 self.genderStr = @"Male";
             }
             
             self.femaleImgView.image = [UIImage imageNamed:femaleImgName];
             self.maleImgView.image = [UIImage imageNamed:maleImgName];
             [self.genderSelectionBtn setImage:[UIImage imageNamed:genderImgName]
                                      forState:UIControlStateNormal];
             

             [self.profDict setValue:self.genderStr forKey:@"gender"];
             
             self.maritalStatusList = [[NSMutableArray alloc] initWithArray:([self.profDict valueForKey:@"marital_status"] == nil || [[self.profDict valueForKey:@"marital_status"] isKindOfClass:[NSNull class]] ? nil : [self.profDict valueForKey:@"marital_status"])];
             
             [self updateMaritalStatus];
             self.shouldAddPref = YES;
             
             [self.radiusCell setDatasource:self.profDict];
             [self.ageCell setDatasource:self.profDict];
             [self.heightCell setDatasource:self.profDict];

         }
         else
         {
             self.profDict = [[NSMutableDictionary alloc] initWithDictionary:response];

             
             for (NSString *key in [self.profDict allKeys])
             {
                 id str =   (([self.profDict valueForKey:key] == nil || [[self.profDict valueForKey:key] isKindOfClass:[NSNull class]]) ? @"" : [self.profDict valueForKey:key]);
                 [self.profDict setValue:str forKey:key];
                 if([str isKindOfClass:[NSString class]])
                     if([str isEqualToString:@""] && ([key isEqualToString:@"diets"] || [key isEqualToString:@"marital_status"]  || [key isEqualToString:@"years_in_usa"]))
                         [self.profDict setValue:[[NSArray alloc] init] forKey:key];
             }
             
             NSInteger locRadius = (([self.profDict valueForKey:@"location_radius"] == nil || [[self.profDict valueForKey:@"location_radius"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"location_radius"] isEqualToString:@""]) ? 300 : [[self.profDict valueForKey:@"location_radius"] intValue]);
             
             NSInteger ageFrom = (([self.profDict valueForKey:@"age_from"] == nil || [[self.profDict valueForKey:@"age_from"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"age_from"] isEqualToString:@""]) ? 18 : [[self.profDict valueForKey:@"age_from"] intValue]);
             
             
             NSInteger ageTo = (([self.profDict valueForKey:@"age_to"] == nil || [[self.profDict valueForKey:@"age_to"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"age_to"] isEqualToString:@""]) ? 40 : [[self.profDict valueForKey:@"age_to"] intValue]);
             
             
             NSInteger feet = (([self.profDict valueForKey:@"height_from_feet"] == nil || [[self.profDict valueForKey:@"height_from_feet"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"height_from_feet"] isEqualToString:@""]) ? 4 : [[self.profDict valueForKey:@"height_from_feet"] intValue]);
             
             NSInteger inch = (([self.profDict valueForKey:@"height_from_inch"] == nil || [[self.profDict valueForKey:@"height_from_inch"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"height_from_inch"] isEqualToString:@""]) ? 0 : [[self.profDict valueForKey:@"height_from_inch"] intValue]);
             NSInteger feet1 = (([self.profDict valueForKey:@"height_to_feet"] == nil || [[self.profDict valueForKey:@"height_to_feet"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"height_to_feet"] isEqualToString:@""]) ? 7 : [[self.profDict valueForKey:@"height_to_feet"] intValue]);
             
             
             NSInteger inch1 = (([self.profDict valueForKey:@"height_to_inch"] == nil || [[self.profDict valueForKey:@"height_to_inch"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"height_to_inch"] isEqualToString:@""]) ? 0 : [[self.profDict valueForKey:@"height_to_inch"] intValue]);

             self.shouldAddPref = NO;
             
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)locRadius] forKey:@"location_radius"];

             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)ageFrom] forKey:@"age_from"];
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)ageTo] forKey:@"age_to"];
             
             
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)feet] forKey:@"height_from_feet"];
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)inch] forKey:@"height_from_inch"];
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)feet1] forKey:@"height_to_feet"];
             [self.profDict setValue:[NSString stringWithFormat:@"%ld",(long)inch1] forKey:@"height_to_inch"];

             
             
             self.maritalStatusList = [[NSMutableArray alloc] initWithArray:([self.profDict valueForKey:@"marital_status"] == nil || [[self.profDict valueForKey:@"marital_status"] isKindOfClass:[NSNull class]] ? nil : [self.profDict valueForKey:@"marital_status"])];
             
             [self updateMaritalStatus];
             
             self.dietList = [[NSMutableArray alloc] initWithArray:([self.profDict valueForKey:@"diets"] == nil || [[self.profDict valueForKey:@"diets"] isKindOfClass:[NSNull class]] ? nil : [self.profDict valueForKey:@"diets"])];

             [self updateDiet];

             self.relationLabel.text = [self.profDict valueForKey:@"account_created_by"];
             self.educationlevelLbl.text = [self.profDict valueForKey:@"minimum_education_requirement"];
             
             
             
             
             if ([[[self.profDict valueForKey:@"country"] lowercaseString] containsString:@"usa"])
             {
                 [self.btn_USA setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
                 
                 [self.btn_USA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                 
                 self.btn_USA.tag = 1;
                 
             }
             if ([[[self.profDict valueForKey:@"country"] lowercaseString] containsString:@"india"])
             {
                 [self.btn_India setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
                 
                 [self.btn_India setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                 
                 self.btn_India.tag = 1;
             }
             if ([[[self.profDict valueForKey:@"country"] lowercaseString] containsString:@"both"])
             {
                 [self.btn_USA setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
                 [self.btn_USA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                 
                 [self.btn_India setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
                 [self.btn_India setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                 self.btn_USA.tag = 1;
                 self.btn_India.tag = 1;

             }
             

             
             NSString *femaleImgName,*maleImgName,*genderImgName;
             
             
             NSString *genderStr = (([self.profDict valueForKey:@"gender"] == nil || [[self.profDict valueForKey:@"gender"] isKindOfClass:[NSNull class]] || [[self.profDict valueForKey:@"gender"] isEqualToString:@""]) ? @"Female" : [self.profDict valueForKey:@"gender"]);

             if([genderStr containsString:@"Female"])
             {
                 self.genderSelectionBtn.tag = 0;
                 femaleImgName = @"ic_female_s2.png";
                 maleImgName = @"ic_male_s1.png";
                 genderImgName = @"switch_female.png";
                 self.genderStr = @"Female";
             }
             else
             {
                 femaleImgName = @"ic_female_s1.png";
                 maleImgName = @"ic_male_s2.png";
                 genderImgName = @"switch_male.png";
                 self.genderSelectionBtn.tag = 1;
                 self.genderStr = @"Male";
             }
             
             
             [self.profDict setValue:self.genderStr forKey:@"gender"];

             
             self.femaleImgView.image = [UIImage imageNamed:femaleImgName];
             self.maleImgView.image = [UIImage imageNamed:maleImgName];
             [self.genderSelectionBtn setImage:[UIImage imageNamed:genderImgName]
                                      forState:UIControlStateNormal];
             
             
             self.originListDict = [[NSMutableDictionary alloc] init];
             for (NSDictionary *dict in [self.profDict valueForKey:@"family_origin_data"])
             {
                 [self.originListDict setValue:dict forKey:[dict valueForKey:@"family_origin_id"]];
             }

             
             self.religionListDict = [[NSMutableDictionary alloc] init];
             for (NSDictionary *dict in [self.profDict valueForKey:@"religion_data"])
             {
                 [self.religionListDict setValue:dict forKey:[dict valueForKey:@"religion_id"]];
             }

             self.motherToungueListDict = [[NSMutableDictionary alloc] init];
             for (NSDictionary *dict in [self.profDict valueForKey:@"mother_tongue_data"])
             {
                 [self.motherToungueListDict setValue:dict forKey:[dict valueForKey:@"mother_tongue_id"]];
             }
             
             
             [self.radiusCell setDatasource:self.profDict];
             [self.ageCell setDatasource:self.profDict];
             [self.heightCell setDatasource:self.profDict];
             
             /*
              family_origin_data":[{"family_origin_id":"1","family_origin_name":"Brahmin"}],
              "religion_data":[{"religion_id":"1","religion_name":"Hinduism"}],
              "mother_tongue_data":[{"mother_tongue_id":"4","mother_tongue":"Kannada"}]
              */
             
             [self.heritageCell setPreference:self.profDict];

         }
     }
                                         failureBlock:^(id response, NSError *error)
    {
        self.shouldAddPref = YES;
        [self stopActivityIndicator];

        
    }
     ];
}

-(void)updateMaritalStatus
{
    
    [self.neverMarriedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
    self.neverMarriedBtn.tag = 0;
    [self.divorcedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
    self.divorcedBtn.tag = 0;
    [self.widowedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
    self.widowedBtn.tag = 0;

    
    [self.neverMarriedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.divorcedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.widowedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    for (NSString *maritalStatusStr in self.maritalStatusList)
    {
        if([maritalStatusStr containsString:@"Never"])
        {
            [self.neverMarriedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
            self.neverMarriedBtn.tag = 1;
            [self.neverMarriedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        if([maritalStatusStr containsString:@"Divorced"])
        {
            [self.divorcedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
            self.divorcedBtn.tag = 1;
            [self.divorcedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        if([maritalStatusStr containsString:@"Widowed"])
        {
            [self.widowedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
            self.widowedBtn.tag = 1;
            [self.widowedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }

}

-(void)updateDiet
{
        [_vegetarianBtn setSelected:NO];
        _vegetarianBtn.tag = 0;
        [_eegetarianBtn setSelected:NO];
        _eegetarianBtn.tag = 0;
        [_nonVegetarianBtn setSelected:NO];
        _nonVegetarianBtn.tag = 0;
        [_veganBtn setSelected:NO];
        _veganBtn.tag = 0;

    for (NSString *maritalStatusStr in self.dietList)
    {
        if([maritalStatusStr containsString:@"Vegetarian"])
        {
            [_vegetarianBtn setSelected:YES];
            _vegetarianBtn.tag = 1;
        }
        if([maritalStatusStr containsString:@"Eggetarian"])
        {
            [_eegetarianBtn setSelected:YES];
            _eegetarianBtn.tag = 1;
        }
        if([maritalStatusStr containsString:@"Non"])
        {
            [_nonVegetarianBtn setSelected:YES];
            _nonVegetarianBtn.tag = 1;
        }
        if([maritalStatusStr containsString:@"Vegan"])
        {
            [_veganBtn setSelected:YES];
            _veganBtn.tag = 1;
        }
    }
    
}

-(void)populatePreerences:(NSMutableDictionary *)inDict
{
    
}


-(void)updateCountry
{
    if (YES == [[NSUserDefaults standardUserDefaults] boolForKey:@"isUSCitizen"])
    {
        [self.btn_USA setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.btn_India setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        
        [self.btn_USA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn_India setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.btn_India setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.btn_USA setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        
        [self.btn_India setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn_USA setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
//    self.genderStr = @"Female";
}





- (void)startActivityIndicator:(BOOL)isWhite {
    _activityIndicatorCount++;
    if (_activityIndicatorCount > 1) {
        return;
    }
    [[[UIApplication sharedApplication].keyWindow viewWithTag:987] removeFromSuperview];
    [self.activityView removeFromSuperview];
    [self.view layoutIfNeeded];
    //    UIView *activityView = [[UIView alloc] initWithFrame:self.view.bounds];
    if (!self.activityView){
        self.activityView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.activityView.tag = 987;
        self.activityView.backgroundColor = [UIColor clearColor];
        self.activityView.alpha = 0.0f;
        //    [self.view addSubview:activityView];
        
        
        UIView *bgView = [[UIView alloc]initWithFrame:self.activityView.bounds];
        bgView.alpha = 0.0f;
        if ( isWhite ){
            [bgView setBackgroundColor:[UIColor XMApplicationColor]];
        }
        else{
            [bgView setBackgroundColor:[UIColor XMApplicationColor]];
        }
        [self.activityView addSubview:bgView];
        
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.activityView addSubview:spinner];
        spinner.center = self.activityView.center;
        //    spinner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        if ( isWhite ){
            [spinner setColor:[UIColor redIndicatorColor]];
        }else{
            [spinner setColor:[UIColor whiteColor]];
        }
        [spinner startAnimating];
        
        [UIView animateWithDuration:0.2 animations:^{
            bgView.alpha = 0.5f;
            self.activityView.alpha = 1;
        }];
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            self.activityView.alpha = 1;
        }];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.activityView];
}

- (void)stopActivityIndicator {
    _activityIndicatorCount--;
    if (_activityIndicatorCount <= 0) {
        _activityIndicatorCount = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.activityView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.activityView removeFromSuperview];
        }];
    }
}

@end
