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
    self.addEducationLevelBtn.hidden = YES;
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

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.educationLevel == 1)
    {
        switch(textField.tag)
        {
            case 0:
            {
                [self.dataSourceDict setValue:textField.text forKey:@"honors"];
                break;
            }
            case 1:
            {
                [self.dataSourceDict setValue:textField.text forKey:@"major"];
                break;
            }
            case 2:
            {
                [self.dataSourceDict setValue:textField.text forKey:@"college"];
                break;
            }
            case 3:
            {
                [self.dataSourceDict setValue:textField.text forKey:@"graduated_year"];
                break;
            }
        }
    }
    else
    {
        switch(textField.tag)
        {
            case 0:
            {
                [self.dataSourceDict setValue:textField.text forKey:@"honors_second"];
                break;
            }
            case 1:
            {
                [self.dataSourceDict setValue:textField.text forKey:@"majors_second"];
                break;
            }
            case 2:
            {
                [self.dataSourceDict setValue:textField.text forKey:@"college_second"];
                break;
            }
            case 3:
            {
                [self.dataSourceDict setValue:textField.text forKey:@"graduation_years_second"];
                break;
            }
        }
    }
    
    [textField resignFirstResponder];
    [self.delegate slideTableDown];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.delegate slideTableDown];
    [self endEditing:YES];
}

@end
