//
//  BUHelpAndFeedbackVC.m
//  TheBureau
//
//  Created by Manjunath on 01/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUHelpAndFeedbackVC.h"

@interface BUHelpAndFeedbackVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomConstraint;
- (IBAction)sendFeedback:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;

@end

@implementation BUHelpAndFeedbackVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.feedbackTextView.layer.cornerRadius = 5.0;
    self.feedbackTextView.layer.borderWidth = 1.0;
}

- (void)didReceiveMemoryWarning
{
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

- (IBAction)sendFeedback:(id)sender
{
    [self.view endEditing:YES];
    [self showKeyBoard:NO];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Thak you!" message:@"We received your message and wll get back to you shortly" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");

            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        action;
    })];
    
    [self presentViewController:alertController  animated:YES completion:nil];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self showKeyBoard:NO];
}

-(void)showKeyBoard:(BOOL)inBool
{
    CGFloat constant = 0;
    if(NO == inBool)
    {
        constant = 58;
    }
    else
    {
        constant = 320;
    }
    
    self.textViewBottomConstraint.constant = constant;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    textView.text = [textView.text stringByReplacingOccurrencesOfString:@"Enter Your feedback here." withString:@""];
    [self showKeyBoard:YES];
    return YES;
}
@end
