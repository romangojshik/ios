//
//  RGAccessToken.h
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 22.05.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGAccessToken : NSObject

@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) NSString* expirationDate;
@property (strong, nonatomic) NSString* userID;

@end
