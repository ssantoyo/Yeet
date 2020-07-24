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
#import <PFUser.h>
#import "PFImageView.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *profileImageView;
//@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong,nonatomic) AppDelegate *delegate;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [self saveUser];
    
    
    //PFUser.currentUser[@"userimage"] = [Post getPFFileFromImage: self.profileImageView.image];
   // PFUser *user = [PFUser currentUser];
   // self.profileImageView.file = nil;
    //self.profileImageView.file = user[@"userimage"];
    /*
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(saveUser) forControlEvents:UIControlEventValueChanged];
    [self.profileImageView insertSubview:self.refreshControl atIndex:0];
     */
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
    //PFUser.currentUser[@"userimage"] = [Post getPFFileFromImage: self.profileImageView.image];
   // [PFUser.currentUser saveInBackground];
    
    
    PFUser *user = [PFUser currentUser];
    self.profileImageView.file = nil;
    self.profileImageView.file = user[@"userimage"];
    [self.profileImageView loadInBackground];
    self.profileImageView.layer.masksToBounds =true;
    self.profileImageView.layer.cornerRadius =32;
    
    self.usernameLabel.text = nil;
    self.usernameLabel.text = user[@"username"];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.profileImageView.image = editedImage;
    //add the image to parse here
   // [self saveUser];
    
    PFUser.currentUser[@"userimage"] = [Post getPFFileFromImage: self.profileImageView.image];
       [PFUser.currentUser saveInBackground];
    
    
    // Do something with the images (based on your use case)
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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

- (IBAction)onTapFeed:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *) self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TimelineViewController *timelineViewController = [storyboard instantiateViewControllerWithIdentifier:@"TimelineViewController"];
    sceneDelegate.window.rootViewController = timelineViewController;
    
}

- (IBAction)onTapSpotify:(id)sender {
    [self.delegate authorizationLogin];
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
