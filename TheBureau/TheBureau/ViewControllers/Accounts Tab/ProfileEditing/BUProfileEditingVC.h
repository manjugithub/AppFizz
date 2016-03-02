//
//  BUProfileEditingVC.h
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"
#import "BUWebServicesManager.h"

@interface BUProfileEditingVC : BUBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;
@property(nonatomic , strong) IBOutlet UITableView *profileTableView;
@property(nonatomic , assign) NSInteger currentSelectedTab,previousSelectedTab;

-(void)expandProfileTab:(NSInteger)inTabIndex;
-(void)collapseProfileTab:(NSInteger)inTabIndex;
- (IBAction)editProfileDetails:(id)sender;

@end
