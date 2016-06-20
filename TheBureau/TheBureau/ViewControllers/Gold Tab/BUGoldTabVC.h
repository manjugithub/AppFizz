//
//  BUGoldTabVC.h
//  TheBureau
//
//  Created by Manjunath on 07/03/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"
#import "BUWebServicesManager.h"
#import "BUHomeTabbarController.h"
@interface BUGoldTabVC : BUBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSIndexPath *selectedIndexPath;



-(void)showSuccessMessageWithGold:(NSInteger)purchasedGold;
-(void)updateGold:(NSInteger)purchasedGold;
@end
