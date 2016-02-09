//
//  BUHomeCollectionVC.h
//  TheBureau
//
//  Created by Manjunath on 09/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUHomeCollectionVC : UIViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UICollisionBehaviorDelegate>

@property(nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end
