//
//  BUProfileDietVCViewController.m
//  TheBureau
//
//  Created by Accion Labs on 11/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileDietVC.h"
#import "BUProfileOccupationVC.h"
#import "BUConstants.h"


    
    
    

@interface BUProfileDietVC ()
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


@property(nonatomic, strong) NSString *dieting,*smoke,*drink;

@end

@implementation BUProfileDietVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Social Habits";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:self action:@selector(viewPopOnBackButton)];
    
    
    self.dieting = @"Vegetarian";
    self.drink = @"Social";
    self.smoke = @"No";

    
    self.navigationItem.leftBarButtonItem = backButton;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)setDiet:(id)sender{
    
    UIButton *dietButton = (UIButton *)sender;
    switch (dietButton.tag)
    {
        case ButtonTypeVegetarian:
        {
            
            [_vegetarianBtn setSelected:YES];
            [_eegetarianBtn setSelected:NO];
            [_nonVegetarianBtn setSelected:NO];
            [_veganBtn setSelected:NO];
            self.dieting = @"Vegetarian";
            break;
        }
        case ButtonTypeEegetarian:
        {
            
            [_vegetarianBtn setSelected:NO];
            [_eegetarianBtn setSelected:YES];
            [_nonVegetarianBtn setSelected:NO];
            [_veganBtn setSelected:NO];
            self.dieting = @"Eggetarian";
            break;
        }
        case ButtonTypeNonvegetarian:
        {
            
            [_vegetarianBtn setSelected:NO];
            [_eegetarianBtn setSelected:NO];
            [_nonVegetarianBtn setSelected:YES];
            [_veganBtn setSelected:NO];
            self.dieting = @"Non Vegetarian";
            break;
        }
        default:
        {
            [_vegetarianBtn setSelected:NO];
            [_eegetarianBtn setSelected:NO];
            [_nonVegetarianBtn setSelected:NO];
            [_veganBtn setSelected:YES];
            self.dieting = @"Vegan";
            break;
        }
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
        self.smoke = @"Socially";
    }
    else
    {
        self.drinkingSelectionBtn.tag = 0;
        _sociallyLabel.textColor = [UIColor blackColor];
        _neverLabel.textColor = [UIColor lightGrayColor];
        self.smoke = @"Never";
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
        self.smoke = @"Yes";
    }
    else
    {
        self.smokingSelectionBtn.tag = 0;
        _yesLabel.textColor = [UIColor lightGrayColor];
        _noLabel.textColor = [UIColor blackColor];
        self.smoke = @"No";
        switchBtnStr = @"switch_OFF";
    }
    
    [self.smokingSelectionBtn setBackgroundImage:[UIImage imageNamed:switchBtnStr]
                                         forState:UIControlStateNormal];
    
}



-(IBAction)continueClicked:(id)sender
{
  /*
    API to  upload :
http://app.thebureauapp.com/admin/update_profile_step4
    
    Parameter
    userid => user id of user
    diet => e.g. Vegetarian, Eggetarian, Non Vegetarian
    drinking => e.g. Socially, Never
    smoking => e.g. Yes, No
*/
    NSDictionary *parameters = nil;
    parameters = @{@"userid": [BUWebServicesManager sharedManager].userID,
                   @"diet":self.dieting,
                   @"drinking":self.drink,
                   @"smoking":self.smoke
                   };

    
    [self startActivityIndicator:YES];
    [[BUWebServicesManager sharedManager]queryServer:parameters
                                             baseURL:@"http://app.thebureauapp.com/admin/update_profile_step4"
                                        successBlock:^(id response, NSError *error)
     {
         [self stopActivityIndicator];
         UIStoryboard *sb =[UIStoryboard storyboardWithName:@"ProfileCreation" bundle:nil];
         BUProfileOccupationVC *vc = [sb instantiateViewControllerWithIdentifier:@"BUProfileOccupationVC"];
         [self.navigationController pushViewController:vc animated:YES];
         
     }
                                        failureBlock:^(id response, NSError *error)
    {
        [self stopActivityIndicator];
        
        [self showFailureAlert];
    }];
    
    
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
