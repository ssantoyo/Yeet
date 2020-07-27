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
#import "SongViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    // Set poster to nil to remove the old one (when refreshing) and query for the new one
    self.albumImageView.image = nil;
    self.songLabel.text = self.song.songName;
    self.artistLabel.text = self.song.artistName;
    self.albumLabel.text = self.song.albumName;
    
    // Instantiate a weak link to the cell and fade in the image in the request
     NSURL *propicURL = [NSURL URLWithString: self.song.imageURL];
        [self.albumImageView setImageWithURL:propicURL];
                                           
}


- (IBAction)onTapShare:(id)sender {
    if(self.textView.hasText){
        [Post postSongReview:self.albumImageView.image withReview:self.textView.text withSong:self.song withSongTitle:self.songLabel.text withArtistTitle:self.artistLabel.text             withAlbumTitle:self.albumLabel.text
            withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
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
        }}];
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
