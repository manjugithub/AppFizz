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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.delegate slideTableUp];
   return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self.delegate slideTableDown];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.delegate slideTableDown];
    [self endEditing:YES];
}

@end
