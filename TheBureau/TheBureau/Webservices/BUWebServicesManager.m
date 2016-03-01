//
//  BUWebServicesManager.m
//  TheBureau
//
//  Created by Manjunath on 25/01/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUWebServicesManager.h"
#import "AFHTTPSessionManager.h"
#import <AFNetworking.h>
#import "AFHTTPSessionManager.h"
@implementation BUWebServicesManager


+(instancetype)sharedManager
{
    static dispatch_once_t pred;
    static BUWebServicesManager* sharedBUWebServicesManager = nil;
    dispatch_once(&pred, ^{
        sharedBUWebServicesManager = [[BUWebServicesManager alloc] init];
        
    });
    return sharedBUWebServicesManager;
}


- (id)init {
    if (self = [super init]) {
        //        self.allCountryDetailsList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)signUpWithDelegeatewithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
     
    NSString *baseURL = @"http://app.thebureauapp.com/login/userRegister";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
    
}


-(void)loginWithDelegeatewithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
     

    NSString *baseURL = @"http://app.thebureauapp.com/login/checkLogin";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}


-(void)getReligionListwithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
     
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/religion_ws";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         failureCallBack(nil,error);
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}

-(void)getFamilyOriginListwithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
     
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/family_origin_ws";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}

-(void)getSpecificationListwithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
     
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/specification_ws";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}

-(void)getMotherTongueListwithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/mother_tongue_ws";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}



-(void)updateProfileSelectionwithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
     
    NSString *baseURL = @"http://app.thebureauapp.com/admin/update_profile_step1";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}

-(void)updateProfileDetailswithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
     
    NSString *baseURL = @"http://app.thebureauapp.com/admin/update_profile_step2";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}

-(void)updateProfileHeritagewithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
     
    NSString *baseURL = @"http://app.thebureauapp.com/admin/update_profile_step3";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}

-(void)updateProfileOccupationwithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
     
    NSString *baseURL = @"http://app.thebureauapp.com/admin/update_profile_step4";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}

-(void)updateProfileLegalStatuswithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    NSString *baseURL = @"http://app.thebureauapp.com/admin/update_profile_step1";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}


-(void)matchMakingForTheDaywithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    NSString *baseURL = @"http://app.thebureauapp.com/admin/matchMaking";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         successCallBack(responseObject,nil);
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}

-(void)matchPoolForTheDaywithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    NSString *baseURL = @"http://app.thebureauapp.com/admin/pool";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
                  successCallBack(responseObject,nil);
;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
          failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}

-(void)rematchwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
{
    NSString *baseURL = @"http://app.thebureauapp.com/admin/rematch";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         successCallBack(responseObject,nil);
         ;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
  
    
    
}

-(void)getContactListwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock)successCallBack failureBlock:(FailureBlock)failureCallBack
{
    
    
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/userContacts";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         successCallBack(responseObject,nil);
         ;
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}


@end
