//
//  SongViewController.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/15/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "SongViewController.h"
#import "PostCell.h"
#import "APIManager.h"
#import "AppDelegate.h"

@interface SongViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *songTableView;
@property (strong,nonatomic) AppDelegate *delegate;
@property (weak, nonatomic) NSDictionary *trackInfo;

@end

@implementation SongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //stores session information for the Spotify SDK
    self.delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.songTableView.delegate = self;
    self.songTableView.dataSource = self;
    self.songTableView.rowHeight = 200;
    
    [self initDetails];
    
}


-(void)initDetails{
    //insitantiating the APIManger and initializing it with our accessToken
    //The object now has the auth credential and can make the requests to the API
    APIManager *apimanager = [[APIManager alloc] initWithToken:self.delegate.sessionManager.session.accessToken];
    
    
    //stores the returned data from the API to local property trackInfo
    [apimanager getTrack: ^(NSDictionary * _Nonnull data, NSError * _Nonnull error) {
        self.trackInfo = data;
           
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}


@end
