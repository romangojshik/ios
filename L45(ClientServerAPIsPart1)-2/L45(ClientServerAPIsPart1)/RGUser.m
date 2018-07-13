//
//  RGUser.m
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 20.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "RGUser.h"

@implementation RGUser

- (id) initWithServerResponse:(NSDictionary*) responseObject;
{
    self = [super init];
    if (self) {
        
        self.userId = [responseObject objectForKey:@"id"];
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];        
        }
        
    }
    
    return self;
}

- (id) initWithServerResponseSubscribe:(NSDictionary*) responseObject;
{
    self = [super init];
    if (self) {
        
        self.userId = [responseObject objectForKey:@"id"];
        self.firstName = [responseObject objectForKey:@"name"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
    }
    
    return self;
}

@end
