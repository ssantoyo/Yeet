//
//  ProfileViewController.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/14/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "ProfileViewController.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "TimelineViewController.h"
#import "Post.h"
#import "PostCell.h"
#import <PFUser.h>
#import "PFImageView.h"
#import "ApplicationScheme.h"
#import "Utils.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong,nonatomic) AppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UITextField *bioField;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    self.bioField.text = PFUser.currentUser[@"bio"];

    [self saveUser];
    
    // Theme our interface with a green color
    id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
    self.view.backgroundColor = colorScheme.surfaceColor;
    
}

- (IBAction)onTapCamera:(id)sender {
    NSLog(@"Picture Button is being pushed");
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
     imagePickerVC.delegate = self;
     imagePickerVC.allowsEditing = YES;
    
     if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//if camera is available then take picture
         imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
     }
     else {
         NSLog(@"Camera 🚫 available so we will use photo library instead");
         //checks to see if the camera is able to be used, if not then it results to use the library
         imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     }
     //after taken or choosen the picture you are able to go back to the original screen
     [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    
}

-(void)saveUser{
    PFUser *user = [PFUser currentUser];
    self.profileImageView.file = nil;
    self.profileImageView.file = user[@"userimage"];
    [self.profileImageView loadInBackground];
    self.profileImageView.layer.masksToBounds =true;
    self.profileImageView.layer.cornerRadius = 70;
    
    self.usernameLabel.text = nil;
    self.usernameLabel.text = user[@"username"];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.profileImageView.image = editedImage;
    
    PFUser.currentUser[@"userimage"] = [Utils getPFFileFromImage: self.profileImageView.image];
       [PFUser.currentUser saveInBackground];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onTapLogout:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *) self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
}

- (IBAction)onTapSpotify:(id)sender {
    [self.delegate authorizationLogin];
}

- (IBAction)onTapSaveBio:(id)sender {
    if(self.bioField.hasText){
        PFUser.currentUser[@"bio"] = self.bioField.text;
        [PFUser.currentUser saveInBackground];
    }
}

- (IBAction)onTapEndField:(id)sender {
    [self.view endEditing:YES];
    
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
