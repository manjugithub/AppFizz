//
//  ViewController.h
//  QuickStart
//
//  Created by Abir Majumdar on 12/3/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LayerKit/LayerKit.h>
#import "BUBaseViewController.h"
#import "BUImagePreviewVC.h"
@class BUChattingCell;
@interface LQSViewController : BUBaseViewController

@property (nonatomic) LYRClient *layerClient;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableBottomConstraint;

@property (nonatomic, weak) IBOutlet UIButton *sendButton;
@property (nonatomic, weak) IBOutlet UITextView *inputTextView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *typingIndicatorLabel;
@property (nonatomic, weak) IBOutlet UIImageView *messageImageView;
@property (nonatomic, strong) NSString *recipientName;
@property (nonatomic, strong) NSString *recipientID;
@property (nonatomic, strong) NSString *recipientDPURL;
@property (nonatomic) LYRConversation *conversation;
@property (nonatomic, weak) IBOutlet UIButton *profileImageBtn;
@property (nonatomic, weak) IBOutlet UIView *backButtoonView;
@property(nonatomic,weak)IBOutlet UIImageView *userImageView;

- (IBAction)showProfile:(UIBarButtonItem *)sender;
- (IBAction)clearButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cameraButtonPressed:(UIButton *)sender;
- (IBAction)goBack:(UIBarButtonItem *)sender;
- (IBAction)deletePhotoAtIndex:(NSIndexPath *)inIndexPath;
-(void)showPreview:(LYRMessage *)lyrMessage withCell:(BUChattingCell *)inCell;
@property(weak, nonatomic) BUImagePreviewVC *imagePreviewVC;

@end
