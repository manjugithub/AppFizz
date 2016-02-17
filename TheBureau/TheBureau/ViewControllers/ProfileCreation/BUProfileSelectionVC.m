//
//  BUProfileSelectionVC.m
//  TheBureau
//
//  Created by Manjunath on 25/01/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileSelectionVC.h"
#import "BUProfileDetailsVC.h"


@interface BUProfileSelectionVC ()<UIActionSheetDelegate>
@property(nonatomic,weak) IBOutlet UITextField *firstNameTF;
@property(nonatomic,weak) IBOutlet UITextField *lastNameTF;
@property(nonatomic)IBOutlet UITextField *currentTextField;

@property (weak, nonatomic) IBOutlet UILabel *relationLabel;

@property(nonatomic,strong)NSArray* relationCircle;

-(IBAction)continueClicked:(id)sender;
-(void)viewPopOnBackButton;

@end

@implementation BUProfileSelectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Profile Creation";
    
    _relationCircle = [NSArray arrayWithObjects:@"Father",@"Mother",@"Family member", @"Friend", @"Sister", @"Brother",@"Self",nil];

    
    self.firstNameTF.leftViewMode = UITextFieldViewModeAlways;
    self.firstNameTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_user"]];
    
    
    self.lastNameTF.leftViewMode = UITextFieldViewModeAlways;
    self.lastNameTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_user"]];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
  
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:self action:@selector(viewPopOnBackButton)];

    
    self.navigationItem.leftBarButtonItem = backButton;
    
 
}

- (void) hideKeyboard {
    
    [self.currentTextField resignFirstResponder];
    
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dropDownBtn:(id)sender{
    
    if([self.currentTextField isFirstResponder]){
        [self.currentTextField resignFirstResponder];
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
        
        self.firstNameTF.text = self.firstName;
        self.lastNameTF.text = self.lastName;
    }
    else{
        
        self.firstNameTF.text = nil;
        self.lastNameTF.text = nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)continueClicked:(id)sender
{
    
    if (![self.firstNameTF.text length])
    {
        [self alertMessage:@"First Name"];
    }
    else if (![self.lastNameTF.text length])
    {
        [self alertMessage:@"Last Name"];
    }
    else if (![self.relationLabel.text length])
    {
        [self alertMessage:@"Relation"];
    }
      else
      {
        
          UIStoryboard *sb =[UIStoryboard storyboardWithName:@"ProfileCreation" bundle:nil];
          BUProfileDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUProfileDetailsVC"];
          [self.navigationController pushViewController:vc animated:YES];
        
    }

   
}
    
    -(void)alertMessage : (NSString *)message
    {
        
        
        [[[UIAlertView alloc] initWithTitle:@"Alert"
                                    message:[NSString stringWithFormat:@"Please Enter %@",message]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        
    }

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    

    [textField resignFirstResponder];
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    
    self.currentTextField = textField;
 
    
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


@end
