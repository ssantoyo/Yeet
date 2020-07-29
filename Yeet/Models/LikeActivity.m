//
//  LikeActivity.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/29/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "LikeActivity.h"

@implementation LikeActivity

@dynamic user;
@dynamic post;

+ (nonnull NSString *)parseClassName {
    return @"Likes";
}

+ (void) postLike: (Post * _Nullable) post withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    LikeActivity *like= [LikeActivity new];
    like.user = [PFUser currentUser];
    like.post = post;
    [like saveInBackgroundWithBlock: completion];
}

@end
