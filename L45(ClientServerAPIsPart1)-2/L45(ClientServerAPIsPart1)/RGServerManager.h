//
//  RGServerManager.h
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 15.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGUserPage.h"

@class RGUser;
@class RGUserPage;

@interface RGServerManager : NSObject

@property (strong, nonatomic, readonly) RGUser* currentUser;

+ (RGServerManager*) sharedManager;

-(void) authorizeUser:(void(^)(RGUser* user)) completion;

- (void) getUser:(NSString*) userID
       onSuccess:(void(^)(RGUser* user)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getFriendsWithOffset: (NSString*) userID
                       offset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

-(void) getSubscriptionsWithUser:(NSString*) userID
                          offset:(NSInteger) offset
                           count:(NSInteger) count
                       onSuccess:(void(^)(NSArray* friends)) success
                       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure ;

- (void) getUserPageWithID:(NSInteger) userID
                         onSuccess:(void(^)(RGUserPage* user)) success
                         onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

//-(void) getUserWithUsetID:(NSString*) userID
//                onSuccess:(void(^)(RGUserPage* user)) success
//                onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

@end
