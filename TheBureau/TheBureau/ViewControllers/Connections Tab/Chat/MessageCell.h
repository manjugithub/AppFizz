//
//  MessageCell.h
//  Whatsapp
//
//  Created by Rafael Castro on 6/16/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageCell : UITableViewCell

//Store message
@property (strong, nonatomic) Message *message;


@property (nonatomic, weak) IBOutlet UIImageView *messageStatus;

- (void)updateWithImage:(UIImage *)image;
- (void)removeImage;

//Estimate BubbleCell Height
-(CGFloat)height;

//Estimate BubbleCell Witdh
-(CGFloat)width;

-(void)updateStatus;
@end
