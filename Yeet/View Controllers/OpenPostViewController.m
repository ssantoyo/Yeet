//
//  OpenPostViewController.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/27/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "OpenPostViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import <PFUser.h>
#import "SceneDelegate.h"
#import <Parse/Parse.h>




@interface OpenPostViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *userIV;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *songnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postreviewLabel;



@end

@implementation OpenPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self passData];
}

-(void)passData{
    
    
    self.postreviewLabel.text = self.post.review;
    self.songnameLabel.text = self.post.songTitle;
    self.artistnameLabel.text = self.post.artistTitle;
    self.albumnameLabel.text = self.post.albumTitle;
    self.userLabel.text = nil;
    self.userLabel.text = self.post.author[@"username"];
    self.userIV.file = nil;
    self.userIV.file = self.post.author[@"userimage"];
    [self.userIV loadInBackground];
    self.userIV.layer.masksToBounds = true;
    self.userIV.layer.cornerRadius = 60;
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
