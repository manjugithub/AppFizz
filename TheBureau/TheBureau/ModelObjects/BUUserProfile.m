//
//  BUUserProfile.m
//  TheBureau
//
//  Created by Accion Labs on 29/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUUserProfile.h"

@implementation BUUserProfile

/*
 College = "test test test ";
 "Company Name" = "test test ";
 "Country Residing" = India;
 "Date of Birth" = "31-January-1921";
 "Diet Preference" = "Non Vegetarian";
 Education = Bachelors;
 "First Name" = Lionel;
 Gender = Male;
 Honors = "test test test test ";
 "Last Name" = Messi;
 "Legal Status" = "Citizen/Green Card";
 Major = "test test test test ";
 "Marital Status" = "Never Married";
 "Mother Tongue" = English;
 "Position Title" = "test test test test test ";
 "Religion Name" = Hinduism;
 "Year of Passing" = 1988;
 "Years in USA" = "0 - 2";
 "height_feet" = 5;
 "height_inch" = 7;
 userid = 16;
 */


- (instancetype)initWithUserProfile:(NSDictionary *)inUserProfileDict;
{
    
    self = [super init];
    if (self) {
        
        self.firstName = inUserProfileDict[@"First Name"];
        self.gender   = inUserProfileDict[@"Gender"];
        self.lastName  = inUserProfileDict[@"Last Name"];
        self.userID = inUserProfileDict[@"userid"];
        self.motherTongue = inUserProfileDict[@"Mother Tongue"];
        self.DOB = inUserProfileDict[@"Date of Birth"];
        self.postionTitle = inUserProfileDict[@"Position Title"];
        self.heightInch = inUserProfileDict[@"height_inch"];
        self.heightFeet = inUserProfileDict[@"height_feet"];
        self.yearsInUSA = inUserProfileDict[@"Years in USA"];
        self.yearOfPassing = inUserProfileDict[@"Year of Passing"];
        self.religionName = inUserProfileDict[@"Religion Name"];
        self.maritalStatus = inUserProfileDict[@"Marital Status"];
        self.companyName = inUserProfileDict[@"Company Name"];
        self.legalStatus = inUserProfileDict[@"Legal Status"];
        self.honors = inUserProfileDict[@"Honors"];
        self.major = inUserProfileDict[@"Major"];
        self.dietPreference = inUserProfileDict[@"Diet Preference"];
        self.education = inUserProfileDict[@"Education"];
        self.countryResiding = inUserProfileDict[@"Country Residing"];
        self.college = inUserProfileDict[@"College"];
        self.imageUrl = inUserProfileDict[@"img_url"];
        self.userAction = inUserProfileDict[@"user_action"];

        
    }
    return self;
    
    
    
    
}
@end
