//
//  BUWebServicesManager.m
//  TheBureau
//
//  Created by Manjunath on 25/01/16.
//  Copyright © 2016 Bureau. All rights reserved.
//

#import "BUWebServicesManager.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "BUConstants.h"
@implementation BUWebServicesManager


+(instancetype)sharedManager
{
    static dispatch_once_t pred;
    static BUWebServicesManager* sharedBUWebServicesManager = nil;
    dispatch_once(&pred, ^{
        sharedBUWebServicesManager = [[BUWebServicesManager alloc] init];
        
        
        sharedBUWebServicesManager.userID = @"400";
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
     
    NSString *baseURL = @"http://dev.thebureauapp.com/login/userRegister";

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
    
     

    NSString *baseURL = @"http://dev.thebureauapp.com/login/checkLogin";
    
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
    
     
    
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"religion_ws"];
    
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
    
//     family_origin_multiple_religions_ws
    
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"family_origin_ws"];
    
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


-(void)getMultipleFamilyOriginListwithParameters:(NSDictionary *)inParams  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"family_origin_multiple_religions_ws"];
    
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
    
     
    
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"specification_ws"];
    
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
    
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"mother_tongue_ws"];
    
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
    
     
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"update_profile_step1"];

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
    
     
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"update_profile_step2"];
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
    
     
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"update_profile_step3"];
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
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"update_profile_step4"];
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
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"update_profile_step1"];
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



-(void)getProfileDetailsWithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    NSString *baseURL =[NSString stringWithFormat:@"%@%@",kBaseURL,@"readProfileDetails"];
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

-(void)matchMakingForTheDaywithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    NSString *baseURL =[NSString stringWithFormat:@"%@%@",kBaseURL,@"matchtab"];
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
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"pool_final"];
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
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"rematch"];
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
    
    
    
    NSString *baseURL = [NSString stringWithFormat:@"%@%@",kBaseURL,@"userContacts"];
    
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

-(void)getLayerAuthTokenwithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack;
{
    
    NSString *baseURL = @"http://dev.thebureauapp.com/layer/public/authenticate.php";
    
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


#pragma mark - Generic Server query API
-(void)queryServer:(NSDictionary *)inParams baseURL:(NSString *)inBaseURL  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:inBaseURL
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

-(void)queryServerWithList:(NSArray *)inParams baseURL:(NSString *)inBaseURL  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:inBaseURL
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


-(void)deleteProfilePicture:(NSString *)inImageURLStr  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    NSDictionary *parameters = @{@"img_url": inImageURLStr};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://dev.thebureauapp.com/admin/deleteImages"
       parameters:parameters
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


-(void)uploadProfilePicture:(UIImage *)inImage
{
    NSData *imageData = UIImageJPEGRepresentation(inImage, 0.8);
    NSDictionary *parameters = @{@"userid": self.userID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://dev.thebureauapp.com/admin/multi_upload"
       parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData:imageData name:@"userfile" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
     }
         progress:nil
          success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         //         successCallBack(responseObject,nil);
         NSLog(@"Success: %@", responseObject);
     }
          failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         //         failureCallBack(nil,error);
         NSLog(@"Error: %@", error);
     }];
}


-(void)uploadHoroscope:(UIImage *)inImage  successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    NSData *imageData = UIImageJPEGRepresentation(inImage, 0.8);
    NSDictionary *parameters = @{@"userid": self.userID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://dev.thebureauapp.com/admin/uploadHoroscope"
       parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
    [formData appendPartWithFileData:imageData name:@"userfile" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
    }
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


-(void)deleteContactWithParameters:(NSDictionary *)inParams successBlock:(SuccessBlock) successCallBack failureBlock:(FailureBlock) failureCallBack
{
    NSString *baseURL =[NSString stringWithFormat:@"%@%@",kBaseURL,@"deleteChatContact"];
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

@end
