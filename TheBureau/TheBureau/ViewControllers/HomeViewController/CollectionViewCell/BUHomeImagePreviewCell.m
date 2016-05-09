//
//  BUHomeImagePreviewCell.m
//  TheBureau
//
//  Created by Manjunath on 08/02/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUHomeImagePreviewCell.h"

@implementation BUHomeImagePreviewCell


-(void)awakeFromNib
{
//    self.profileImgView.layer.cornerRadius = 5.0;
//    self.profileImgView.layer.borderColor = [[UIColor blackColor] CGColor];
//    self.profileImgView.layer.borderWidth = 2.0;
//    self.overLayView = [[UIImageView alloc] init];
//    self.overLayView.contentMode = UIViewContentModeScaleToFill;
//    [self.contentView insertSubview:self.overLayView belowSubview:self.profileImgView];
    
//    self.profileImgView.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)setFrameRect:(CGRect)inRect
{
    NSLog(@"colection size ==> %@",NSStringFromCGRect(inRect));
    self.contentView.frame = inRect;
    self.profileImgView.frame = inRect;
}

-(void)layoutSubviews
{
//    NSLog(@"colection size ==> %@",NSStringFromCGRect(self.contentView.bounds));
}

-(void)setImageURL:(NSString *)inImageURL;
{
    [self.activityIndicatorView startAnimating];
    self.activityIndicatorView.hidden = NO;
    
    [self.profileImgView sd_setImageWithURL:[NSURL URLWithString:inImageURL]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {

                                      [self.activityIndicatorView stopAnimating];
                                      self.activityIndicatorView.hidden = YES;
         
//         [self performSelector:@selector(blur:) withObject:image afterDelay:0.1];
         
                                  }];
}


- (void) blur:(UIImage*)theImage
{
    // ***********If you need re-orienting (e.g. trying to blur a photo taken from the device camera front facing camera in portrait mode)
    // theImage = [self reOrientIfNeeded:theImage];
    
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];//create a UIImage for this function to "return" so that ARC can manage the memory of the blur... ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    self.overLayView.image = returnImage;
    
}

@end
