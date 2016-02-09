//
//  BUAccountCreationVC.m
//  TheBureau
//
//  Created by Manjunath on 01/12/15.
//  Copyright © 2015 Bureau. All rights reserved.
//

#import "BUAccountCreationVC.h"
#import "BUProfileSelectionVC.h"
#import "UIView+FLKAutoLayout.h"

@interface BUAccountCreationVC ()


@property(nonatomic,weak) IBOutlet UITextField *firstNameTF;
@property(nonatomic,weak) IBOutlet UITextField *lastNameTF;

@property(nonatomic,weak) IBOutlet UITextField *emailIdTF;
@property(nonatomic,weak) IBOutlet UITextField *mobileNumTF;
@property(nonatomic,weak) IBOutlet UITextField *dateofbirthTF;

@property(nonatomic,weak) IBOutlet UIImageView *femaleImgView,*maleImgView;
@property(nonatomic,weak) IBOutlet UIButton *genderSelectionBtn;

@property (nonatomic, assign) CGSize keyboardSize;
@property (nonatomic, strong) UITextField *currentTextField;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;
@property (nonatomic, strong) UIView *keyboarAccessoryview;


@property(nonatomic) eNavigatedFrom navFrom;
-(IBAction)setGender:(id)sender;
-(IBAction)setDOB:(id)sender;
-(IBAction)signUpBtnClicked:(id)sender;
@end

@implementation BUAccountCreationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Account Creation";
    
    self.firstNameTF.leftViewMode = UITextFieldViewModeAlways;
    self.firstNameTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_user"]];
    
    
    self.lastNameTF.leftViewMode = UITextFieldViewModeAlways;
    self.lastNameTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_user"]];
    
    self.emailIdTF.leftViewMode = UITextFieldViewModeAlways;
    self.emailIdTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_email"]];
    
    self.mobileNumTF.leftViewMode = UITextFieldViewModeAlways;
    self.mobileNumTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_mobile"]];
    
    self.dateofbirthTF.leftViewMode = UITextFieldViewModeAlways;
    self.dateofbirthTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_dob"]];
    
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.scrollview addGestureRecognizer:gestureRecognizer];

    
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
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

-(IBAction)setDOB:(id)sender
{
    
}
-(IBAction)signUpBtnClicked:(id)sender
{
//    
//    if (![self.firstNameTF.text length]) {
//        [self alertMessage:@"First Name"];
//        }
//    else if (![self.lastNameTF.text length]){
//        [self alertMessage:@"Last Name"];
//    }
//    else if (![self.dateofbirthTF.text length]){
//        
//        [self alertMessage:@"Date Of Birth"];
//    }
//    else if (![self.mobileNumTF.text length]){
//        [self alertMessage:@"Mobile Number"];
//        
//    }
//    else if (![self.emailIdTF.text length]){
//        
//        [self alertMessage:@"Email Address"];
//        
//    }
//    else
    {
    
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"ProfileCreation" bundle:nil];
    BUProfileSelectionVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUProfileSelectionVC"];
    [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


- (void)adjustScrollViewOffsetToCenterTextField:(UITextField *)textField
{
    CGRect textFieldFrame = textField.frame;
    //    float keyboardHeight = MIN(self.keyboardSize.width, self.keyboardSize.height);
    //
    //    float visibleScrollViewHeight = self.scrollview.frame.size.height - keyboardHeight+60;
    //    float offsetInScrollViewCoords = (visibleScrollViewHeight / 2) - (textFieldFrame.size.height / 2);
    //
    //    scrollViewOffset = textFieldFrame.origin.y - offsetInScrollViewCoords;
    
    CGPoint buttonOrigin = textFieldFrame.origin;
    
    CGFloat buttonHeight = textFieldFrame.size.height;
    
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= _keyboardSize.height+100;
    
    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
        
        [self.scrollview setContentOffset:scrollPoint animated:YES];
        
        
    }
    
    
    
}
- (void)keyboardWillHide:(NSNotification *)notification {
    self.keyboardSize = CGSizeZero;
    
    [self.scrollview setContentOffset:CGPointZero animated:YES];
    
}

- (void)textFieldGotFocus:(UITextField *)sender {
    sender.inputAccessoryView = self.keyboarAccessoryview;
    self.currentTextField = sender;
    [self adjustScrollViewOffsetToCenterTextField:sender];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *keyBoardEndFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [keyBoardEndFrame CGRectValue].size;
    self.keyboardSize = keyboardSize;
    
    CGPoint textFieldOrigin = self.currentTextField.frame.origin;
    
    CGFloat textfieldHeight = self.currentTextField.frame.size.height;
    
    CGRect visibleRect = self.scrollview.frame;
    
    visibleRect.size.height -= _keyboardSize.height+100;
    
    if (!CGRectContainsPoint(visibleRect, textFieldOrigin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, textFieldOrigin.y - visibleRect.size.height + textfieldHeight);
        
        [self.scrollview setContentOffset:scrollPoint animated:YES];
        
        
    }
    
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    
    [self textFieldGotFocus:textField];
    
   }

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    

    return YES;
    
    
}
-(IBAction)dateofbirthBtn:(id)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Birthday\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    [picker setDatePickerMode:UIDatePickerModeDate];
    [alertController.view addSubview:picker];
    [picker alignCenterYWithView:alertController.view predicate:@"0.0"];
    [picker alignCenterXWithView:alertController.view predicate:@"0.0"];
    [picker constrainWidth:@"270" ];
    
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
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.currentTextField resignFirstResponder];
    
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
@end
