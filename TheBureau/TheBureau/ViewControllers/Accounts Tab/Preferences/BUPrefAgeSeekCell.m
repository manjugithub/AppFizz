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
        if(1 == self.cellType)
        {
            self.shouldMoveRightView = NO;
            self.shouldMoveLeftView = NO;
        }
        else{
            self.shouldMoveLeftView = YES;
            self.shouldMoveRightView = NO;
        }
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
    
//    NSLog(@"Right constraint => %0.0f \n Left constraint = %0.0f",self.rightViewRightConstraint.constant,self.leftViewLeftConstraint.constant);
    
    UITouch *touch = [[event allTouches] anyObject];
    self.currentLocation = [touch locationInView:self.overLayView];
    
    CGFloat newX = self.currentLocation.x - self.prevLocation.x;
    
    if(self.shouldMoveLeftView)
    {
        CGRect frame = self.leftView.frame;
        frame.origin.x = frame.origin.x + newX;
        if(0 <= frame.origin.x && self.overLayView.frame.size.width >= (frame.origin.x + frame.size.width))
        {
//            NSLog(@"%0.0f is equal to %0.0f",self.currentLocation.x + (2 * self.interval),self.rightView.frame.origin.x);
            
            
            if(self.rightView.frame.origin.x - self.currentLocation.x > self.interval*3)
            {
                self.leftView.frame = frame;
                self.leftViewLeftConstraint.constant += newX;
                self.minLabelLeftConstraint.constant += newX;
                
                if(2 == self.cellType)
                {
                    CGFloat offset = (self.leftViewLeftConstraint.constant / self.interval)+1;
                    NSInteger feet =  4 + (NSInteger)offset / 12;
                    NSInteger inch =  (NSInteger)offset % 12 - 1;
                    inch = inch < 0 ? 0 : inch;
                    self.minFeet = feet;
                    self.minInch = inch;
                    self.minValueLabel.text = [NSString stringWithFormat:@"%ld' %ld\"",(long)feet,(long)inch];
                }
                else if(0 == self.cellType)
                {
                    self.minValueLabel.text = [NSString stringWithFormat:@"%0.0f",(self.leftViewLeftConstraint.constant / self.interval)+18];
                }
                
                
            }
            
            else
            {
                if(2 == self.cellType)
                {
                    NSInteger feet = 0;
                    NSInteger inch =  0;
                    inch = self.maxInch - 4;
                    
                    feet = inch < 0 ? self.maxFeet - 1 : self.maxFeet;
                    inch = inch < 0 ? inch + 12 : inch;
                    
                    self.minFeet = feet;
                    self.minInch = inch;
                    self.minValueLabel.text = [NSString stringWithFormat:@"%ld' %ld\"",(long)feet,(long)inch];
                }
                else if(0 == self.cellType)
                {
                    
                    self.minValueLabel.text = [NSString stringWithFormat:@"%0.0f",(self.maxValueLabel.text.intValue - 4.0)];
                }
            }
        }
        
    }
    else if(self.shouldMoveRightView)
    {
        
//        if(abs(self.rightViewRightConstraint.constant - self.leftViewLeftConstraint.constant) < )
        
        CGRect frame = self.rightView.frame;
        frame.origin.x = frame.origin.x + newX;
        if(0 <= frame.origin.x && self.overLayView.frame.size.width >= (frame.origin.x + frame.size.width))
        {
//            NSLog(@"%0.0f is equal to %0.0f",self.currentLocation.x - (2 * self.interval),(self.leftView.frame.origin.x + self.leftView.frame.size.width));
            
            if((self.currentLocation.x - (self.leftView.frame.origin.x + self.leftView.frame.size.width)) > self.interval*3)
            {
                self.rightView.frame = frame;
                self.rightViewRightConstraint.constant -= newX;
                self.maxLabelRightConstraint.constant -= newX;
                if(2 == self.cellType)
                {
                    CGFloat offset = (((self.overLayView.frame.size.width - self.rightViewRightConstraint.constant) / self.interval)+1);
                    NSInteger feet =  4 + (NSInteger)offset / 12;
                    NSInteger inch =  (NSInteger)offset % 12 - 1;
                    inch = inch < 0 ? 0 : inch;
                    self.maxFeet = feet;
                    self.maxInch = inch;
                    self.maxValueLabel.text = [NSString stringWithFormat:@"%ld' %ld\"",(long)feet,(long)inch];
                    
                    
                    [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.minFeet] forKey:@"height_from_feet"];
                    [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.minInch] forKey:@"height_from_inch"];
                    [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.maxFeet] forKey:@"height_to_feet"];
                    [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.maxInch] forKey:@"height_to_inch"];
                    
                }
                else if(1 == self.cellType)
                {
                    NSInteger currentValue = (((self.overLayView.frame.size.width - self.rightViewRightConstraint.constant) / self.interval)) * 25;
                    
                    
                    if(currentValue > 322)
                    {
                        self.maxValueLabel.text = @"No Limit";
                    }
                    else
                    {
                        NSLog(@"currentValue ====> %ld",(long)currentValue);
                        currentValue = currentValue - (currentValue % 25) ;
                        NSLog(@"Radius ====> %ld",(long)currentValue);
                        self.maxValueLabel.text = [NSString stringWithFormat:@"%ld",(long)currentValue];
                    }
                }
                else
                {
                    self.maxValueLabel.text = [NSString stringWithFormat:@"%0.0f",((self.overLayView.frame.size.width - self.rightViewRightConstraint.constant) / self.interval)+18];
                }
            }
            
            else
            {
                if(2 == self.cellType)
                {
                    NSInteger feet = 0;
                    NSInteger inch =  0;
                    inch = self.minInch + 4;
                    
                    feet = inch > 11 ? self.minFeet + 1 : self.minFeet;
                    inch = inch > 11 ? inch - 12 : inch;
                    
                    self.maxFeet = feet;
                    self.maxInch = inch;
                    self.maxValueLabel.text = [NSString stringWithFormat:@"%ld' %ld\"",(long)feet,(long)inch];
                }
                else if(0 == self.cellType)
                {
                    
                    self.maxValueLabel.text = [NSString stringWithFormat:@"%0.0f",(self.minValueLabel.text.intValue + 4.0)];
                }
            }
        }
    }
    
    self.prevLocation = self.currentLocation;
    
    
    if(2 == self.cellType)
    {
        [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.minFeet] forKey:@"height_from_feet"];
        [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.minInch] forKey:@"height_from_inch"];
        [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.maxFeet] forKey:@"height_to_feet"];
        [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.maxInch] forKey:@"height_to_inch"];
    }
    else if(0 == self.cellType)
    {
        [self.preferenceDict setValue:self.minValueLabel.text forKey:@"age_from"];
        [self.preferenceDict setValue:self.maxValueLabel.text forKey:@"age_to"];
    }
    else
    {
        if([self.maxValueLabel.text isEqualToString:@"No Limit"])
        {
            [self.preferenceDict setValue:@"325" forKey:@"location_radius"];
        }
        else
        {
            [self.preferenceDict setValue:self.maxValueLabel.text forKey:@"location_radius"];
        }
    }

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    if(2 == self.cellType)
    {
        [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.minFeet] forKey:@"height_from_feet"];
        [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.minInch] forKey:@"height_from_inch"];
        [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.maxFeet] forKey:@"height_to_feet"];
        [self.preferenceDict setValue:[NSString stringWithFormat:@"%ld",(long)self.maxInch] forKey:@"height_to_inch"];
    }
    else if(0 == self.cellType)
    {
        [self.preferenceDict setValue:self.minValueLabel.text forKey:@"age_from"];
        [self.preferenceDict setValue:self.maxValueLabel.text forKey:@"age_to"];
    }
    else
    {
        if([self.maxValueLabel.text isEqualToString:@"No Limit"])
        {
            [self.preferenceDict setValue:@"325" forKey:@"location_radius"];
        }
        else
        {
            [self.preferenceDict setValue:self.maxValueLabel.text forKey:@"location_radius"];
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self performSelector:@selector(setupInterval) withObject:nil afterDelay:0.5];
}

-(void)setDatasource:(NSMutableDictionary *)inDict
{
    self.preferenceDict = inDict;
    [self performSelector:@selector(updatePrefValues) withObject:nil afterDelay:0.5];
}


-(void)updatePointersForHeight
{

    NSInteger feet = [[self.preferenceDict valueForKey:@"height_from_feet"] intValue];
    NSInteger inch = [[self.preferenceDict valueForKey:@"height_from_inch"] intValue];
    self.minValueLabel.text = [NSString stringWithFormat:@"%ld' %ld\"",(long)feet,(long)inch];
    self.minFeet = feet;
    self.minInch = inch;

    NSInteger feet1 = [[self.preferenceDict valueForKey:@"height_to_feet"] intValue];
    NSInteger inch1 = [[self.preferenceDict valueForKey:@"height_to_inch"] intValue];
    self.maxValueLabel.text = [NSString stringWithFormat:@"%ld' %ld\"",(long)feet1,(long)inch1];

    self.maxFeet = feet1;
    self.maxInch = inch1;

    
    CGFloat newX1 = 0.0;
    CGFloat newX = newX1 + self.interval * (((feet - 4) *11 ) + inch);
    
    {
        CGRect frame = self.leftView.frame;
        frame.origin.x = newX;
        if(0 <= frame.origin.x && self.overLayView.frame.size.width >= (frame.origin.x + frame.size.width))
        {
            
            if(newX > (self.overLayView.frame.size.width - self.leftView.frame.size.width) - (self.interval * 4))
            {
                newX =  (self.overLayView.frame.size.width - self.leftView.frame.size.width) - (self.interval * 4);
            }

            
            [UIView animateWithDuration:0.6 animations:^{
                self.leftView.frame = frame;
                self.leftViewLeftConstraint.constant = newX;
                self.minLabelLeftConstraint.constant = newX;
            }completion:^(BOOL finished)
             {
                 [self layoutIfNeeded];

                 CGFloat newX2 = 0.0;
                 CGFloat newX = newX2 + self.interval * (((feet1 - 4) *11 ) + inch1);
                 CGRect frame = self.leftView.frame;
                 frame.origin.x = newX;
                 if(0 <= frame.origin.x && self.overLayView.frame.size.width >= (frame.origin.x + frame.size.width))
                 {
                     
                     if(newX < self.leftViewLeftConstraint.constant + (self.interval * 4))
                     {
                         newX = self.leftViewLeftConstraint.constant + (self.interval * 4);
                     }

                     [UIView animateWithDuration:0.6 animations:^{
                         self.rightViewRightConstraint.constant = self.overLayView.frame.size.width-newX - self.leftView.frame.size.width;
                         self.maxLabelRightConstraint.constant = self.overLayView.frame.size.width-newX - self.leftView.frame.size.width;
                     } completion:^(BOOL finished)
                     {
                         [self layoutIfNeeded];
                     }];
                     
                 }
             }
             ];
            
            
        }
    }
    
}

-(void)updatePointersForRadius
{
    NSInteger radius = [[self.preferenceDict valueForKey:@"location_radius"] intValue];
    NSLog(@"Radius ====> %ld",(long)radius);
    CGFloat newX =  (radius / 25) * self.interval;
    [UIView animateWithDuration:0.6 animations:^{
        self.rightViewRightConstraint.constant = self.overLayView.frame.size.width-newX;
        self.maxLabelRightConstraint.constant = self.overLayView.frame.size.width-newX;
    }completion:^(BOOL finished)
    {
        
        if(radius > 322)
        {
            self.maxValueLabel.text = @"No Limit";
        }
        else
        {
            self.maxValueLabel.text = [NSString stringWithFormat:@"%ld",(long)radius];
        }
    }];
}

-(void)updatePointersForAge

{
    NSInteger ageFrom = [[self.preferenceDict valueForKey:@"age_from"] intValue]-19;
    CGFloat newX1 = 0.0;
    CGFloat newX = newX1 + self.interval * ageFrom;
    
    CGRect frame = self.leftView.frame;
    frame.origin.x = newX;
    if(0 <= frame.origin.x && self.overLayView.frame.size.width >= (frame.origin.x + frame.size.width))
    {
        
        if(newX > (self.overLayView.frame.size.width - self.leftView.frame.size.width) - (self.interval * 4))
        {
            newX =  (self.overLayView.frame.size.width - self.leftView.frame.size.width) - (self.interval * 4);
        }

        [UIView animateWithDuration:0.6 animations:^{
            self.leftView.frame = frame;
            
            

            self.leftViewLeftConstraint.constant = newX;
            self.minLabelLeftConstraint.constant = newX;
        }completion:^(BOOL finished) {
            self.minValueLabel.text = [NSString stringWithFormat:@"%ld",(long)[[self.preferenceDict valueForKey:@"age_from"] intValue]];
            
            
            {
                
                NSInteger ageTo = [[self.preferenceDict valueForKey:@"age_to"] intValue] - 18;
                CGFloat newX12 = 0.0;
                CGFloat newX = newX12 + self.interval * ageTo;
                
                CGRect frame = self.rightView.frame;
                frame.origin.x = newX;
                if(0 <= frame.origin.x && self.overLayView.frame.size.width >= (frame.origin.x + frame.size.width))
                {
                    
                    if(newX < self.leftViewLeftConstraint.constant + (self.interval * 4))
                    {
                        newX = self.leftViewLeftConstraint.constant + (self.interval * 4);
                    }
                    [UIView animateWithDuration:0.6 animations:^{
                        self.rightView.frame = frame;
                        self.rightViewRightConstraint.constant = self.overLayView.frame.size.width-newX - self.leftView.frame.size.width;
                        self.maxLabelRightConstraint.constant = self.overLayView.frame.size.width-newX - self.leftView.frame.size.width;
                    }completion:^(BOOL finished) {
                        self.maxValueLabel.text = [NSString stringWithFormat:@"%ld",(long)[[self.preferenceDict valueForKey:@"age_to"] intValue]];
                    }];
                    
                    
                }
            }
        }];
        
        
        
    }
    self.prevLocation = self.currentLocation;
}



-(void)updatePrefValues
{
    
    if(1 == self.cellType)
    {
        NSInteger Radius = [[self.preferenceDict valueForKey:@"location_radius"] intValue];
        self.maxValueLabel.text = [NSString stringWithFormat:@"%ld",Radius];
        [self performSelector:@selector(updatePointersForRadius) withObject:nil afterDelay:0.0];

    }
    else if(0 == self.cellType)
    {
        
        NSInteger ageFrom = [[self.preferenceDict valueForKey:@"age_from"] intValue];
        self.minValueLabel.text = [NSString stringWithFormat:@"%ld",ageFrom];
        
        NSInteger ageTo = [[self.preferenceDict valueForKey:@"age_to"] intValue];
        self.maxValueLabel.text = [NSString stringWithFormat:@"%ld",ageTo];
        [self performSelector:@selector(updatePointersForAge) withObject:nil afterDelay:0.0];

    }
    else
    {
        
        NSInteger feet = [[self.preferenceDict valueForKey:@"height_from_feet"] intValue];
        NSInteger inch = [[self.preferenceDict valueForKey:@"height_from_inch"] intValue];
        self.minValueLabel.text = [NSString stringWithFormat:@"%ld' %ld\"",(long)feet,(long)inch];
    
        self.minFeet = feet;
        self.minInch = inch;

        NSInteger feet1 = [[self.preferenceDict valueForKey:@"height_to_feet"] intValue];
        NSInteger inch1 = [[self.preferenceDict valueForKey:@"height_to_inch"] intValue];
        self.maxFeet = feet1;
        self.maxInch = inch1;

        self.maxValueLabel.text = [NSString stringWithFormat:@"%ld' %ld\"",(long)feet1,(long)inch1];

        [self performSelector:@selector(updatePointersForHeight) withObject:nil afterDelay:0.0];
    }
}

-(void)setupInterval
{
    if(2 == self.cellType)
    {
        self.interval = self.overLayView.frame.size.width / 35.0;
    }
    else if(1 == self.cellType)
    {
        self.interval = self.overLayView.frame.size.width / 13.0;
    }
    else
    {
        self.interval = self.overLayView.frame.size.width / 22.0;
//        [self setminAge:15 maxAge:34];
    }
}



@end
