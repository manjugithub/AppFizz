//
//  BUProfileDetailsVC.m
//  TheBureau
//
//  Created by Manjunath on 25/01/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileDetailsVC.h"
#import "BUProfileHeritageVC.h"
#import "UIView+FLKAutoLayout.h"

@interface BUProfileDetailsVC ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,weak) IBOutlet UITextField *dateofbirthTF;
@property(nonatomic,weak) IBOutlet UITextField *currentLocTF;


@property(nonatomic,weak) IBOutlet UIButton *neverMarriedBtn;
@property(nonatomic,weak) IBOutlet UIButton *divorcedBtn;
@property(nonatomic,weak) IBOutlet UIButton *widowedBtn;
@property(nonatomic,weak) IBOutlet UIImageView *femaleImgView,*maleImgView;
@property(nonatomic,weak) IBOutlet UIButton *genderSelectionBtn;

@property(nonatomic,weak) IBOutlet UIButton *btn_USA;
@property(nonatomic,weak) IBOutlet UIButton *btn_India;

@property(nonatomic,weak) IBOutlet UIPickerView *heightPicker;
@property(nonatomic,weak)IBOutlet UITextField *heighTextField;

@property(nonatomic) NSMutableArray *feetMutableArray;
@property(nonatomic) NSMutableArray *inchesMutableArray;

@property(nonatomic,weak) NSString *feetStr,*inchStr,*maritalStatus;


-(IBAction)continueClicked:(id)sender;

@end

@implementation BUProfileDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Information";
    
    self.feetMutableArray = [[NSMutableArray alloc]init];
    
    self.inchesMutableArray = [[NSMutableArray alloc]init];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:self action:@selector(viewPopOnBackButton)];
    
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    [self.btn_USA setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s2"] forState:UIControlStateNormal];
    [self.btn_India setBackgroundImage:[UIImage imageNamed:@"bg_radiobutton_bubble_s1"] forState:UIControlStateNormal];
    
    [self.btn_USA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn_India setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isUSCitizen"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    
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
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    for (int i=0; i < 12; i++) {
        NSString *inches = [NSString stringWithFormat:@"%d\"",i ];
        [self.inchesMutableArray addObject:inches];
    }
    
    for (int i=4; i < 8; i++) {
        NSString *feet = [NSString stringWithFormat:@"%d'",i ];
        [self.feetMutableArray addObject:feet];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)selectDateofBirthBtn:(id)sender
{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Birthday\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    
    
    [picker setDatePickerMode:UIDatePickerModeDate];
    [alertController.view addSubview:picker];
    
    [picker alignCenterYWithView:alertController.view predicate:@"0.0"];
    [picker alignCenterXWithView:alertController.view predicate:@"0.0"];
    [picker constrainWidth:@"270" ];

    NSDate *todayDate = [NSDate date];
    NSDate *newDate = [todayDate dateByAddingTimeInterval:(-1*18*365*24*60*60)];
    
    picker.maximumDate = newDate;
    picker.date = newDate;

    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            NSLog(@"%@",picker.date);
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"MM/dd/yyyy"];
            NSString *dateString = [dateFormat stringFromDate:picker.date];
            self.dateofbirthTF.text = [NSString stringWithFormat:@"%@",dateString];
        }];
        action;
    })];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"cancel");
            //NSLog(@"%@",picker.date);
        }];
        action;
    })];
    //  UIPopoverPresentationController *popoverController = alertController.popoverPresentationController;
    //  popoverController.sourceView = sender;
    //   popoverController.sourceRect = [sender bounds];
    [self presentViewController:alertController  animated:YES completion:nil];
    
    
    
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    
    
    
    
}

-(IBAction)setGender:(id)sender
{
    NSString *femaleImgName,*maleImgName,*genderImgName;
    
    if(1 == self.genderSelectionBtn.tag)
    {
        femaleImgName = @"ic_female_s2.png";
        maleImgName = @"ic_male_s1.png";
        genderImgName = @"switch_female.png";
        self.genderSelectionBtn.tag = 0;
    }
    else
    {
        self.genderSelectionBtn.tag = 1;
        femaleImgName = @"ic_female_s1.png";
        maleImgName = @"ic_male_s2.png";
        genderImgName = @"switch_male.png";
    }
    
    self.femaleImgView.image = [UIImage imageNamed:femaleImgName];
    self.maleImgView.image = [UIImage imageNamed:maleImgName];
    [self.genderSelectionBtn setImage:[UIImage imageNamed:genderImgName]
                             forState:UIControlStateNormal];
    
}



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


#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if (component ==1) {
        return [_inchesMutableArray count];
    }
    else
    {
        
        return [_feetMutableArray count];
        
        
    }
    
    
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
    
    if (component == 1) {
        return [_inchesMutableArray objectAtIndex:row];
        
    }
    else
    {
        return [_feetMutableArray objectAtIndex:row];
        
        
    }
}




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

-(IBAction)continueClicked:(id)sender
{
    
        if (![self.currentLocTF.text length]) {
            [self alertMessage:@"Current Location"];
            }
    
        else if (![self.heighTextField.text length]){
    
            [self alertMessage:@"Height"];
            
        }
        else
        {
            NSDictionary *parameters = nil;
            NSString *citizen = @"USA";
            if(NO == [[NSUserDefaults standardUserDefaults] boolForKey:@"isUSCitizen"])
            {
                citizen = @"INDIA";
            }

            
            /*
             
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
             
             */
            
            parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                           @"country_residing":citizen,
                           @"current_zip_code":self.currentLocTF.text,
                           @"height_feet":self.feetStr,
                           @"height_inch":self.inchStr,
                           @"maritial_status":self.maritalStatus
                           };
            
            [self startActivityIndicator:YES];
            [[BUWebServicesManager sharedManager] updateProfileDetailswithParameters:parameters
                                                                        successBlock:^(id inResult, NSError *error)
             {
                 [self stopActivityIndicator];
                 
                 if(YES == [[inResult valueForKey:@"msg"] isEqualToString:@"Success"])
                 {
                     UIStoryboard *sb =[UIStoryboard storyboardWithName:@"ProfileCreation" bundle:nil];
                     BUProfileHeritageVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUProfileHeritageVC"];
                     [self.navigationController pushViewController:vc animated:YES];
                 }
                 else
                 {
                     NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
                     [message addAttribute:NSFontAttributeName
                                     value:[UIFont fontWithName:@"comfortaa" size:15]
                                     range:NSMakeRange(0, message.length)];
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                     [alertController setValue:message forKey:@"attributedTitle"];                     [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                     [self presentViewController:alertController animated:YES completion:nil];
                 }
                 
             }
                                                                        failureBlock:^(id response, NSError *error)
             {
                 [self stopActivityIndicator];
                 NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
                 [message addAttribute:NSFontAttributeName
                                 value:[UIFont fontWithName:@"comfortaa" size:15]
                                 range:NSMakeRange(0, message.length)];
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                 [alertController setValue:message forKey:@"attributedTitle"];                 [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                 [self presentViewController:alertController animated:YES completion:nil];
             }];
        }
    
}


-(void)didSuccess:(id)inResult;
{
    [self stopActivityIndicator];
    
    if(YES == [[inResult valueForKey:@"msg"] isEqualToString:@"Success"])
    {
        UIStoryboard *sb =[UIStoryboard storyboardWithName:@"ProfileCreation" bundle:nil];
        BUProfileHeritageVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUProfileHeritageVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
        [message addAttribute:NSFontAttributeName
                        value:[UIFont fontWithName:@"comfortaa" size:15]
                        range:NSMakeRange(0, message.length)];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController setValue:message forKey:@"attributedTitle"];        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

-(void)didFail:(id)inResult;
{
    [self startActivityIndicator:YES];
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
    [message addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:@"comfortaa" size:15]
                    range:NSMakeRange(0, message.length)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:message forKey:@"attributedTitle"];    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)alertMessage : (NSString *)message
{
    
    
    [[[UIAlertView alloc] initWithTitle:@"Alert"
                                message:[NSString stringWithFormat:@"Please Enter %@",message]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    
}

@end
