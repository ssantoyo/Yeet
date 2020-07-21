//
//  AppDelegate.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/14/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <SpotifyiOS/SpotifyiOS.h>
#import "AppDelegate.h"
#import "Post.h"

static NSString * const spotifyClientID = @"610bb4f77ce84a78b82fc4cf96b5e894";
static NSString * const spotifyRedirectURL = @"yeet-login://callback";

//URL for token swap for Parse
static NSString * const tokenSwapURL = @"https://yeetfb.herokuapp.com/api/token";
static NSString * const tokenRefreshURL = @"https://yeetfb.herokuapp.com/api/refresh_token";

@interface AppDelegate () <SPTSessionManagerDelegate,SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
             
             configuration.applicationId = @"myAppId";
             configuration.server = @"https://yeetfbu.herokuapp.com/parse";
         }];
         
         [Parse initializeWithConfiguration:config];
    
    [self initialconfig];
    [self confirmSession];

    return YES;
}

- (void)initialconfig{
    //Handles the initial configuration for the Spotify session manager and token swapping
    self.configuration  = [[SPTConfiguration alloc] initWithClientID:spotifyClientID redirectURL:[NSURL URLWithString:spotifyRedirectURL]];
    self.configuration.tokenSwapURL = [NSURL URLWithString: tokenSwapURL];
    self.configuration.tokenRefreshURL = [NSURL URLWithString:tokenRefreshURL];
   
    self.configuration.playURI = @"";
    self.appRemote = [[SPTAppRemote alloc] initWithConfiguration:self.configuration logLevel:SPTAppRemoteLogLevelDebug];
    self.appRemote.delegate = self;
    }

-(void)confirmSession{
    // verifys a session, and open the Spotify app if available
    SPTScope requestedScope = SPTAppRemoteControlScope;
    self.sessionManager = [SPTSessionManager sessionManagerWithConfiguration:self.configuration delegate:self];

    [self.sessionManager initiateSessionWithScope:requestedScope options:SPTDefaultAuthorizationOption];

}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    [self.sessionManager application:app openURL:url options:options];
    return true;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  if (self.appRemote.isConnected) {
    [self.appRemote disconnect];
      NSLog(@"App remote disconnected");
  }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  if (self.appRemote.connectionParameters.accessToken) {
    [self.appRemote connect];
      NSLog(@"App remote connected");
  }
}


#pragma mark - SPTSessionManagerDelegate
- (void)sessionManager:(SPTSessionManager *)manager didInitiateSession:(SPTSession *)session
{
    NSLog(@"success: %@", session);
    self.appRemote.connectionParameters.accessToken = session.accessToken;
    //[self.appRemote connect];
}

- (void)sessionManager:(SPTSessionManager *)manager didFailWithError:(NSError *)error
{
  NSLog(@"fail: %@", error);
}

- (void)sessionManager:(SPTSessionManager *)manager didRenewSession:(SPTSession *)session
{
  NSLog(@"renewed: %@", session);
}



#pragma mark - SPTAppRemoteDelegate

- (void)appRemote:(nonnull SPTAppRemote *)appRemote didDisconnectWithError:(nullable NSError *)error {
    NSLog(@"disconnected");
}

- (void)appRemote:(nonnull SPTAppRemote *)appRemote didFailConnectionAttemptWithError:(nullable NSError *)error {
    NSLog(@"failed");
}

- (void)appRemoteDidEstablishConnection:(nonnull SPTAppRemote *)appRemote {
    // Connection was successful, you can begin issuing commands
    self.appRemote.playerAPI.delegate = self;
    [self.appRemote.playerAPI subscribeToPlayerState:^(id _Nullable result, NSError * _Nullable error) {
      if (error) {
        NSLog(@"error: %@", error.localizedDescription);
      }
      else{
          NSLog(@"connected");
      }
    }];
}

- (void)playerStateDidChange:(nonnull id<SPTAppRemotePlayerState>)playerState {
    NSLog(@"Track name: %@", playerState.track.name);
    
}

@end
