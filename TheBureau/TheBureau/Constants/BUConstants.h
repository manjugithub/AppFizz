//
//  BUConstants.h
//  TheBureau
//
//  Created by Manjunath on 26/11/15.
//  Copyright © 2015 Bureau. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLoginTopLayoutOffset 130

#define kSignupTopLayoutOffset 80

#define kAnimationDuration 0.5


typedef NS_ENUM(NSInteger,ButtonType){
    ButtonTypeVegetarian,
    ButtonTypeEegetarian,
    ButtonTypeNonvegetarian,
    ButtonTypeVegan
    
};


typedef NS_ENUM (NSInteger, EmployementStatus)
{
    EmployementStatusEmployed,
    EmployementStatusUnEmployed,
    EmployementStatusStudent,
    EmployementStatusOthers
};
