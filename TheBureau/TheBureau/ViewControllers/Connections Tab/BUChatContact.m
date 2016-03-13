//
//  BUChatContact.m
//  TheBureau
//
//  Created by Manjunath on 12/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUChatContact.h"

@implementation BUChatContact

/*

{
    "First Name" = test;
    "Last Name" = test;
    "img_url" = "http://app.thebureauapp.com/uploads/8/3314/images_2.jpg";
    userid = 7;
},

*/

- (instancetype)initWithDict:(NSDictionary *)inDictionary
{
    self = [super init];
    if (self)
    {
        self.fName = [inDictionary valueForKey:@"First Name"];
        self.lName = [inDictionary valueForKey:@"Last Name"];
        self.imgURL = [inDictionary valueForKey:@"img_url"];
        self.userID = [inDictionary valueForKey:@"userid"];
    }
    return self;
}
@end
