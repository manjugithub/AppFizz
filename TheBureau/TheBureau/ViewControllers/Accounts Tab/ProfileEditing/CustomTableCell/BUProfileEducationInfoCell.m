//
//  BUProfileEducationInfoCell.m
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileEducationInfoCell.h"

@implementation BUProfileEducationInfoCell

- (void)awakeFromNib {
    // Initialization code
    _educationLevelArray = [[NSArray alloc]initWithObjects:@"Post Graduate",@"Bachelor's",@"12th",@"10th", nil];
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        if(actionSheet.tag == 101)
            self.educationlevelLbl.text = _educationLevelArray[buttonIndex - 1];
        else if(actionSheet.tag == 102)
            self.educationlevelLbl2.text = _educationLevelArray[buttonIndex - 1];
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
    
    [acSheet showInView:self.parentVC.view];
    
}



-(IBAction)selectSecondaryEducationLevel{
    UIActionSheet *acSheet = [[UIActionSheet alloc] initWithTitle:@"Select Education Level" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    
    acSheet.tag = 102;
    for (NSString *str in _educationLevelArray)
    {
        [acSheet addButtonWithTitle:str];
    }
    
    [acSheet showInView:self.parentVC.view];
    
}@end
