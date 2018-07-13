//
//  RGUserPageViewController.h
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 27.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGUserPageViewController : UIViewController

@property (assign, nonatomic) NSInteger userID;

- (void) getUserPageFromServerWithID:(NSInteger) userID;

@end
