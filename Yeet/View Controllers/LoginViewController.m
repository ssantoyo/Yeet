//
//  LoginViewController.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/14/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "ApplicationScheme.h"
#import <MDCFilledTextFieldColorThemer.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
    self.view.backgroundColor = colorScheme.surfaceColor;
}

- (BOOL)ValidInput {
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Username or Passowrd"
                    message:@"Fill in the required fields." preferredStyle:(UIAlertControllerStyleAlert)];
            
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // Handle response here
            }];
            
        [alert addAction:okAction];
            
        [self presentViewController:alert animated:YES completion:^{
            }];
        return NO;
        
        } else {
            
            return YES;
        }
}

- (IBAction)onTapLogin:(id)sender {
    if([self ValidInput]){
        NSString *username = self.usernameField.text;//clean up and improve
        NSString *password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
            } else {
                NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier:@"LoginSegue" sender:nil];

                // display view controller that needs to shown after successful login
            }
        }];
    }
}

- (IBAction)onTapSignUp:(id)sender {
                    [self performSegueWithIdentifier:@"SignupSegue" sender:nil];
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
