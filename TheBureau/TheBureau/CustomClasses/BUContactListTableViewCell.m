//
//  BUContactListTableViewCell.m
//  TheBureau
//
//  Created by Accion Labs on 26/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUContactListTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation BUContactListTableViewCell

-(void)setContactListDataSource:(BUChatContact *)inContact
{
    self.userName.text = [NSString stringWithFormat:@"%@ %@",inContact.fName,inContact.lName];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:inContact.imgURL]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        
    }];
}

@end
