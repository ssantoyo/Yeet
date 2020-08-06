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

+ (NSNumber *)calculateSearch: (NSArray * _Nullable)genres{
  //calculates a unique key based off the indexes of the genres
    NSDictionary *genreIndex = @{
    @"Hiphop": @(0),
    @"Rap": @(1),
    @"RandB": @(2),
    @"Pop": @(3),
    @"LatinX": @(4)
};
    int keyValue = 0;
    for (NSString *genre in genres){
    double power = pow(2,[genreIndex[genre] intValue]);
    keyValue +=  power;
    }
    return [NSNumber numberWithInt:keyValue];
}

@end
