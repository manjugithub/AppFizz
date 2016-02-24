//
//  BUMatchPoolViewController.h
//  TheBureau
//
//  Created by Manjunath on 22/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"
#import "BUWebServicesManager.h"
#import "BUHomeTabbarController.h"
@interface BUMatchPoolViewController : BUBaseViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UICollisionBehaviorDelegate,BUWebServicesCallBack>

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;

-(void)getMatchPoolFortheDay;
@end

