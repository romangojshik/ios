//
//  RGUserPageTableViewController.h
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 24.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGUserPageTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel* freindFullName;

- (void) getUserPageFromServerWithID:(NSInteger) userID;

@end
