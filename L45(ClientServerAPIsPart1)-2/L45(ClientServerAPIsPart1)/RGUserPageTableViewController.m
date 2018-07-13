//
//  RGUserPageTableViewController.m
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 24.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "RGUserPageTableViewController.h"
#import "RGServerManager.h"
#import "RGUserPage.h"

@interface RGUserPageTableViewController ()

@end

@implementation RGUserPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) getUserPageFromServerWithID:(NSInteger) userID {
//
//    [[RGServerManager sharedManager] getUserPageWithID:userID
//                                     onSuccess:^(NSArray *userData) {
//        
//                                        NSLog(@"This is data", [userData count]);
//                                        
//                                        RGUserPage* friend = [userData firstObject];
//                                        
//                                        self.freindFullName.text = [NSString stringWithFormat:@"%@",friend.firstName];
//                                //        self.freindFullName.text = [NSString stringWithFormat:@"Hello"];
//                                        
//                                    } onFailure:^(NSError *error, NSInteger statusCode) {
//                                        
//                                        NSLog(@"Fail");
//                                        
//                                    }];
//
//}

@end
