//
//  DetailsViewController.h
//  Yeet
//
//  Created by Sergio Santoyo on 7/16/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, strong) Song *song;

@end

NS_ASSUME_NONNULL_END
