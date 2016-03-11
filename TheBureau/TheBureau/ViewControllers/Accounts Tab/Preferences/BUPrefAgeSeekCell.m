//
//  BUPrefAgeSeekCell.m
//  TheBureau
//
//  Created by Manjunath on 07/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUPrefAgeSeekCell.h"

@implementation BUPrefAgeSeekCell

- (void)awakeFromNib {
    // Initialization code

    self.leftView.layer.cornerRadius = self.leftView.frame.size.width/2.0;
    self.rightView.layer.cornerRadius = self.rightView.frame.size.width/2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    self.prevLocation = [touch locationInView:self.overLayView];
    if(CGRectContainsPoint(self.leftView.frame, self.prevLocation))
    {
        self.shouldMoveLeftView = YES;
        self.shouldMoveRightView = NO;
    }
    else if(CGRectContainsPoint(self.rightView.frame, self.prevLocation))
    {
        self.shouldMoveLeftView = NO;
        self.shouldMoveRightView = YES;
    }
    else
    {
        self.shouldMoveRightView = NO;
        self.shouldMoveLeftView = NO;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    self.currentLocation = [touch locationInView:self.overLayView];
    
    CGFloat newX = self.currentLocation.x - self.prevLocation.x;
    
    if(self.shouldMoveLeftView)
    {
        CGRect frame = self.leftView.frame;
        frame.origin.x = frame.origin.x + newX;
        if(0 <= frame.origin.x && self.overLayView.frame.size.width >= (frame.origin.x + frame.size.width))
        {
            self.leftView.frame = frame;
            self.leftViewLeftConstraint.constant += newX;
            self.minLabelLeftConstraint.constant += newX;
            
            if(2 == self.cellType)
            {
                CGFloat offset = (self.leftViewLeftConstraint.constant / self.interval)+1;
                NSInteger feet =  4 + (NSInteger)offset / 12;
                NSInteger inch =  (NSInteger)offset % 12;
                self.minValueLabel.text = [NSString stringWithFormat:@"%ld' %ld\"",(long)feet,(long)inch];
            }
            else
            {

            self.minValueLabel.text = [NSString stringWithFormat:@"%0.0f",(self.leftViewLeftConstraint.constant / self.interval)+1];
            }
        }
    }
    else if(self.shouldMoveRightView)
    {
        CGRect frame = self.rightView.frame;
        frame.origin.x = frame.origin.x + newX;
        if(0 <= frame.origin.x && self.overLayView.frame.size.width >= (frame.origin.x + frame.size.width))
        {
            self.rightView.frame = frame;
            self.rightViewRightConstraint.constant -= newX;
            self.maxLabelRightConstraint.constant -= newX;
            
            if(2 == self.cellType)
            {
                CGFloat offset = (((self.overLayView.frame.size.width - self.rightViewRightConstraint.constant) / self.interval)+1);
                NSInteger feet =  4 + (NSInteger)offset / 12;
                NSInteger inch =  (NSInteger)offset % 12;
                self.maxValueLabel.text = [NSString stringWithFormat:@"%ld' %ld\"",(long)feet,(long)inch];
            }
            else
            {
                self.maxValueLabel.text = [NSString stringWithFormat:@"%0.0f",((self.overLayView.frame.size.width - self.rightViewRightConstraint.constant) / self.interval)+1];
            }
        }
    }
    
    self.prevLocation = self.currentLocation;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSDictionary *prefDict1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"Preferences"];
    
    NSMutableDictionary *prefDict = [[NSMutableDictionary alloc]initWithDictionary:prefDict1];

    if(2 == self.cellType)
    {
        
    }
    else if(0 == self.cellType)
    {
        [prefDict setValue:self.minValueLabel.text forKey:@"age_from"];
        [prefDict setValue:self.minValueLabel.text forKey:@"age_to"];
    }
    else
    {
        [prefDict setValue:self.minValueLabel.text forKey:@"location_radius"];
    }
    [[NSUserDefaults standardUserDefaults] setValue:prefDict forKey:@"Preferences"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self performSelector:@selector(setupInterval) withObject:nil afterDelay:2.0];
}


-(void)setupInterval
{
    if(2 == self.cellType)
    {
        self.interval = self.overLayView.frame.size.width / 35.0;
    }
    else if(1 == self.cellType)
    {
        self.interval = self.overLayView.frame.size.width / 50.0;
    }
    else
    {
        self.interval = self.overLayView.frame.size.width / 40;
    }
}

@end
