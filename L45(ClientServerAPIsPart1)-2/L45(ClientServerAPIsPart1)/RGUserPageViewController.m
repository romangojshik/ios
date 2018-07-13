//
//  RGUserPageViewController.m
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 27.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "RGUserPageViewController.h"
#import "RGServerManager.h"
#import "RGUserPage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ViewController.h"

@interface RGUserPageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;

@end

@implementation RGUserPageViewController

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.imageView.layer setCornerRadius: 50.f];
    [self.friendButton.layer setCornerRadius: 5.f];
    [self.subscribeButton.layer setCornerRadius: 5.f];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.layer.masksToBounds = YES;
    self.friendButton.layer.masksToBounds = YES;
    self.subscribeButton.layer.masksToBounds = YES;
    
    [self getUserPageFromServerWithID: self.userID];
}

- (void) getUserPageFromServerWithID:(NSInteger) userID {

    [[RGServerManager sharedManager] getUserPageWithID:userID
                                     onSuccess:^(RGUserPage *userData) {
                                         
                                         [self configure: userData];
                                         
                                    } onFailure:^(NSError *error, NSInteger statusCode) {

                                        NSLog(@"Fail");

                                    }];

}
- (IBAction) didOpenFriend:(UIButton *)sender {
    UIStoryboard* storyboard = self.storyboard;
    ViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    vc.userID = [NSString stringWithFormat: @"%ld", self.userID];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didOpenSubcribers:(UIButton *)sender {
    UIStoryboard* storyboard = self.storyboard;
    ViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    vc.userID = [NSString stringWithFormat: @"%ld", self.userID];
    vc.isSubcribe = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Private

- (void) configure: (RGUserPage*) user {
    self.nameLabel.text = [NSString stringWithFormat: @"%@ %@", user.firstName, user.lastName];
    self.cityLabel.text = user.city;
    self.onlineLabel.text = [NSString stringWithFormat:@"%s", [user.isOnline integerValue] == 1 ? "Online" : "Offline"];
    
    __weak RGUserPageViewController *weakSelf = self;
    
    __block UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] init];
    activityIndicator.center = self.imageView.center;
    activityIndicator.hidesWhenStopped = YES;
    
    [self.imageView sd_setImageWithURL: user.imageURL
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
        {
    
            [activityIndicator removeFromSuperview];
            [weakSelf.view setNeedsLayout];
    
        }
     ];
}


@end
