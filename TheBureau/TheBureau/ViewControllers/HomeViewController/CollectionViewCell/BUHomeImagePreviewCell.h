//
//  BUHomeImagePreviewCell.h
//  TheBureau
//
//  Created by Manjunath on 08/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface BUHomeImagePreviewCell : UICollectionViewCell
@property(nonatomic, strong) IBOutlet UIImageView *profileImgView;
@property(nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicatorView;

-(void)setImageURL:(NSString *)inImageURL;
@end
