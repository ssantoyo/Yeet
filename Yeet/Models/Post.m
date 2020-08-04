//
//  Post.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/15/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "Post.h"
#import "Utils.h"

@implementation Post
    
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic review;
@dynamic songTitle;
@dynamic artistTitle;
@dynamic albumTitle;
@dynamic image;
@dynamic song;
@dynamic likeCount;
@dynamic searchKey;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

- (instancetype) initSongReview: ( UIImage * _Nullable )image
             withReview: ( NSString * _Nullable )review
               withSong: ( Song * _Nullable )song
             withGenres: (NSArray * _Nullable)genres
          withSongTitle: ( NSString * _Nullable )songTitle
        withArtistTitle: (NSString * _Nullable )artistTitle
         withAlbumTitle: (NSString * _Nullable )albumTitle {
    
    //initalizes an object 
    self = [super init];
    if (self) {
        self.image = [Utils getPFFileFromImage:image];
           self.author = [PFUser currentUser];
           self.review = review;
           self.artistTitle = artistTitle;
           self.songTitle = songTitle;
           self.albumTitle = albumTitle;
           self.song = song;
           self.searchKey = [self calculateSearch:genres];
           self.likeCount = @(0);
    }
    return self;
}

- (void) postWithCompletion: (PFBooleanResultBlock  _Nullable)completion
{
 [self saveInBackgroundWithBlock: completion];
}

-(NSNumber *)calculateSearch: (NSArray * _Nullable)genres{
  //calculates a unique key based off the indexes of the genres
    NSDictionary *genreIndex = @{
    @"Hiphop": @(0),
    @"Rap": @(1),
    @"RandB": @(2),
    @"Pop": @(3),
    @"LatinX": @(4)
};
    int keyValue = 0;
    for (NSString *genre in genres){
    double power = pow(2,[genreIndex[genre] intValue]);
    keyValue += ([self.searchKey intValue] + power);
    }
    return  [NSNumber numberWithInt:keyValue];
}

@end
