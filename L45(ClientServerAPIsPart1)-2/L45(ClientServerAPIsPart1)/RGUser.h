//
//  RGUser.h
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 20.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGUser : NSObject

@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageURL;

- (id) initWithServerResponse:(NSDictionary*) responseObject;
- (id) initWithServerResponseSubscribe:(NSDictionary*) responseObject;

@end
