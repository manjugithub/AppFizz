//
//  BUHomeTabbarController.h
//  TheBureau
//
//  Created by Manjunath on 08/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURightBtnView.h"
@interface BUHomeTabbarController : UITabBarController

@property(nonatomic,strong) BURightBtnView *rightBtnView;

-(void)updateGoldValue:(NSInteger)inGoldValue;
@end
