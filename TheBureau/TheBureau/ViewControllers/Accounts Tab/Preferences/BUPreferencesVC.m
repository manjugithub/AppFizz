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
@interface BUPreferencesVC ()<UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

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
@property(nonatomic,weak) NSString *feetStr,*inchStr,*maritalStatus;
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





-(IBAction)getResidingDetails:(id)sender{
    
    UIButton *selectedBtn = (UIButton *)sender;
    
    if (selectedBtn.tag == 1) {
        [self.btn_USA setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.btn_India setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        
        [self.btn_USA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn_India setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isUSCitizen"];
    }
    else
    {
        [self.btn_India setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.btn_USA setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        
        [self.btn_India setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn_USA setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isUSCitizen"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.feetMutableArray = [[NSMutableArray alloc]init];
    
    self.navigationItem.title = @"Match Preferences";
    self.inchesMutableArray = [[NSMutableArray alloc]init];
    self.ageArray = [[NSMutableArray alloc]init];
    self.radiusArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    _relationCircle = [NSArray arrayWithObjects:@"Father",@"Mother",@"Family member", @"Friend", @"Sister", @"Brother",@"Self",nil];

    _educationLevelArray = [[NSArray alloc]initWithObjects:@"Post Graduate",@"Bachelor's",@"12th",@"10th", nil];

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
    
    {
        [self.neverMarriedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.divorcedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        [self.widowedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        
        
        self.maritalStatus = @"Never married";
        
        self.feetStr = @"4";
        self.inchStr = @"0";
        
        [self.neverMarriedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.widowedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.divorcedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

    self.navigationItem.rightBarButtonItem = self.rightBarButton;
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
            self.relationLabel.text = _relationCircle[buttonIndex - 1];
        else if(actionSheet.tag == 101)
            self.educationlevelLbl.text = _educationLevelArray[buttonIndex - 1];
        
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
    //  UIPopoverPresentationController *popoverController = alertController.popoverPresentationController;
    //  popoverController.sourceView = sender;
    //   popoverController.sourceRect = [sender bounds];
    [self presentViewController:alertController  animated:YES completion:nil];
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
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [BUUtilities setNavBarLogo:self.navigationController image:[UIImage imageNamed:@"logo44"]];
    self.navigationItem.rightBarButtonItem = nil;
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


- (IBAction)editProfileDetails:(id)sender
{
    NSString *imgName = @"";
    if (self.rightBarButton.tag == 0)
    {
        self.rightBarButton.tag = 1;
        imgName = @"ic_done";
    }
    else
    {
        self.rightBarButton.tag = 0;
        imgName = @"ic_edit";
    }
    self.rightBarButton.image = [UIImage imageNamed:imgName];
}


#pragma mark -
#pragma mark - Age selection

-(IBAction)setAge {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Age\n From                        To\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
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
            self.ageLabel.text = text;
        }];
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"cancel");
        }];
        action;
    })];
    [self presentViewController:alertController  animated:YES completion:nil];
}


#pragma mark -
#pragma mark - Radius selection

-(IBAction)setRadius {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location Radius\n From                        To\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
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
            self.radiusLabel.text = text;
        }];
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"cancel");
        }];
        action;
    })];
    [self presentViewController:alertController  animated:YES completion:nil];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
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


#pragma mark - Martial status


-(IBAction)getMatialStatus:(id)sender
{
    UIButton *selectedBtn = (UIButton *)sender;
    if (selectedBtn.tag == 1)
    {
        self.maritalStatus = @"Never married";
        
        [self.neverMarriedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.divorcedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        [self.widowedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        
        
        
        [self.neverMarriedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.widowedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.divorcedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        
        
    }
    else if (selectedBtn.tag == 2){
        
        self.maritalStatus = @"Divorced";
        
        [self.divorcedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.neverMarriedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        [self.widowedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        
        
        [self.divorcedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.widowedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.neverMarriedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        
    }
    else{
        
        self.maritalStatus = @"Widow";
        
        [self.widowedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
        [self.neverMarriedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        [self.divorcedBtn setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
        
        [self.widowedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.divorcedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.neverMarriedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        
    }
    
    
    
}


@end
