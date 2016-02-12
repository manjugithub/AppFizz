//
//  FbController.m
//  FastacashSDK
//
//  Created by Vikas Kumar on 05/10/15.
//  Copyright © 2015 fastacash. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "FBController.h"
#import "BUSocialChannel.h"
#import "NSObject+FCKeyPathHelper.h"


@interface FBController()

@property (nonatomic, strong) FBSDKLoginManager *loginManager;

@end

@implementation FBController

+(FBController *)sharedInstance
{
    static FBController *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[FBController alloc] init];
        instance.loginManager = [[FBSDKLoginManager alloc] init];
        instance.permissionsRequired = @[@"public_profile",@"user_friends", @"user_about_me",@"email"];
    });
    return instance;
}

//-(void)setPermissionsRequired:(NSArray *)permissionsRequired
//{
//    NSMutableArray *per;
//    if ([permissionsRequired containsObject:@"publish_actions"])
//    {
//        per = [NSMutableArray arrayWithArray:permissionsRequired];
//        [per removeObject:@"publish_actions"];
//    }
//    
//    _permissionsRequired = per;
//}

-(void)authenticateWithCompletionHandler:(void(^)(BUSocialChannel *socialChannel, NSError *error, BOOL whetherAlreadyAuthenticated))completion
{
    [self authenticateWithCompletionHandler:completion shouldClearPreviousToken:false];
}

-(void)authenticateWithCompletionHandler:(void(^)(BUSocialChannel *socialChannel, NSError *error, BOOL whetherAlreadyAuthenticated))completion shouldClearPreviousToken:(BOOL)shouldClearPreviousToken
{
    if ([self isAuthenticated] && [self isGrantedAllPermissions])
    {
        [self fetchDetailsWithCompletionHandler:completion whetherAlreadyAuthenticated:false];
    }
    else
    {
        UIViewController *root = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [self.loginManager logInWithReadPermissions:self.permissionsRequired fromViewController:root handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            
//            if (!error) {
            
                // Fetching publish permission
//                [self.loginManager logInWithPublishPermissions:@[@"publish_actions"] fromViewController:root handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                    if (!error)
                    {
                        if ([FBSDKAccessToken currentAccessToken]) {
                            [self fetchDetailsWithCompletionHandler:completion whetherAlreadyAuthenticated:false];
                        }
                        else
                            completion(nil, error, false);
                    }
                    else
                    {
                        completion(nil, error, false);
                    }
//                }];
//            }
//            else {
//                completion(nil, error, false);
//            }
        }];
    }
}

- (void) requestFriendPermission:(void(^)(BOOL whetherPermissionGiven, NSError *error))completion
{
    
   }

-(BOOL)isAuthenticated
{
    if ([FBSDKAccessToken currentAccessToken]) {
        return YES;
    }
    return NO;
}

-(BOOL) isGrantedAllPermissions
{
    BOOL isPermissionGranted = YES;
    for (NSString *permisson in self.permissionsRequired)
    {
        if (![[FBSDKAccessToken currentAccessToken] hasGranted:permisson]) {
            isPermissionGranted = NO;
            break;
        };
    }
    return isPermissionGranted;
}


- (void) fetchDetailsWithCompletionHandler:(void(^)(BUSocialChannel *socialChannel, NSError *error, BOOL whetherAlreadyAuthenticated))completion whetherAlreadyAuthenticated:(BOOL)whetherAlreadyAuthenticated
{
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters: @{@"fields": @"id, name, email, first_name, last_name, location, gender, locale, timezone, updated_time"}];

   
//    @{@"fields": @"id, name, email, first_name, last_name, location, gender, birthday, locale, timezone, updated_time"}
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // Success! Include your code to handle the results here
            
            BUSocialChannel *socialChannel = [[BUSocialChannel alloc] init];
            socialChannel.profileId = [result valueForKeyPathFC:@"id"];
            socialChannel.profile = result;
            socialChannel.profileDetails = [[BUProfileDetails alloc] initWithProfileDetails:result];
            socialChannel.credentials = @{@"accessToken":[FBSDKAccessToken currentAccessToken]};
            socialChannel.socialType = BUSocialChannelFacebook;
            
            completion(socialChannel, error, whetherAlreadyAuthenticated);
            NSLog(@"user info: %@", result);
        } else {
            NSLog(@"FB Error: %@", error);
            completion(nil, error, whetherAlreadyAuthenticated);
        }
    }];
}


-(void)clearSession
{
    [self.loginManager logOut];
}

// During the Facebook login flow, your app passes control to the Facebook iOS app or Facebook in a mobile browser.
// After authentication, your app will be called back with the session information.
// Override application:openURL:sourceApplication:annotation to call the FBsession object that handles the incoming URL
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}

@end
