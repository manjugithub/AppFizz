//
//  BUProfileSocialHabitsInfoCell.m
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileSocialHabitsInfoCell.h"
#import "BUConstants.h"
@implementation BUProfileSocialHabitsInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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


@end
