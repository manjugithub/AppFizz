//
//  BUConfigurationVC.h
//  TheBureau
//
//  Created by Manjunath on 01/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"

@interface BUConfigurationVC : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *activityView;
@property (atomic, assign) int activityIndicatorCount;

- (void)startActivityIndicator:(BOOL)isWhite;
- (void)stopActivityIndicator;

@end
