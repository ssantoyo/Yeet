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

@property (weak, nonatomic) IBOutlet PFImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *songnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistnameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *postReviewLabel;



@end

@implementation OpenPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self passData];
    [self refreshData];
}

-(void)passData{
    
    
    self.postReviewLabel.text = self.post.review;
    self.songnameLabel.text = self.post.songTitle;
    self.artistnameLabel.text = self.post.artistTitle;
    self.albumnameLabel.text = self.post.albumTitle;
    self.userLabel.text = nil;
    self.userLabel.text = self.post.author[@"username"];
    self.userImageView.file = nil;
    self.userImageView.file = self.post.author[@"userimage"];
    [self.userImageView loadInBackground];
    self.userImageView.layer.masksToBounds = true;
    self.userImageView.layer.cornerRadius = 60;
}

-(void)refreshData {

NSNumber *number = self.post.likeCount;
int value = [number intValue];
[self.likeButton setTitle:[NSString stringWithFormat:@"%i", value] forState:UIControlStateNormal];
}

- (IBAction)onLike:(id)sender {
    NSNumber *number = self.post.likeCount;
    int value = [number intValue];
    number = [NSNumber numberWithInt:value +1];
    self.post.likeCount = number;
    
    //Sends update to parse
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded){
            NSLog(@"update post on Detais View");}
        else{
            NSLog(@"Error posting in Details View");
        }
    }];
    [self refreshData];
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
