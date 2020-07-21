//
//  DetailsViewController.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/16/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "DetailsViewController.h"
#import "Post.h"
#import "SceneDelegate.h"
#import "TimelineViewController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)onTapShare:(id)sender {
    if(self.textView.hasText != nil){
    
    [Post postSongReview: nil withReview:self.textView.text withSongTitle:@"this is my songTitle" withArtistTitle: @"this is my artistTitle" withCompletion:
 ^(BOOL succeeded, NSError * _Nullable error) {
    if (!error){
        NSLog(@"post completed");
        //[self dismissViewControllerAnimated:YES completion:nil];
        SceneDelegate *sceneDelegate = (SceneDelegate *) self.view.window.windowScene.delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TimelineViewController *timelineViewController = [storyboard instantiateViewControllerWithIdentifier:@"TimelineViewController"];
        sceneDelegate.window.rootViewController = timelineViewController;
    } else{
        NSLog(@"not completed post");
        NSLog(@"%@", error.localizedDescription);
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
