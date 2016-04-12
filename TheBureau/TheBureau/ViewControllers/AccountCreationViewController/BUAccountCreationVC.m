//
//  BUAccountCreationVC.m
//  TheBureau
//
//  Created by Manjunath on 01/12/15.
//  Copyright © 2015 Bureau. All rights reserved.
//

#import "BUAccountCreationVC.h"
#import "BUProfileDetailsVC.h"
#import "UIView+FLKAutoLayout.h"

@interface BUAccountCreationVC ()<UIActionSheetDelegate>


@property(nonatomic,weak) IBOutlet UITextField *firstNameTF;
@property(nonatomic,weak) IBOutlet UITextField *lastNameTF;

@property(nonatomic,weak) IBOutlet UITextField *emailIdTF;
@property(nonatomic,weak) IBOutlet UITextField *mobileNumTF;
@property(nonatomic,weak) IBOutlet UITextField *dateofbirthTF;

@property(nonatomic,weak) IBOutlet UIImageView *femaleImgView,*maleImgView;
@property(nonatomic,weak) IBOutlet UIButton *genderSelectionBtn;

@property (nonatomic, assign) CGSize keyboardSize;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;
@property (nonatomic, strong) UIView *keyboarAccessoryview;


@property(nonatomic) eNavigatedFrom navFrom;
-(IBAction)setGender:(id)sender;
-(IBAction)setDOB:(id)sender;
-(IBAction)continueButtonClicked:(id)sender;
@end

@implementation BUAccountCreationVC


-(IBAction)dropDownBtn:(id)sender
{
    [self.view endEditing:YES];

    
    if([self.currentTextField isFirstResponder]){
        [self.currentTextField resignFirstResponder];
    }
    
if([self.firstNameTF.text isEqualToString:@""] || [self.lastNameTF.text isEqualToString:@""])
{
    [self alertMessage:@"First name and last name"];
    return;
}

    
    UIActionSheet *acSheet = [[UIActionSheet alloc] initWithTitle:@"Select Relationship" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    
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
        self.relationLabel.text = _relationCircle[buttonIndex - 1];
    }
    if ([self.relationLabel.text isEqualToString:@"Self"]) {
        
        self.profileFirstNameTF.text = self.firstNameTF.text;
        self.profileLastNameTF.text = self.lastNameTF.text;
    }
    else{
        
        self.profileFirstNameTF.text = nil;
        self.profileLastNameTF.text = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Account Creation";
    
    _relationCircle = [NSArray arrayWithObjects:@"Father",@"Mother",@"Family member", @"Friend", @"Sister", @"Brother",@"Self",nil];
    
    
    UIImageView * leftView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,25,25)];
    leftView1.image =  [UIImage imageNamed:@"ic_user"];
    leftView1.contentMode = UIViewContentModeCenter;
    self.profileFirstNameTF.leftView = leftView1;
    self.profileFirstNameTF.leftViewMode = UITextFieldViewModeAlways;
    self.profileFirstNameTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    
    UIImageView * leftView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,25,25)];
    leftView2.image =  [UIImage imageNamed:@"ic_user"];
    leftView2.contentMode = UIViewContentModeCenter;
    
    
    self.profileLastNameTF.leftViewMode = UITextFieldViewModeAlways;
    self.profileLastNameTF.leftView = leftView2;
    self.profileLastNameTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // Do any additional setup after loading the view.
    
    
    
    UIImageView * leftView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,25,25)];
    leftView3.image =  [UIImage imageNamed:@"ic_user"];
    leftView3.contentMode = UIViewContentModeCenter;
    self.firstNameTF.leftView = leftView3;
    self.firstNameTF.leftViewMode = UITextFieldViewModeAlways;
    self.firstNameTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    UIImageView * leftView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,25,25)];
    leftView4.image =  [UIImage imageNamed:@"ic_user"];
    leftView4.contentMode = UIViewContentModeCenter;
    self.lastNameTF.leftView = leftView4;
    self.lastNameTF.leftViewMode = UITextFieldViewModeAlways;
    self.lastNameTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    
    
    //    self.lastNameTF.leftViewMode = UITextFieldViewModeAlways;
    //    self.lastNameTF.leftView = leftView;
    //    self.lastNameTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_user"]];
    
    UIImageView * leftView5 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,25,25)];
    leftView5.image =  [UIImage imageNamed:@"ic_email"];
    leftView5.contentMode = UIViewContentModeCenter;
    self.emailIdTF.leftView = leftView5;
    self.emailIdTF.leftViewMode = UITextFieldViewModeAlways;
    self.emailIdTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    UIImageView * leftView6 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,25,25)];
    leftView6.image =  [UIImage imageNamed:@"ic_mobile"];
    leftView6.contentMode = UIViewContentModeCenter;
    self.mobileNumTF.leftView = leftView6;
    self.mobileNumTF.leftViewMode = UITextFieldViewModeAlways;
    self.mobileNumTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    UIImageView * leftView7 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,25,25)];
    leftView7.image =  [UIImage imageNamed:@"ic_dob"];
    leftView7.contentMode = UIViewContentModeCenter;
    self.dateofbirthTF.leftView = leftView7;
    self.dateofbirthTF.leftViewMode = UITextFieldViewModeAlways;
    self.dateofbirthTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.scrollview addGestureRecognizer:gestureRecognizer];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:self action:@selector(viewPopOnBackButton)];
    
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.genderSelectionBtn.tag = 0;
    
    // Do any additional setup after loading the view.
}


- (void) hideKeyboard {
    
    [self.currentTextField resignFirstResponder];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self.scrollview setContentOffset:CGPointZero animated:YES];
    
    if (self.socialChannel.profileDetails.firstName != nil) {
        self.firstNameTF.text = [NSString stringWithFormat:@" %@",self.socialChannel.profileDetails.firstName];
    }
    if (self.socialChannel.profileDetails.lastName != nil) {
        self.lastNameTF.text = [NSString stringWithFormat:@" %@",self.socialChannel.profileDetails.lastName];
    }
    if (self.socialChannel.emailID != nil) {
        self.emailIdTF.text = [NSString stringWithFormat:@" %@",self.socialChannel.emailID];
    }
    if (self.socialChannel.mobileNumber != nil) {
        self.mobileNumTF.text = [NSString stringWithFormat:@" %@",self.socialChannel.mobileNumber];

    }
    if (self.socialChannel.profileDetails.dob != nil) {
        self.dateofbirthTF.text = [NSString stringWithFormat:@" %@",self.socialChannel.profileDetails.dob];
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
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

-(IBAction)setGender:(id)sender
{
    [self.view endEditing:YES];

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

-(IBAction)setDOB:(id)sender
{
    
}

- (void)adjustScrollViewOffsetToCenterTextField:(UITextField *)textField
{
    CGRect textFieldFrame = textField.frame;
    
    CGPoint buttonOrigin = textFieldFrame.origin;
    
    CGFloat buttonHeight = textFieldFrame.size.height;
    
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= _keyboardSize.height+100;
    
    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
        
        [self.scrollview setContentOffset:scrollPoint animated:YES];
        
        
    }
    
    
    
}
//- (void)keyboardWillHide:(NSNotification *)notification {
//    self.keyboardSize = CGSizeZero;
//    
//    [self.scrollview setContentOffset:CGPointZero animated:YES];
//    
//}
//
//- (void)textFieldGotFocus:(UITextField *)sender {
//    sender.inputAccessoryView = self.keyboarAccessoryview;
//    self.currentTextField = sender;
//    [self adjustScrollViewOffsetToCenterTextField:sender];
//}
//
//- (void)keyboardWillShow:(NSNotification *)notification {
//    NSDictionary *info = [notification userInfo];
//    NSValue *keyBoardEndFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyboardSize = [keyBoardEndFrame CGRectValue].size;
//    self.keyboardSize = keyboardSize;
//    
//    CGPoint textFieldOrigin = self.currentTextField.frame.origin;
//    
//    CGFloat textfieldHeight = self.currentTextField.frame.size.height;
//    
//    CGRect visibleRect = self.scrollview.frame;
//    
//    visibleRect.size.height -= _keyboardSize.height+100;
//    
//    if (!CGRectContainsPoint(visibleRect, textFieldOrigin)){
//        
//        CGPoint scrollPoint = CGPointMake(0.0, textFieldOrigin.y - visibleRect.size.height + textfieldHeight);
//        
//        [self.scrollview setContentOffset:scrollPoint animated:YES];
//        
//        
//    }
//    
//    
//}
//
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//{
//    
//    [self textFieldGotFocus:textField];
//    
//   }
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
//{
//    
//
//    return YES;
//    
//    
//}
-(IBAction)dateofbirthBtn:(id)sender
{
    
    [self.view endEditing:YES];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Birthday\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    [picker setDatePickerMode:UIDatePickerModeDate];
    [alertController.view addSubview:picker];
    
    [picker alignCenterYWithView:alertController.view predicate:@"0.0"];
    [picker alignCenterXWithView:alertController.view predicate:@"0.0"];
    [picker constrainWidth:@"270" ];
//
       
   

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:1];
    [comps setYear:1990];
    NSDate *currentDate = [[NSCalendar currentCalendar] dateFromComponents:comps];

    
    
    NSDate *todayDate = [NSDate date];
    NSDate *newDate = [todayDate dateByAddingTimeInterval:(-1*18*365*24*60*60)];
    picker.maximumDate = newDate;
    picker.date = currentDate;
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            NSLog(@"%@",picker.date);
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"MM/dd/yyyy"];
            NSString *dateString = [dateFormat stringFromDate:picker.date];
            self.dateofbirthTF.text = [NSString stringWithFormat:@"  %@",dateString];
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
    
  
//    NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint constraintWithItem:picker attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:alertController.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//    
//    [alertController.view addConstraint:xCenterConstraint];
//    
//    NSLayoutConstraint *yCenterConstraint = [NSLayoutConstraint constraintWithItem:picker attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:alertController.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
//    
//    [alertController.view addConstraint:yCenterConstraint];
    
//    [alertController.view addConstraint:[NSLayoutConstraint constraintWithItem:picker attribute: NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150.0]];
//    
//    [alertController.view addConstraint:[NSLayoutConstraint constraintWithItem:picker attribute: NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute: NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150.0]];
    
    

}
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    
    self.currentTextField = textField;
    self.scrollBottomConstraint.constant = 250;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.scrollBottomConstraint.constant = 0;
    [self.currentTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.currentTextField resignFirstResponder];
    self.scrollBottomConstraint.constant = 0;
    return YES;
}


-(void)alertMessage : (NSString *)message
{
    
    
    [[[UIAlertView alloc] initWithTitle:@"Alert"
                                message:[NSString stringWithFormat:@"Please Enter %@",message]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];

}

-(void)viewPopOnBackButton {
    
    [self.view endEditing:YES];
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Do you wish to leave this appication? Your Information has not been saved"];
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


#pragma mark - Web services handler

-(IBAction)continueButtonClicked:(id)sender;
{
    [self.view endEditing:YES];

    if (![self.firstNameTF.text length]) {
        [self alertMessage:@"First Name"];
    }
    else if (![self.lastNameTF.text length]){
        [self alertMessage:@"Last Name"];
    }
    else if (![self.dateofbirthTF.text length]){
        
        [self alertMessage:@"Date Of Birth"];
    }
    else if (![self.mobileNumTF.text length]){
        [self alertMessage:@"Mobile Number"];
        
    }
    else if (![self.emailIdTF.text length]){
        
        [self alertMessage:@"Email Address"];
        
    }
    else if (![self.relationLabel.text length]){
        
        [self alertMessage:@"Relationship"];
        
    }
    else if (![self.profileFirstNameTF.text length]){
        
        [self alertMessage:@"Profile First Name"];
        
    }
    else if (![self.profileLastNameTF.text length]){
        
        [self alertMessage:@"Profile Last Name"];
        
    }
    else
    {
        /*
         
         userid => User's ID
         first_name => First name of account holder
         last_name => Last name of account holder
         dob => Date of birth (dd-mm-yyyy)
         gender => Gender - enum('Male', 'Female')
         phone_number => Phone number of account holder
         email => Email of account holder
         */
        
        
        NSDictionary *parameters = nil;
        
        parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                       @"first_name":self.firstNameTF.text,
                       @"last_name":self.lastNameTF.text,
                       @"profile_first_name":self.profileFirstNameTF.text,
                       @"profile_last_name":self.profileLastNameTF.text,
                       @"profile_for":self.relationLabel.text,
                       @"dob":self.dateofbirthTF.text,
                       @"gender":self.genderSelectionBtn.tag == 1 ? @"Male" : @"Female",
                       @"phone_number":self.mobileNumTF.text,
                       @"email":self.emailIdTF.text
                       };
        
        
        [BUWebServicesManager sharedManager].userName = [NSString stringWithFormat:@"%@ %@",self.firstNameTF.text,self.lastNameTF.text];

        [self startActivityIndicator:YES];
        
        [[BUWebServicesManager sharedManager] queryServer:parameters
                                                  baseURL:@"http://app.thebureauapp.com/admin/create_account_ws"
                                             successBlock:^(id response, NSError *error) {
                                                 [self stopActivityIndicator];
                                                 UIStoryboard *sb =[UIStoryboard storyboardWithName:@"ProfileCreation" bundle:nil];
                                                 BUProfileDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUProfileDetailsVC"];
                                                 [self.navigationController pushViewController:vc animated:YES];
                                                 
                                             } failureBlock:^(id response, NSError *error) {
                                                 [self stopActivityIndicator];
                                                 NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Bureau Server Error"];
                                                 [message addAttribute:NSFontAttributeName
                                                                 value:[UIFont fontWithName:@"comfortaa" size:15]
                                                                 range:NSMakeRange(0, message.length)];
                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                                                 [alertController setValue:message forKey:@"attributedTitle"];            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                                                 [self presentViewController:alertController animated:YES completion:nil];
                                             }
         ];
        
    }
}
    


@end
