//
//  DetailsViewController.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/16/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "DetailsViewController.h"
#import "Post.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onTapSDK:(id)sender {
[Post postSongReview: nil withReview:@"this is my review" withSongTitle:@"this is my songTitle" withArtistTitle: @"this is my artistTitle" withCompletion:
 ^(BOOL succeeded, NSError * _Nullable error) {
    if (succeeded){
        NSLog(@"post completed");
    } else{
        NSLog(@"not completed post");
    }
}];
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
