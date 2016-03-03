//
//  BUProfileOccupationInfoCell.m
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUProfileOccupationInfoCell.h"
#import "BUConstants.h"
@implementation BUProfileOccupationInfoCell

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



#pragma mark -Occupation

- (IBAction)employementStatusButtonTapped:(id)sender
{
    UIButton *employementStatusButton = (UIButton *)sender;
    
    switch (employementStatusButton.tag)
    {
        case EmployementStatusEmployed:
        {
            [self.employedBtn setSelected:YES];
            [self.othersBtn setSelected:NO];
            [self.unemployedBtn setSelected:NO];
            [self.studentBtn setSelected:NO];
            break;
        }
        case EmployementStatusUnEmployed:
        {
            [self.employedBtn setSelected:NO];
            [self.othersBtn setSelected:NO];
            [self.unemployedBtn setSelected:YES];
            [self.studentBtn setSelected:NO];
            break;
        }
        case EmployementStatusStudent:
        {
            [self.employedBtn setSelected:NO];
            [self.othersBtn setSelected:NO];
            [self.unemployedBtn setSelected:NO];
            [self.studentBtn setSelected:YES];
            break;
        }
        case EmployementStatusOthers:
        {
            [self.employedBtn setSelected:NO];
            [self.othersBtn setSelected:YES];
            [self.unemployedBtn setSelected:NO];
            [self.studentBtn setSelected:NO];
            break;
        }
        default: break;
    }
}
@end
