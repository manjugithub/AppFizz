//
//  BUChattingCell.m
//  TheBureau
//
//  Created by Manjunath on 27/06/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUChattingCell.h"
#import "Message.h"
#import "BULayerHelper.h"
#import "LQSViewController.h"
@implementation BUChattingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setImageURL:(NSURL *)inImageURL;
{
    [self.activityIndicatorView startAnimating];
    self.activityIndicatorView.hidden = NO;
    
    [self.mataDataImgView sd_setImageWithURL:inImageURL
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         
         [self.activityIndicatorView stopAnimating];
         self.activityIndicatorView.hidden = YES;
     }];
    
    

}


-(void)setDataSourceForReceiver:(LYRMessage *)inLayerMessage
{
    self.bgImgView.image = [[UIImage imageNamed:@"bubbleSomeone"]
                            stretchableImageWithLeftCapWidth:21 topCapHeight:14];
    
    [self setupData:inLayerMessage];
    
}
-(void)setDataSourceForSender:(LYRMessage *)inLayerMessage
{
    self.bgImgView.image = [[UIImage imageNamed:@"bubbleMine"]
                            stretchableImageWithLeftCapWidth:15 topCapHeight:14];
    [self setupData:inLayerMessage];    
}



-(void)setupData:(LYRMessage *)inLayerMessage
{
    self.lyrMessage = inLayerMessage;
    
    self.mataDataImgView.image = nil;
    self.messageTxtView.text = @"";
    self.timeStampLabel.text = @"";
    LYRMessagePart *messagePart = inLayerMessage.parts[0];
    
    if ([messagePart.MIMEType isEqualToString:@"image/png"])
    {
        [self confirgurePhoto:inLayerMessage];
    }
    else
    {
        [self confirgureText:inLayerMessage];
    }

    
    switch ([inLayerMessage recipientStatusForUserID:[[BULayerHelper sharedHelper] participantUserID]]) {
        case LYRRecipientStatusPending:
            [self.statusIconImgView setImage:nil];
            self.timeStampLabel.text = @"Pending";
            break;
        case LYRRecipientStatusSent:
            [self.statusIconImgView setImage:[UIImage imageNamed:@"status_sent"]];
            [self setTimeStamp:@"Sent: " andDate:inLayerMessage.sentAt];
            break;
            
        case LYRRecipientStatusDelivered:
            [self setTimeStamp:@"Delivered: " andDate:inLayerMessage.sentAt];
            [self.statusIconImgView setImage:[UIImage imageNamed:@"status_notified"]];
            break;
            
        case LYRRecipientStatusRead:
            [self.statusIconImgView setImage:[UIImage imageNamed:@"status_read"]];
            [self setTimeStamp:@"Read: " andDate:inLayerMessage.receivedAt];
            
            break;
            
        case LYRRecipientStatusInvalid:
            NSLog(@"Participant: Invalid");
            break;
            
        default:
            break;
    }

}

-(void)confirgureText:(LYRMessage *)inLayerMessage
{
    
    LYRMessagePart *messagePart = inLayerMessage.parts[0];
    Message *message = [[Message alloc] init];
    message.text = [[NSString alloc]initWithData:messagePart.data
                                        encoding:NSUTF8StringEncoding];
    message.sent = [inLayerMessage sentAt];

    self.messageTxtView.text = message.text;
    
    //Set Text to Label
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeStyle = NSDateFormatterShortStyle;
    df.dateStyle = kCFDateFormatterShortStyle;
    df.doesRelativeDateFormatting = YES;
    self.timeStampLabel.text = [df stringFromDate:message.sent];
}


-(void)setTimeStamp:(NSString *)inMessage andDate:(NSDate *)inDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeStyle = NSDateFormatterShortStyle;
    df.dateStyle = kCFDateFormatterShortStyle;
    df.doesRelativeDateFormatting = YES;
    self.timeStampLabel.text = [NSString stringWithFormat:@"%@%@",inMessage,[df stringFromDate:inDate]];
}

-(void)confirgurePhoto:(LYRMessage *)inLayerMessage
{
    LYRMessagePart *messagePart = inLayerMessage.parts[0];
    Message *message = [[Message alloc] init];
    
    [self setImageURL:messagePart.fileURL];
    message.sent = [inLayerMessage sentAt];
    
    //Set Text to Label
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeStyle = NSDateFormatterShortStyle;
    df.dateStyle = kCFDateFormatterShortStyle;
    df.doesRelativeDateFormatting = YES;
    self.timeStampLabel.text = [df stringFromDate:message.sent];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    
    LYRMessagePart *messagePart = self.lyrMessage.parts[0];
    
    if ([messagePart.MIMEType isEqualToString:@"image/png"])
    {
        [self.parentVC showPreview:self.lyrMessage withCell:self];
    }
}

@end
