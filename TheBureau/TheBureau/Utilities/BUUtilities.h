//
//  BUUtilities.h
//  TheBureau
//
//  Created by Manjunath on 26/11/15.
//  Copyright © 2015 Bureau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BUUtilities : NSObject

+(void)testFontFamily;
+(void)setNavBarLogo:(UINavigationController *)innavContrlr image:(UIImage *)inImage;
+(void)removeLogo:(UINavigationController *)innavContrlr;
@end
