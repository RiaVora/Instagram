//
//  FeedViewController.m
//  Instagram
//
//  Created by Ria Vora on 7/6/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "LoginViewController.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;

}

- (IBAction)pressedLogout:(id)sender {
    NSString *username = PFUser.currentUser.username;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error logging out: %@", error.localizedDescription);
        } else {
            [self logoutAlert:username];
        }
    }];
}

- (void)logoutAlert:(NSString *)currentUsername {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat: @"Logout of '%@'", currentUsername] message:@"Are you sure you want to logout?" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
      style:UIAlertActionStyleCancel
    handler:^(UIAlertAction * _Nonnull action) {
            // handle response here.
    }];
    
    [alert addAction:cancelAction];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes"
      style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * _Nonnull action) {
        [self switchToLoginScreen];
    }];
    
    [alert addAction:yesAction];
        
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (void)switchToLoginScreen {
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
