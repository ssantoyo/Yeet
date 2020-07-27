//
//  SongCell.h
//  Yeet
//
//  Created by Sergio Santoyo on 7/15/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SongCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *albumIV;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;


@end

NS_ASSUME_NONNULL_END
