//
//  APIManager.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/22/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "APIManager.h"
#import <AFNetworking/AFNetworking.h>

@interface APIManager()

@end

@implementation APIManager

@synthesize accessToken;

- (instancetype)initWithToken:(NSString *)token {
    self = [super init];
    self.accessToken = token;
    return self;
}



-(void)getTrack: (void (^)(NSDictionary *data, NSError *error)) completion {
    
    //define resource URL
    NSURL *URL = [NSURL URLWithString:@"https://api.spotify.com/v1/me/tracks"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //Headers
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:self.accessToken] forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];


    //Make API Request
    [manager GET:[URL absoluteString]
      parameters:nil
      progress:nil
     
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSLog(@"Reply POST JSON: %@", responseObject);
                
            completion(responseObject,nil);
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSLog(@"error: %@", error);
        
            completion(nil, error);
              }
         ];
    
}


@end
