//
//  BUHomeViewController.h
//  TheBureau
//
//  Created by Manjunath on 08/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"
#import "BUWebServicesManager.h"
#import "BURightBtnView.h"
#import "BUHomeTabbarController.h"
@interface BUHomeViewController : BUBaseViewController<UITableViewDataSource,UITableViewDelegate>

-(IBAction)flagUSer:(id)sender;
@end
