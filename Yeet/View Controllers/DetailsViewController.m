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
#import "ApplicationScheme.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (strong, nonatomic) NSMutableArray *genres;
@property (strong, nonatomic) NSMutableArray *genresarr;
@property (strong, nonatomic) NSNumber *searchKey;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Allocates a new instance of the reciving class and returns the initalized object
    self.genresarr = [NSMutableArray new];
    self.genres = [[NSMutableArray alloc] init];
    self.searchKey = 0;
    
    // Set poster to nil to remove the old one (when refreshing) and query for the new one
    self.songLabel.text = self.song.songName;
    self.artistLabel.text = self.song.artistName;
    self.albumLabel.text = self.song.albumName;
    
    // Instantiate a weak link to the cell and fade in the image in the request
     NSURL *propicURL = [NSURL URLWithString: self.song.imageURL];
        [self.albumImageView setImageWithURL:propicURL];
   
    id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
    self.view.backgroundColor = colorScheme.surfaceColor;
}


- (IBAction)onTapShare:(id)sender {
    if(self.textView.hasText){
        Post *newPost = [[Post alloc] initSongReview:self.albumImageView.image withReview:self.textView.text withSong:self.song withGenres:self.genres withSongTitle:self.songLabel.text withArtistTitle:self.artistLabel.text withAlbumTitle:self.albumLabel.text];
        
        
        [newPost postWithCompletion:^(BOOL succeeded, NSError * _Nullable error) {
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

- (void)tapGenreWithSender:sender andGenre:genre{
    UIButton *button = (UIButton *)sender;
    // If not pressed
    if ([button.currentTitleColor isEqual:[UIColor systemBlueColor]]) {
        [button setTitleColor:[UIColor colorWithRed:0/255.0 green:44/255.0 blue:145/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.genres addObject: genre];
    // If already pressed
    } else {
        [button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    }
    
}


- (IBAction)tapHiphop:(id)sender {
    [self tapGenreWithSender:sender andGenre:@"Hiphop"];
}

- (IBAction)tapRap:(id)sender {
    [self tapGenreWithSender:sender andGenre:@"Rap"];
}

- (IBAction)tapRandB:(id)sender {
    [self tapGenreWithSender:sender andGenre:@"RandB"];
}

- (IBAction)tapPop:(id)sender {
       [self tapGenreWithSender:sender andGenre:@"Pop"];
}

- (IBAction)tapLatinX:(id)sender {
        [self tapGenreWithSender:sender andGenre:@"LatinX"];
}

- (IBAction)onTap:(id)sender {
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
