//
//  HighLevelEducationTVCell.m
//  SampleUI
//
//  Created by Sarath Neeravallil Sasi on 04/02/16.
//  Copyright © 2016 Sarath Neeravallil Sasi. All rights reserved.
//

#import "HighLevelEducationTVCell.h"

@implementation HighLevelEducationTVCell

- (void)awakeFromNib
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)addSecondLevelButtonTapped:(id)sender
{
    [self.delegate addNextLevelButtonTapped];
}

- (IBAction)HighLevelEducationButtonTapped:(id)sender
{
    [self.delegate updateHighLevelEducationTVCell :_indexpath];
}

@end
