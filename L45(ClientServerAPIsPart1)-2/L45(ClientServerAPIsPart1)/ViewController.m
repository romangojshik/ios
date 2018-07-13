//
//  ViewController.m
//  L45(ClientServerAPIsPart1)
//
//  Created by Admin on 15.04.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "ViewController.h"
#import "RGServerManager.h"
#import "RGUser.h"
#import "UIImageView+AFNetworking.h"
#import "RGUserPageTableViewController.h"
#import "RGUserPageViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* arrayFriends;

@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation ViewController

static NSInteger friendsInRequest = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.arrayFriends = [NSMutableArray array];
    
    self.firstTimeAppear = YES;    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (self.firstTimeAppear) {
        
        self.firstTimeAppear = NO;
        
        [[RGServerManager sharedManager] authorizeUser:^(RGUser *user) {
            if (self.isSubcribe) {
                [self getSubscribersFromServer];
            } else {
                [self getFriendsFromServer];
            }
            
            NSLog(@"AUTHORIZED!");
            NSLog(@"%@ %@", user.firstName, user.lastName);
            
        }];
        
    }
    
}

#pragma mark - API

- (void) getFriendsFromServer {
    [[RGServerManager sharedManager] getFriendsWithOffset: self.userID
                                                   offset: [self.arrayFriends count]
                                    count:friendsInRequest
                                    onSuccess:^(NSArray *friends) {
                                        
                                        [self.arrayFriends addObjectsFromArray:friends];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [self.tableView reloadData];
                                        });
                                    }
                                    onFailure:^(NSError *error, NSInteger statusCode) {
                                        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
                                    }];

}

- (void) getSubscribersFromServer {
    [[RGServerManager sharedManager] getSubscriptionsWithUser: self.userID
                                                       offset: self.arrayFriends.count
                                                        count: friendsInRequest
                                                    onSuccess:^(NSArray *friends) {
                                                        [self.arrayFriends addObjectsFromArray:friends];
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [self.tableView reloadData];
                                                        });
                                                    }
                                                    onFailure:^(NSError *error, NSInteger statusCode) {
                                                        NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
                                                    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayFriends count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == [self.arrayFriends count]) {
    
        cell.textLabel.text = @"Load More";
        cell.imageView.image = nil;
    
    } else  {
    
        RGUser* friend = [self.arrayFriends objectAtIndex:indexPath.row];

        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName ? friend.lastName : @""];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:friend.imageURL];
        
        __weak UITableViewCell* weakCell = cell;
        
        cell.imageView.image = nil;
        
        [cell.imageView
         setImageWithURLRequest:request
         placeholderImage:nil
         success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
             weakCell.imageView.image = image;
             [weakCell layoutSubviews];
         }
         failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
             
         }];
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (!self.isSubcribe) {
        if (indexPath.row == [self.arrayFriends count]) {
            [self getFriendsFromServer];
            
            return;
        }
        
        
        RGUser* user = [self.arrayFriends objectAtIndex:indexPath.row];
        
        UIStoryboard* storyboard = self.storyboard;
        RGUserPageViewController* webViewController = [storyboard instantiateViewControllerWithIdentifier:@"RGUserPageViewController"];
        
        webViewController.userID = (int)[user.userId integerValue];
        
        [self.navigationController pushViewController:webViewController animated:YES];
    } else {
        if (indexPath.row == [self.arrayFriends count]) {
            [self getSubscribersFromServer];
            
            return;
        }
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Находится в разраобтке"
                                     message:@""
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        
        [alert addAction: okButton];
        
        [self.navigationController presentViewController: alert animated: NO completion:^{

        }];
    }
}

@end
