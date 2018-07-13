//
//  RGUserPage.h
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 25.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGUserPage : NSObject

@property (strong, nonatomic) NSString* userIds;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) NSString* isOnline;
@property (strong, nonatomic) NSString* city;

- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end
