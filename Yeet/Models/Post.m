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
@dynamic image;
//@dynamic song;
//@dynamic likeCount;
//@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postSongReview: ( UIImage * _Nullable )image
             withReview: ( NSString * _Nullable )review
             //withSong: ( Song * _Nullable )song
          withSongTitle: ( NSString * _Nullable )songTitle
        withArtistTitle: (NSString * _Nullable )artistTitle
         withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.review = review;
    newPost.artistTitle = artistTitle;
    newPost.songTitle = songTitle;
    //newPost.song = song;
    //newPost.likeCount = @(0);
    //newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock: completion];
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
