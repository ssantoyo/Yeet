//
//  Post.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/15/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "Post.h"


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

+ (void) postSongReview: ( UIImage * _Nullable )image
             withReview: ( NSString * _Nullable )review
               withSong: ( Song * _Nullable )song
             withGenres: (NSArray * _Nullable)genres
          withSongTitle: ( NSString * _Nullable )songTitle
        withArtistTitle: (NSString * _Nullable )artistTitle
         withAlbumTitle: (NSString * _Nullable )albumTitle
         withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.review = review;
    newPost.artistTitle = artistTitle;
    newPost.songTitle = songTitle;
    newPost.albumTitle = albumTitle;
    newPost.song = song;
    newPost.searchKey = [newPost calculateSearch:genres];
    newPost.likeCount = @(0);
    
    [newPost saveInBackgroundWithBlock: completion];
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

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


@end
