//
//  ViewController.m
//  Instagram
//
//  Created by Ria Vora on 7/6/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions

- (IBAction)pressedSignUp:(id)sender {
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    BOOL usernameExists = [self checkExists:newUser.username:@"Username"];
    BOOL passwordExists = [self checkExists:newUser.password:@"Password"];
    
    if (usernameExists && passwordExists) {
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"New user of name %@ signup succeeded", newUser.username);
                self.usernameTextField.text = @"";
                self.passwordTextField.text = @"";
            } else {
                NSLog(@"Error: %@", error.localizedDescription);
                [self displayAlert:@"Error with Signing Up" :error.localizedDescription];
            }
        }];
    }
}
- (IBAction)pressedLogin:(id)sender {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    BOOL usernameExists = [self checkExists:username:@"Username"];
    BOOL passwordExists = [self checkExists:password:@"Password"];
    
    if (usernameExists && passwordExists) {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %ld", error.code);
                [self displayAlert:@"Error with Logging in" :error.localizedDescription];
            } else {
                NSLog(@"User %@ logged in successfully", username);
                self.usernameTextField.text = @"";
                self.passwordTextField.text = @"";
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                
            }
        }];
    }
}

- (BOOL)checkExists:(NSString *)text :(NSString *)field {
    if ([text isEqual:@""]) {
        [self displayAlert: [NSString stringWithFormat: @"%@ Cannot Be Blank", field]: [NSString stringWithFormat: @"Please create a %@.", field]];
        return NO;
    }
    return YES;
}

#pragma mark - Alerts

- (void)displayAlert:(NSString *)title :(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{}];
}


@end
