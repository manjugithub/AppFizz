//
//  PWInAppHelper.m
//  PerfectWellness
//
//  Created by Manjunath on 4/22/15.
//
//

#import "PWInAppHelper.h"

@implementation PWInAppHelper


/*
 
 [NSSet setWithObjects:
 @"com.bureau.bureauapp.100goldcoins",
 @"com.bureau.bureauapp.250goldcoins",
 @"com.bureau.bureauapp.300goldcoins",
 @"com.bureau.bureauapp.500goldcoins",
 @"com.bureau.bureauapp.750goldcoins",
 @"com.bureau.bureauapp.1000goldcoins",nil]
 
 */

+ (PWInAppHelper *)sharedInstance {
    static dispatch_once_t once;
    static PWInAppHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.bureau.bureauapp.100goldcoins",
                                      @"com.bureau.bureauapp.250goldcoins",
                                      @"com.bureau.bureauapp.300goldcoins",
                                      @"com.bureau.bureauapp.500goldcoins",
                                      @"com.bureau.bureauapp.750goldcoins",
                                      @"com.bureau.bureauapp.1000goldcoins",nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
