//
//  BUMyProfile.m
//  TheBureau
//
//  Created by Manjunath on 09/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUMyProfile.h"

@implementation BUMyProfile

/*
@property(nonatomic, strong) NSString *yearsInUSA,*userStatus,*specID,*smoking,*drinking,*religionID;
@property(nonatomic, strong) NSString *profile_last_name,*profile_gender,*profile_for,*profile_first_name,*profile_dob,*position_title;
@property(nonatomic, strong) NSString *phone_number,*other_legal_status,*mother_tongue_id,*maritial_status,*major,*longitude;
@property(nonatomic, strong) NSString *legal_status,*latitude,*last_name,*honors,*highest_education,*height_inch;
@property(nonatomic, strong) NSString *height_feet,*graduated_year,*gothra,*gender,*first_name,*family_origin_id;
@property(nonatomic, strong) NSString *employment_status,*email,*dob,*diet,*current_zip_code,*created_by;
@property(nonatomic, strong) NSString *country_residing,*company,*college;
*/

- (instancetype)initWithProfileDetails:(NSDictionary *)profDict
{
    self = [super init];
    if (self) {
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
        [profDict valueForKey:@""] != nil ? [profDict valueForKey:@""] : @"";
    }
    return self;
}

@end
