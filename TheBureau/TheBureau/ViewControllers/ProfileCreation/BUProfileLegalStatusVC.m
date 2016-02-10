//
//  BUProfileLegalStatusVC.m
//  TheBureau
//
//  Created by Manjunath on 25/01/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileLegalStatusVC.h"
#import "BUHomeTabbarController.h"


@interface BUProfileLegalStatusVC ()

@property(nonatomic,weak) IBOutlet UIButton *twoYearBtn;
@property(nonatomic,weak) IBOutlet UIButton *two_sixYearBtn;
@property(nonatomic,weak) IBOutlet UIButton *sixPlusYearBtn;
@property(nonatomic,weak) IBOutlet UIButton *bornAndRaisedBtn;

@property(nonatomic,weak) IBOutlet UIButton *US_CitizenBtn;
@property(nonatomic,weak) IBOutlet UIButton *greenCardBtn;
@property(nonatomic,weak) IBOutlet UIButton *greenCardProcessingBtn;
@property(nonatomic,weak) IBOutlet UIButton *h1VisaBtn;
@property(nonatomic,weak) IBOutlet UIButton *othersBtn;
@property(nonatomic,weak) IBOutlet UIButton *studentVisaBtn;





@end

@implementation BUProfileLegalStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Legal Status";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)setYearsInUs:(id)sender{
    
    UIButton *setYearBtn = (UIButton *)sender;
    
    if (setYearBtn.tag == 1) {
        
        [_twoYearBtn setSelected:YES];
        [_sixPlusYearBtn setSelected:NO];
        [_two_sixYearBtn setSelected:NO];
        [_bornAndRaisedBtn setSelected:NO];

    }
    else if (setYearBtn.tag == 2){
        
        [_twoYearBtn setSelected:NO];
        [_sixPlusYearBtn setSelected:NO];
        [_two_sixYearBtn setSelected:YES];
        [_bornAndRaisedBtn setSelected:NO];
        
    }
    else if (setYearBtn.tag == 3){
        
        [_twoYearBtn setSelected:NO];
        [_sixPlusYearBtn setSelected:YES];
        [_two_sixYearBtn setSelected:NO];
        [_bornAndRaisedBtn setSelected:NO];
        
    }
    else{
        [_twoYearBtn setSelected:NO];
        [_sixPlusYearBtn setSelected:NO];
        [_two_sixYearBtn setSelected:NO];
        [_bornAndRaisedBtn setSelected:YES];
        
        
    }
    
    
    
}

-(IBAction)setLegalStatus:(id)sender{
  
    UIButton *setLegalStatusBtn = (UIButton *)sender;

    if (setLegalStatusBtn.tag == 1) {
        [_US_CitizenBtn setSelected:YES];
        [_greenCardBtn setSelected:NO];
        [_greenCardProcessingBtn setSelected:NO];
        [_studentVisaBtn setSelected:NO];
        [_h1VisaBtn setSelected:NO];
        [_othersBtn setSelected:NO];

        
    }
    else if (setLegalStatusBtn.tag == 2){
        [_US_CitizenBtn setSelected:NO];
        [_greenCardBtn setSelected:YES];
        [_greenCardProcessingBtn setSelected:NO];
        [_studentVisaBtn setSelected:NO];
        [_h1VisaBtn setSelected:NO];
        [_othersBtn setSelected:NO];
        

        
    }
    else if (setLegalStatusBtn.tag == 3){
        
        [_US_CitizenBtn setSelected:NO];
        [_greenCardBtn setSelected:NO];
        [_greenCardProcessingBtn setSelected:YES];
        [_studentVisaBtn setSelected:NO];
        [_h1VisaBtn setSelected:NO];
        [_othersBtn setSelected:NO];
        

        
    }
    else if (setLegalStatusBtn.tag == 4){
        
        [_US_CitizenBtn setSelected:NO];
        [_greenCardBtn setSelected:NO];
        [_greenCardProcessingBtn setSelected:NO];
        [_studentVisaBtn setSelected:YES];
        [_h1VisaBtn setSelected:NO];
        [_othersBtn setSelected:NO];
        

        
    }
    else if (setLegalStatusBtn.tag == 5){
        
        [_US_CitizenBtn setSelected:NO];
        [_greenCardBtn setSelected:NO];
        [_greenCardProcessingBtn setSelected:NO];
        [_studentVisaBtn setSelected:NO];
        [_h1VisaBtn setSelected:YES];
        [_othersBtn setSelected:NO];
        
        
    }

    else{
        [_US_CitizenBtn setSelected:NO];
        [_greenCardBtn setSelected:NO];
        [_greenCardProcessingBtn setSelected:NO];
        [_studentVisaBtn setSelected:NO];
        [_h1VisaBtn setSelected:NO];
        [_othersBtn setSelected:YES];
        
        
    }

    
}

-(IBAction)continueClicked:(id)sender
{
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    BUHomeTabbarController *vc = [sb instantiateViewControllerWithIdentifier:@"BUHomeTabbarController"];
    [self.navigationController pushViewController:vc animated:YES];
    
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
