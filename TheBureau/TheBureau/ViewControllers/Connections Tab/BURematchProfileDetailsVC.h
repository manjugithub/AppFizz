//
//  BURematchProfileDetailsVC.h
//  TheBureau
//
//  Created by Manjunath on 07/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"
#import "BUWebServicesManager.h"

@interface BURematchProfileDetailsVC : BUBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray *imagesList;
@property(nonatomic, strong) NSDictionary *datasourceList;
@end
