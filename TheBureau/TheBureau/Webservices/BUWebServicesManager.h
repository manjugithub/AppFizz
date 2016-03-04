//
//  BUWebServicesManager.h
//  TheBureau
//
//  Created by Manjunath on 25/01/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <LayerKit/LayerKit.h>


typedef void (^FailureBlock)(id response, NSError *error);
typedef void (^SuccessBlock)(id response, NSError *error);


@interface BUWebServicesManager : NSObject
@property (nonatomic, strong) NSString *userID;
//@property (nonatomic) LYRClient *layerClient;

+(instancetype)sharedManager;
-(void)signUpWithDelegeatewithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;
-(void)loginWithDelegeatewithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;


-(void)getReligionListwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;
-(void)getFamilyOriginListwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;
-(void)getSpecificationListwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;
-(void)getMotherTongueListwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;
-(void)updateProfileSelectionwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;
-(void)updateProfileDetailswithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;
-(void)updateProfileHeritagewithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;
-(void)updateProfileOccupationwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;
-(void)updateProfileLegalStatuswithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;
-(void)matchMakingForTheDaywithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;

-(void)matchPoolForTheDaywithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;


-(void)rematchwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;

-(void)getContactListwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;

-(void)getLayerAuthTokenwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
;

@end
