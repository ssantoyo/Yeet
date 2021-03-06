//
//  PostCell.h
//  Yeet
//
//  Created by Sergio Santoyo on 7/15/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import "PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (assign, nonatomic) BOOL isAnimated;


@end

NS_ASSUME_NONNULL_END
