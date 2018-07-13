//
//  RGLoginViewController.h
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 22.05.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGAccessToken;

typedef void(^RGLoginCompletionBlock)(RGAccessToken* token);

@interface RGLoginViewController : UIViewController

- (id) initWithCompletionBlock:(RGLoginCompletionBlock) completionBlock;

@end
