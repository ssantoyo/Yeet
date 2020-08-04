//
//  Utils.h
//  Yeet
//
//  Created by Sergio Santoyo on 8/4/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;


@end

NS_ASSUME_NONNULL_END
