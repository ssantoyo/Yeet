//
//  LikeActivity.h
//  Yeet
//
//  Created by Sergio Santoyo on 7/29/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <Parse/Parse.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface LikeActivity : PFObject

@property(nonatomic,strong) PFUser *user;
@property(nonatomic,strong) Post *post;

+ (void) postLike: (Post * _Nullable)post withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
