//
//  BUProfileHoroscopeInfoCell.m
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileHoroscopeInfoCell.h"
#import "UIView+FLKAutoLayout.h"

@implementation BUProfileHoroscopeInfoCell

- (void)awakeFromNib
{
    // Initialization code
    self.aboutMeTextView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.aboutMeTextView.layer.borderWidth = 1.0;
    self.aboutMeTextView.layer.cornerRadius = 5.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    [self showKeyBoard:NO];
}

-(void)showKeyBoard:(BOOL)inBool
{
//    CGFloat constant = 0;
//    if(NO == inBool)
//    {
//        constant = 58;
//    }
//    else
//    {
//        constant = 320;
//    }
//    
//    self.textViewBottomConstraint.constant = constant;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.horoscopeDict setValue:textField.text forKey:@"horoscope_lob"];
}


- (void)textViewDidEndEditing:(UITextView *)textView;
{
    [self.horoscopeDict setValue:textView.text forKey:@"about_me"];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    textView.text = [textView.text stringByReplacingOccurrencesOfString:@"Your text here ..." withString:@""];
    [self showKeyBoard:YES];
    return YES;
}

-(void)setDatasource:(NSMutableDictionary *)inBasicInfoDict
{

    self.horoscopeDict = inBasicInfoDict;
    
   self.dobLabel.text  = [inBasicInfoDict valueForKey:@"horoscope_dob"];
   self.tobLabel.text  = [inBasicInfoDict valueForKey:@"horoscope_tob"];
   self.locLabel.text  = [inBasicInfoDict valueForKey:@"horoscope_lob"];
   self.aboutMeTextView.text  = [inBasicInfoDict valueForKey:@"about_me"];
//    [inBasicInfoDict valueForKey:@"horoscope_path"];
    
    
}

-(void)updateProfile
{
    
}

-(IBAction)setDOB:(id)sender
{
    
    [self.parentVC.view endEditing:YES];
    
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
            [dateFormat setDateFormat:@"MM-dd-yyyy"];
            NSString *dateString = [dateFormat stringFromDate:picker.date];
            self.dobLabel.text = dateString;
            [self.horoscopeDict setValue:dateString forKey:@"horoscope_dob"];
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
    [self.parentVC presentViewController:alertController  animated:YES completion:nil];
}
-(IBAction)setTOB:(id)sender
{
    
    [self.parentVC.view endEditing:YES];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Time of Birth\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
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
    

    picker.date = currentDate;
    picker.datePickerMode = UIDatePickerModeTime;
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
            NSLog(@"%@",picker.date);
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"HH:MM:ss"];
            NSString *dateString = [dateFormat stringFromDate:picker.date];
            self.tobLabel.text = dateString;
            [self.horoscopeDict setValue:dateString forKey:@"horoscope_tob"];
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
    [self.parentVC presentViewController:alertController  animated:YES completion:nil];
}
-(IBAction)uploadHoroscope:(id)sender
{
    
         UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [[self parentVC] presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [[BUWebServicesManager sharedManager] uploadHoroscope:[info objectForKey:UIImagePickerControllerEditedImage]];

    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end