//
//  Utils.m
//  Yeet
//
//  Created by Sergio Santoyo on 8/4/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}



@end
