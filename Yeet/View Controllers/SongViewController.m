//
//  SongViewController.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/15/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "SongViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "Song.h"
#import "SongCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "ApplicationScheme.h"

@interface SongViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *songTableView;
@property (strong,nonatomic) AppDelegate *delegate;
@property (weak, nonatomic) NSDictionary *trackInfo;
@property (nonatomic,strong) NSMutableArray *songs;
@property (nonatomic,strong) NSMutableArray *filteredSongs;
@property (weak, nonatomic) IBOutlet UISearchBar *songSearchbar;


@end

@implementation SongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //stores session information for the Spotify SDK
    self.delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.songs = [[NSMutableArray alloc] init];

    self.songTableView.delegate = self;
    self.songTableView.dataSource = self;
   // self.songTableView.rowHeight = 200;
    self.songSearchbar.delegate = self;

    [self initDetails];
    self.filteredSongs = self.songs;
    
    id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
    self.view.backgroundColor = colorScheme.surfaceColor;
    self.songTableView.backgroundColor = colorScheme.surfaceColor;
}


-(void)initDetails{
    //insitantiating the APIManger and initializing it with our accessToken
    //The object now has the auth credential and can make the requests to the API
    APIManager *apimanager = [[APIManager alloc] initWithToken:self.delegate.sessionManager.session.accessToken];
    
    
    //stores the returned data from the API to local property trackInfo
    [apimanager getTrack: ^(NSDictionary * _Nonnull data, NSError * _Nonnull error) {
        if(error){
            NSLog(@"error: %@", [error localizedDescription]);
        }
        else{
            NSArray *songs = data[@"items"];
            for (NSDictionary *dictionary in songs) {
                // Allocate memory for object and initialize with the dictionary
                Song *song = [[Song alloc] initWithDictionary:dictionary[@"track"]];
                // Add the object to the Playlist's array
                [self.songs addObject:song];

            }
            [self.songTableView reloadData];
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"DetailsView"]) {
        DetailsViewController *detailsPostViewController = [segue destinationViewController];
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.songTableView indexPathForCell:tappedCell];
        Song *song = self.songs[indexPath.row];
        detailsPostViewController.song = song;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell" forIndexPath:indexPath];
    
    Song *song = self.filteredSongs[indexPath.row];
    
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: song.imageURL]];
    
    // Set poster to nil to remove the old one (when refreshing) and query for the new one
    cell.albumIV.image = nil;
    cell.songLabel.text = song.songName;
    cell.artistLabel.text = song.artistName;
    cell.albumLabel.text = song.albumName;
    
    id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
    cell.backgroundColor = colorScheme.surfaceColor;
    
    // Instantiate a weak link to the cell and fade in the image in the request
    __weak SongCell *weakSelf = cell;
    [weakSelf.albumIV setImageWithURLRequest:request placeholderImage:nil
                                           success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
        
        // imageResponse will be nil if the image is cached
        if (imageResponse) {
            weakSelf.albumIV.alpha = 0.0;
            weakSelf.albumIV.image = image;
            
            //Animate UIImageView back to alpha 1 over 0.3sec
            [UIView animateWithDuration:1 animations:^{
                weakSelf.albumIV.alpha = 1.0;
            }];
        }
        else {
            weakSelf.albumIV.image = image;
        }
    }
                                           failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
        // do something for the failure condition
    }];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.filteredSongs.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Song *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject.songName containsString:searchText];
        }];
        self.filteredSongs = [self.songs filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@", self.filteredSongs);
    }
    else {
        self.filteredSongs = self.songs;
    }
    [self.songTableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.songSearchbar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.songSearchbar.showsCancelButton = NO;
    self.songSearchbar.text = @"";
    [self.songSearchbar resignFirstResponder];
}


@end
