//
//  BULoginViewController.h
//  TheBureau
//
//  Created by Manjunath on 26/11/15.
//  Copyright © 2015 Bureau. All rights reserved.
//

#import "BUBaseViewController.h"
#import "BUWebServicesManager.h"
#import "BUSocialChannel.h"
@interface BULoginViewController : BUBaseViewController<BUWebServicesCallBack>

@property(nonatomic, strong) BUSocialChannel *socialChannel;
@property(nonatomic, assign) eLoginType loginType;

@end
