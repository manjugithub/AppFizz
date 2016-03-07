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
    self.minValueLabel.text = @"0";
    self.maxValueLabel.text = @"50";

    self.leftView.layer.cornerRadius = self.leftView.frame.size.width/2.0;
    self.rightView.layer.cornerRadius = self.rightView.frame.size.width/2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
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

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
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
            self.minValueLabel.text = [NSString stringWithFormat:@"%0.0f",(self.leftViewLeftConstraint.constant / self.interval)+1];
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
            
            self.maxValueLabel.text = [NSString stringWithFormat:@"%0.0f",((self.overLayView.frame.size.width - self.rightViewRightConstraint.constant) / self.interval)+1];
            
        }
    }
    
    self.prevLocation = self.currentLocation;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.interval = self.overLayView.frame.size.width / 50.0;
}


@end
