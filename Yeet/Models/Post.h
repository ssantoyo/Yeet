//
//  Post.h
//  Yeet
//
//  Created by Sergio Santoyo on 7/15/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Song.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *review;
@property (nonatomic, strong) NSString *artistTitle;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *songTitle;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) Song *song;

//@property (nonatomic, strong) NSNumber *likeCount;
//@property (nonatomic, strong) NSNumber *commentCount;

+ (void) postSongReview: ( UIImage * _Nullable )image
             withReview: ( NSString * _Nullable )review
               withSong: ( Song * _Nullable )song
          withSongTitle: ( NSString * _Nullable )songTitle
        withArtistTitle: (NSString * _Nullable )artistTitle
         withAlbumTitle: (NSString * _Nullable )albumTitle
         withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END
