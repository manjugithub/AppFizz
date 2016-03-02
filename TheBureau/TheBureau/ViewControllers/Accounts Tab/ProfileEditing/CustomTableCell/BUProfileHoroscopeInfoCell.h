//
//  BUProfileHoroscopeInfoCell.h
//  TheBureau
//
//  Created by Manjunath on 25/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUProfileEditingVC.h"

@interface BUProfileHoroscopeInfoCell : UITableViewCell<UITextFieldDelegate>
@property(weak, nonatomic) IBOutlet BUProfileEditingVC *parentVC;

@end
