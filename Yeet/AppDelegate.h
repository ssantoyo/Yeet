//
//  AppDelegate.h
//  Yeet
//
//  Created by Sergio Santoyo on 7/14/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpotifyiOS/SpotifyiOS.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate, SPTSessionManagerDelegate,SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate>

@property (nonatomic, strong) SPTSessionManager *sessionManager;
@property (nonatomic, strong) SPTConfiguration *configuration;
@property (nonatomic, strong)SPTAppRemote *appRemote;


@end

