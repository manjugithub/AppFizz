//
//  BUChattinProfileDetailsVC.h
//  TheBureau
//
//  Created by Manjunath on 21/06/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"

@interface BUChattinProfileDetailsVC : BUBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray *imagesList;
@property(nonatomic, strong) NSMutableDictionary *datasourceList;
@end
