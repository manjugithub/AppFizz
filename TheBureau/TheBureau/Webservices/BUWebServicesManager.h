//
//  BUWebServicesManager.h
//  TheBureau
//
//  Created by Manjunath on 25/01/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LayerKit/LayerKit.h>
#import "BUUtilities.h"




@interface BUWebServicesManager : NSObject
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *participantUserID;

@property (nonatomic) LYRClient *layerClient;

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

#pragma mark - Generic Server query API
-(void)queryServer:(NSDictionary *)inParams baseURL:(NSString *)inBaseURL  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;

-(void)queryServerWithList:(NSArray *)inParams baseURL:(NSString *)inBaseURL  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;

-(void)getMultipleFamilyOriginListwithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
@end
