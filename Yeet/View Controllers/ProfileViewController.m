//
//  ProfileViewController.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/14/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.profileImageView.image = editedImage;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
