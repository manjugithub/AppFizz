//
//  Message.h
//  Whatsapp
//
//  Created by Rafael Castro on 6/16/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUConstants.h"


@interface Message : NSObject

@property (assign, nonatomic) MessageSender sender;
@property (assign, nonatomic) MessageStatus status;
@property (strong, nonatomic) NSString *text,*senderID,*senderName;
@property (strong, nonatomic) NSString *profileImgURL;
@property (strong, nonatomic) NSDate *sent;

@end


