//
//  RGServerManager.m
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 15.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "RGServerManager.h"
#import "AFNetworking.h"

#import "RGUser.h"
#import "RGLoginViewController.h"
#import "RGAccessToken.h"

@interface RGServerManager()

@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;
@property (strong, nonatomic) RGAccessToken* accessToken;

@end

@implementation RGServerManager

+ (RGServerManager*) sharedManager {
    
    static RGServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[RGServerManager alloc] init];
    });
    
    return manager;
}

-(id) init {
    
    self = [super init];
    
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        
    }
    
    return self;
    
}

- (void) authorizeUser:(void (^)(RGUser *))completion {
    
    RGLoginViewController* vc =
    [[RGLoginViewController alloc] initWithCompletionBlock:^(RGAccessToken *token) {
        
        self.accessToken = token;
        
        if (token) {
            
            [self getUser:self.accessToken.userID
                onSuccess:^(RGUser *user) {
                    if (completion) {
                        completion(user);
                    }
                }
                onFailure:^(NSError *error, NSInteger statusCode) {
                    if (completion) {
                        completion(nil);
                    }
                }];
            
        } else if (completion) {
            completion(nil);
        }
    }];
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UIViewController* mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    
    [mainVC presentViewController:nav animated:YES completion:nil];
    
}

- (void) getUser:(NSString*) userID
       onSuccess:(void(^)(RGUser* user)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* params = @{
                             @"user_ids" : userID,
                             @"fields" : @"photo_50",
                             @"access_token" : self.accessToken.token,
                             @"v" : @"5.76",
                             };
    
    [self.sessionManager GET:@"https://api.vk.com/method/users.get"
                  parameters:params
                     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
                         
                         NSLog(@"JSON: %@", responseObject);
                         
                         NSArray *dictsArray = [responseObject objectForKey:@"response"];
                         
                         if ([dictsArray count] > 0) {
                             
                             RGUser* user = [[RGUser alloc] initWithServerResponse:[dictsArray firstObject]];
                             if (success) {
                                 success(user);
                             }
                         }
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                         NSLog(@"Error: %@", error);
                     }];
    
}


- (void) getFriendsWithOffset:(NSString*) userID
                       offset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    NSString* currentUserID = userID != nil ? userID : @"41838209";
    
    NSDictionary* params = @{
                             @"user_id"         :    currentUserID,
                             @"order"           :    @"name",
                             @"count"           :    @(count),
                             @"offset"          :    @(offset),
                             @"fields"          :    @"photo_50",
                             @"name_case"       :    @"nom",
                             @"access_token"    :    self.accessToken.token,
                             @"v"               :    @"5.76",
                             };
    
    
    [self.sessionManager GET:@"https://api.vk.com/method/friends.get"
                  parameters:params
                     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
                         
                        NSLog(@"JSON: %@", responseObject);
                     
                     
                        NSDictionary *friendsArray = [[responseObject objectForKey:@"response"] objectForKey:@"items"];
                         
                        NSMutableArray* objectsArray = [NSMutableArray array];
                         
                        for (NSDictionary* dict in friendsArray) {
                         
                            RGUser* user = [[RGUser alloc] initWithServerResponse:dict];
                            [objectsArray addObject:user];
                            
                        }
                         
                         
                         if (success) {
                             success(objectsArray);
                         }
                         
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                         NSLog(@"Error: %@", error);                         
                     }];

}

- (void) getSubscriptionsWithUser:(NSString*) userID
                          offset:(NSInteger) offset
                           count:(NSInteger) count
                       onSuccess:(void(^)(NSArray* friends)) success
                       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    NSDictionary* params = @{
                             @"user_id"         :    userID,
                             @"extended"        :    @(1),
                             @"count"           :    @(count),
                             @"offset"          :    @(offset),
                             @"fields"          :    @"photo_50",
                             @"name_case"       :    @"nom",
                             @"access_token"    :    self.accessToken.token,
                             @"v"               :    @"5.76",
                             };

    [self.sessionManager GET:@"https://api.vk.com/method/users.getSubscriptions"
                  parameters:params
                     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {

                         NSLog(@"JSON: %@", responseObject);


                         NSDictionary *friendsArray = [[responseObject objectForKey:@"response"] objectForKey:@"items"];

                         NSMutableArray* objectsArray = [NSMutableArray array];

                         for (NSDictionary* dict in friendsArray) {

                             RGUser* user = [[RGUser alloc] initWithServerResponseSubscribe:dict];
                             [objectsArray addObject:user];

                         }


                         if (success) {
                             success(objectsArray);
                         }


                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                         NSLog(@"Error: %@", error);
                     }];

}

- (void) getUserPageWithID:(NSInteger) userID
                 onSuccess:(void(^)(RGUserPage* user)) success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSString* idString = [NSString stringWithFormat:@"%ld", userID];
    
//    NSLog(@"%@", idString);
    
//    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            idString,                       @"user_ids",
//                            @"photo_100, city, online",     @"fields",
//                            @"5.74",                        @"v",
//                            nil];
    
    NSDictionary* params = @{
                             @"user_ids"         :    idString,
                             @"fields"           :    @"photo_100, city, online",
                             @"access_token"     :    self.accessToken.token,
                             @"v"                :     @"5.76",
                             };
    
    [self.sessionManager GET:@"https://api.vk.com/method/users.get"
                  parameters:params
                     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
                         
                         NSLog(@"JSON: %@", responseObject);
                         
                         NSArray *userArray = [[NSArray alloc] initWithArray: [responseObject objectForKey:@"response"]];
                         
                         RGUserPage* user = [[RGUserPage alloc] initWithServerResponse: userArray.firstObject];

                         if (success) {
                             success(user);
                         }
                         
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                         NSLog(@"Error: %@", error);
                     }];
}

@end
