//
//  BUHomeImagePreviewCell.m
//  TheBureau
//
//  Created by Manjunath on 08/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUHomeImagePreviewCell.h"

@implementation BUHomeImagePreviewCell

-(void)setImageURL:(NSString *)inImageURL;
{
    [self.activityIndicatorView startAnimating];
    self.activityIndicatorView.hidden = NO;
    
    [self.profileImgView sd_setImageWithURL:[NSURL URLWithString:inImageURL]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                      [self.activityIndicatorView stopAnimating];
                                      self.activityIndicatorView.hidden = YES;
                                  }];
}
@end
