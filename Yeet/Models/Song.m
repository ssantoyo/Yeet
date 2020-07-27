//
//  Song.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/23/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "Song.h"

@implementation Song

@dynamic songName;
@dynamic artistName;
@dynamic albumName;
@dynamic spotifyID;
@dynamic imageURL;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.songName = dictionary[@"name"];
        self.artistName= dictionary[@"artists"][0][@"name"];
        self.albumName = dictionary[@"album"][@"name"];
        self.spotifyID = dictionary[@"id"];
        self.imageURL = dictionary[@"album"][@"images"][0][@"url"];
        // TODO: MISSING PROPERTIES
        
      // Initialize any other properties
    }
    return self;
}

+ (nonnull NSString *)parseClassName {
    return @"Song";
}



@end
