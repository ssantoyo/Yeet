//
//  Song.h
//  Yeet
//
//  Created by Sergio Santoyo on 7/23/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Song : NSObject <PFSubclassing>

//@property (nonatomic, strong) NSString *postID;
//@property (nonatomic, strong) NSString *userID;
//@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *artistTitle;
@property (nonatomic, strong) NSString *songTitle;
@property (nonatomic, strong) PFFileObject *albumcover;
//@property (nonatomic, strong) NSNumber *likeCount;
//@property (nonatomic, strong) NSNumber *commentCount;


//TODO: Fix method with correct properties
+ (void) songSelection: ( UIImage * _Nullable )image withReview: ( NSString * _Nullable )review withSongTitle: ( NSString * _Nullable )songTitle withArtistTitle: (NSString * _Nullable )artistTitle withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END
