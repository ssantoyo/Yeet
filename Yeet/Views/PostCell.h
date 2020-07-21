//
//  PostCell.h
//  Yeet
//
//  Created by Sergio Santoyo on 7/15/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *atristNameLabel;




@end

NS_ASSUME_NONNULL_END
