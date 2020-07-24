//
//  APIManager.h
//  Yeet
//
//  Created by Sergio Santoyo on 7/22/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <AFOAuth2Manager/AFOAuth2Manager.h>
#import <AFNetworking/AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : AFOAuth2Manager

@property (nonatomic,strong) NSString *accessToken;


-(instancetype)initWithToken:(NSString *)token;

-(void)getTrack: (void (^)(NSDictionary *data, NSError *error)) completion;

@end

NS_ASSUME_NONNULL_END
