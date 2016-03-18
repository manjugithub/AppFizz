//
//  BUConfigurationVC.h
//  TheBureau
//
//  Created by Manjunath on 01/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"
@class BUAppNotificationCell;

@interface BUConfigurationVC : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *activityView;
@property (atomic, assign) int activityIndicatorCount;
@property (weak, nonatomic) IBOutlet BUAppNotificationCell *cell1,*cell2,*cell3,*cell4,*cell5;

- (void)startActivityIndicator:(BOOL)isWhite;
- (void)stopActivityIndicator;

@end
