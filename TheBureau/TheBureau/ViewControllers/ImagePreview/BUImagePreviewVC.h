//
//  BUImagePreviewVC.h
//  TheBureau
//
//  Created by Manjunath on 01/04/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"

@class LQSViewController;
@interface BUImagePreviewVC : BUBaseViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UICollisionBehaviorDelegate>

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *imagesList;
@property(nonatomic, strong) NSIndexPath *indexPathToScroll,*currentIndex;
@property(nonatomic, assign) BOOL isHoroscope;
@property(nonatomic, weak) LQSViewController *chatVC;
@end
