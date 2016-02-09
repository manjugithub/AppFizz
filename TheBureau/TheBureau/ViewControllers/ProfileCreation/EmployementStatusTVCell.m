//
//  EmployementStatusCellTableViewCell.m
//  SampleUI
//
//  Created by Sarath Neeravallil Sasi on 04/02/16.
//  Copyright © 2016 Sarath Neeravallil Sasi. All rights reserved.
//

#import "EmployementStatusTVCell.h"

#define UNEMPLOYEDYCONSTANTBEFOREDETAILVIEW  4.0
#define UNEMPLOYEDYCONSTANTAFTERDETAILVIEW   94.0

typedef NS_ENUM (NSInteger, EmployementStatus)
{
    EmployementStatusEmployed,
    EmployementStatusUnEmployed,
    EmployementStatusStudent,
    EmployementStatusOthers
};

@implementation EmployementStatusTVCell

- (void)awakeFromNib
{
    self.unemployedYConstraint.constant = UNEMPLOYEDYCONSTANTBEFOREDETAILVIEW;
    self.employmentDetailView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

- (IBAction)employementStatusButtonTapped:(id)sender
{
    UIButton *employementStatusButton = (UIButton *)sender;
    
    switch (employementStatusButton.tag)
    {
        case EmployementStatusEmployed:
        {
            self.unemployedYConstraint.constant = UNEMPLOYEDYCONSTANTAFTERDETAILVIEW;
            self.employmentDetailView.hidden = NO;
            
            [self.employedBtn setSelected:YES];
            [self.othersBtn setSelected:NO];
            [self.unemployedBtn setSelected:NO];
            [self.studentBtn setSelected:NO];


            [self.delegate updateEmployementCellHeightForEmployed];

            break;
        }
        case EmployementStatusUnEmployed:
        {
            if(!self.employmentDetailView.hidden)
            {
                self.unemployedYConstraint.constant = UNEMPLOYEDYCONSTANTBEFOREDETAILVIEW;
                self.employmentDetailView.hidden = YES;
              

                [self.delegate updateEmployementCellHeightForOthers];
            }
            [self.employedBtn setSelected:NO];
            [self.othersBtn setSelected:NO];
            [self.unemployedBtn setSelected:YES];
            [self.studentBtn setSelected:NO];
            break;
        }
        case EmployementStatusStudent:
        {
            if(!self.employmentDetailView.hidden)
            {
                self.unemployedYConstraint.constant = UNEMPLOYEDYCONSTANTBEFOREDETAILVIEW;
                self.employmentDetailView.hidden = YES;
                
              

                [self.delegate updateEmployementCellHeightForOthers];
            }
            [self.employedBtn setSelected:NO];
            [self.othersBtn setSelected:NO];
            [self.unemployedBtn setSelected:NO];
            [self.studentBtn setSelected:YES];
            break;
        }
        case EmployementStatusOthers:
        {
            if(!self.employmentDetailView.hidden)
            {
                self.unemployedYConstraint.constant = UNEMPLOYEDYCONSTANTBEFOREDETAILVIEW;
                self.employmentDetailView.hidden = YES;
                
                [self.delegate updateEmployementCellHeightForOthers];
            }
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
