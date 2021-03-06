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
@property (nonatomic,strong) NSNumber *searchKey;
@property (nonatomic, strong) NSNumber *likeCount;
//@property (nonatomic,strong) NSMutableArray *genres;
//@property (nonatomic, strong) NSNumber *commentCount;

- (instancetype) initSongReview: ( UIImage * _Nullable )image
             withReview: ( NSString * _Nullable )review
               withSong: ( Song * _Nullable )song
            withGenres: (NSArray * _Nullable)genres
          withSongTitle: ( NSString * _Nullable )songTitle
        withArtistTitle: (NSString * _Nullable )artistTitle
         withAlbumTitle: (NSString * _Nullable )albumTitle;

- (void) postWithCompletion: (PFBooleanResultBlock  _Nullable)completion;


@end

NS_ASSUME_NONNULL_END
