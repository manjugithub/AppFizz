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

-(void)signUpWithDelegeate:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams
{
    self.delegate = inDelegate;
    NSString *baseURL = @"http://app.thebureauapp.com/login/userRegister";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
    
}


-(void)loginWithDelegeate:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams;
{
    
    self.delegate = inDelegate;

    NSString *baseURL = @"http://app.thebureauapp.com/login/checkLogin";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
}


-(void)getReligionList:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams;
{
    
    self.delegate = inDelegate;
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/religion_ws";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
}

-(void)getFamilyOriginList:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams;
{
    
    self.delegate = inDelegate;
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/family_origin_ws";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
}

-(void)getSpecificationList:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams;
{
    
    self.delegate = inDelegate;
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/specification_ws";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
}

-(void)getMotherTongueList:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams;
{
    
    self.delegate = inDelegate;
    
    NSString *baseURL = @"http://app.thebureauapp.com/admin/mother_tongue_ws";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
}



-(void)updateProfileSelection:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams;
{
    
    self.delegate = inDelegate;
    NSString *baseURL = @"http://app.thebureauapp.com/admin/update_profile_step1";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
}

-(void)updateProfileDetails:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams;
{
    
    self.delegate = inDelegate;
    NSString *baseURL = @"http://app.thebureauapp.com/admin/update_profile_step2";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
}

-(void)updateProfileHeritage:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams;
{
    
    self.delegate = inDelegate;
    NSString *baseURL = @"http://app.thebureauapp.com/admin/update_profile_step3";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
}

-(void)updateProfileOccupation:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams;
{
    
    self.delegate = inDelegate;
    NSString *baseURL = @"http://app.thebureauapp.com/admin/update_profile_step4";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
}

-(void)updateProfileLegalStatus:(id<BUWebServicesCallBack>)inDelegate parameters:(NSDictionary *)inParams;
{
    
    self.delegate = inDelegate;
    NSString *baseURL = @"http://app.thebureauapp.com/admin/update_profile_step1";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:baseURL
       parameters:inParams
constructingBodyWithBlock:nil
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         [self.delegate didSuccess:responseObject];
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         [self.delegate didFail:error];
         NSLog(@"Error: %@", error);
     }];
}
@end
