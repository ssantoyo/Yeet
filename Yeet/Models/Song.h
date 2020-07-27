//
//  Song.h
//  Yeet
//
//  Created by Sergio Santoyo on 7/23/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Song : PFObject <PFSubclassing>

//MARK: Properties
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *spotifyID;
@property (nonatomic, strong) NSString *songName;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic,strong) NSString *albumName;

// MARK: initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
