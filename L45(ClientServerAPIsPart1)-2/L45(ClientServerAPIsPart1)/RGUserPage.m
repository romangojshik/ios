//
//  RGUserPage.m
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 25.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "RGUserPage.h"

@implementation RGUserPage

- (id) initWithServerResponse:(NSDictionary*) responseObject;
{
    self = [super init];
    if (self) {
        
        self.userIds = [responseObject objectForKey:@"id"];
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        self.isOnline = [responseObject objectForKey:@"online"];
        self.city = [[responseObject objectForKey:@"city"] objectForKey:@"title"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_100"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
    }
    return self;
}

@end
