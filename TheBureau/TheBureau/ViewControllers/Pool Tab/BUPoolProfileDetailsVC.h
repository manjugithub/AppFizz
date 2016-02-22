//
//  BUPoolProfileDetailsVC.h
//  TheBureau
//
//  Created by Manjunath on 22/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"

@interface BUPoolProfileDetailsVC : BUBaseViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UICollisionBehaviorDelegate>

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end
