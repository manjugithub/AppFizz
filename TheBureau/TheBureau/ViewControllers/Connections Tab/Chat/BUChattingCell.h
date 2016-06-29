//
//  BUChattingCell.h
//  TheBureau
//
//  Created by Manjunath on 27/06/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LayerKit/LayerKit.h>
#import "BUBaseViewController.h"
#import "UIImageView+WebCache.h"
//#import "Message.h"
//#import "LYRMessage.h"
//#import "LYRMessagePart.h"
@class LQSViewController;
@interface BUChattingCell : UITableViewCell


@property(nonatomic,weak) IBOutlet UIImageView *bgImgView, *mataDataImgView, *statusIconImgView;
@property(nonatomic,assign) LYRMessage *lyrMessage;
@property(nonatomic,weak) IBOutlet UITextView *messageTxtView;
@property(nonatomic,weak) IBOutlet UILabel *timeStampLabel;
@property(nonatomic,weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic,weak) LQSViewController *parentVC;



-(void)setDataSourceForReceiver:(LYRMessage *)inLayerMessage;
-(void)setDataSourceForSender:(LYRMessage *)inLayerMessage;;
@end
