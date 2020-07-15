//
//  SignUpViewController.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/14/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountnameField;
@property (weak, nonatomic) IBOutlet UITextField *accountpasswordField;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)ValidInput {
    if ([self.accountnameField.text isEqual:@""] || [self.accountpasswordField.text isEqual:@""]) {
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

- (IBAction)onTapRegister:(id)sender {
    if([self ValidInput]){
        PFUser *newUser = [PFUser user];

          // set user properties
        newUser.username = self.accountnameField.text;
        newUser.password = self.accountpasswordField.text;
        
            // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                   
            } else {
                NSLog(@"User registered successfully");
                    
                [self performSegueWithIdentifier:@"ProfileSegue" sender:nil];

                    // manually segue to logged in view
                }
            }];
    }
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
