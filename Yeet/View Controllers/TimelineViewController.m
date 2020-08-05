//
//  TimelineViewController.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/14/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "TimelineViewController.h"
#import "PostCell.h"
#import "Post.h"
#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import <PFUser.h>
#import <PFImageView.h>
#import "AppDelegate.h"
#import "Song.h"
#import "SongCell.h"
#import "OpenPostViewController.h"
#import "LikeActivity.h"
#import <QuartzCore/QuartzCore.h>
#import "ApplicationScheme.h"
#import "InfiniteScrollActivityView.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;
@property (nonatomic, strong) NSMutableArray *posts;
@property (strong, nonatomic) NSMutableArray *genres;
@property (strong, nonatomic) NSNumber *searchKey;
@property (strong, nonatomic) NSMutableArray *filteredData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong,nonatomic) AppDelegate *delegate;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (strong, nonatomic) InfiniteScrollActivityView *loadingMoreView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.timelineTableView.dataSource = self;
    self.timelineTableView.delegate = self;
    self.timelineTableView.rowHeight = 220;
    
    //stores session information for the Spotify SDK
    self.delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self getTimeline];
    self.genres = [[NSMutableArray alloc] init];
    //will refresh the table view
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(resetFilters) forControlEvents:UIControlEventValueChanged];
    [self.timelineTableView insertSubview:self.refreshControl atIndex:0];
    
    //added the local data, that can be searched 
    self.searchBar.delegate = self;
    
    // TODO: Theme our interface with our colors
    id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
    self.view.backgroundColor = colorScheme.surfaceColor;
    self.timelineTableView.backgroundColor = colorScheme.surfaceColor;
    
    // Set up Infinite Scroll loading indicator
    CGRect frame = CGRectMake(0, self.timelineTableView.contentSize.height, self.timelineTableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[InfiniteScrollActivityView alloc] initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.timelineTableView addSubview:self.loadingMoreView];
    
    UIEdgeInsets insets = self.timelineTableView.contentInset;
    insets.bottom += InfiniteScrollActivityView.defaultHeight;
    self.timelineTableView.contentInset = insets;
    
}

-(void)resetFilters{
    [self.genres removeAllObjects];
    [self getTimeline];
}

-(void)getTimeline{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //reorders post from recently added post to the top
    [query orderByDescending: @"createdAt"];
    query.limit = 20;
    [query includeKey:@"author"];

    NSLog(@"Post is being refreshed");

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = (NSMutableArray *)posts;
            self.filteredData = self.posts;

            //refreshes tableView data
            [self.timelineTableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

-(void)getGenres{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //reorders post from recently added post to the top
    [query orderByDescending: @"createdAt"];
    query.limit = 20;
    [query includeKey:@"author"];
    
    //Add a constrint to the query tht requires a particular key's objetc to the provided object
    [query whereKey:@"searchKey" equalTo:self.searchKey];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = (NSMutableArray *)posts;
            self.filteredData = self.posts;

            //refreshes tableView data
            [self.timelineTableView reloadData];
            // do something with the array of object returned by the call
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

-(void)calculateSearch: (NSArray * _Nullable)genres{
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
    self.searchKey = [NSNumber numberWithInt:keyValue];
}

- (IBAction)tapRap:(id)sender {
    UIButton *button = (UIButton *)sender;
    // If not pressed
    if ([button.currentTitleColor isEqual:[UIColor systemBlueColor]]) {
        [button setTitleColor:[UIColor colorWithRed:0/255.0 green:44/255.0 blue:145/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.genres addObject: @"Rap"];
        [self calculateSearch:self.genres];
        [self getGenres];

    // If already pressed
    } else {
        [button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    }
        
}
- (IBAction)tapHiphop:(id)sender {
    UIButton *button = (UIButton *)sender;
    // If not pressed
    if ([button.currentTitleColor isEqual:[UIColor systemBlueColor]]) {
        [button setTitleColor:[UIColor colorWithRed:0/255.0 green:44/255.0 blue:145/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.genres addObject: @"Hiphop"];
        [self calculateSearch:self.genres];
        [self getGenres];
        
    // If already pressed
    } else {
        [button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    }
}
- (IBAction)tapRB:(id)sender {
    UIButton *button = (UIButton *)sender;
    // If not pressed
    if ([button.currentTitleColor isEqual:[UIColor systemBlueColor]]) {
        [button setTitleColor:[UIColor colorWithRed:0/255.0 green:44/255.0 blue:145/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.genres addObject: @"RandB"];
        [self calculateSearch:self.genres];
        [self getGenres];
    // If already pressed
    } else {
        [button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    }
}
- (IBAction)tapPop:(id)sender {
    UIButton *button = (UIButton *)sender;
    // If not pressed
    if ([button.currentTitleColor isEqual:[UIColor systemBlueColor]]) {
        [button setTitleColor:[UIColor colorWithRed:0/255.0 green:44/255.0 blue:145/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.genres addObject: @"Pop"];
        [self calculateSearch:self.genres];
        [self getGenres];
        
    // If already pressed
    } else {
        [button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    }
}
- (IBAction)tapLatinX:(id)sender {
    UIButton *button = (UIButton *)sender;
    // If not pressed
    if ([button.currentTitleColor isEqual:[UIColor systemBlueColor]]) {
        [button setTitleColor:[UIColor colorWithRed:0/255.0 green:44/255.0 blue:145/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.genres addObject: @"LatinX"];
        [self calculateSearch:self.genres];
        [self getGenres];
        
    // If already pressed
    } else {
        [button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    }
}





- (IBAction)onTapSongList:(id)sender {
    if(self.delegate.sessionManager.session.accessToken){
        [self performSegueWithIdentifier:@"songSegue" sender:nil];

    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Authorize app via Spotify on ProfileView Controller"
               message:@"To view songs, app needs to be authorized via Spotify Account" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // handle response here.
        }];
        // add the OK action to the alert controller
        [alert addAction:cancelAction];
        
        UIAlertAction *authorizeAction = [UIAlertAction actionWithTitle:@"Authorize" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               // handle response here.
            [self.delegate authorizationLogin];
               }];
               // add the OK action to the alert controller
               [alert addAction:authorizeAction];
        
        [self presentViewController:alert animated:YES completion:^{
        }];}
}

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.timelineTableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.timelineTableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.timelineTableView.isDragging) {
            self. isMoreDataLoading = true;
            [self loadMoreData];
        }
    }
}
*/



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"OpenPostView"]) {
        OpenPostViewController *openPostViewController = [segue destinationViewController];
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.timelineTableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        openPostViewController.post = post;
    }
   
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    
    Post *post = self.filteredData[indexPath.row];
    cell.post = post;
    
    cell.reviewLabel.text = post.review;
    cell.songNameLabel.text = post.songTitle;
    cell.artistNameLabel.text = post.artistTitle;
    cell.albumNameLabel.text = post.albumTitle;
    cell.userLabel.text = cell.post.author[@"username"];
    cell.userImageView.file = cell.post.author[@"userimage"];
    [cell.userImageView loadInBackground];
    cell.userImageView.layer.masksToBounds = true;
    cell.userImageView.layer.cornerRadius = 60;
    
    // TODO: Theme our interface with our colors
    id<MDCColorScheming> colorScheme = [ApplicationScheme sharedInstance].colorScheme;
    cell.backgroundColor = colorScheme.surfaceColor;
    
    NSNumber *number = cell.post.likeCount;
      int value = [number intValue];
      [cell.likeButton setTitle:[NSString stringWithFormat:@"%i", value] forState:UIControlStateNormal];
    
    return cell;
}
//Fades in post as they are being shared
- (void)tableView:(UITableView *)tableView willDisplayCell:(PostCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (cell.isAnimated) {return;}
    
    cell.alpha = 0.0;
    [UIView animateWithDuration:1.0 animations:^{
       cell.alpha = 1.0;
       cell.isAnimated = YES;
    }];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.filteredData.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Post *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject.author.username containsString:searchText];
        }];
        self.filteredData = [self.posts filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@", self.filteredData);
    }
    else {
        self.filteredData = self.posts;
    }
    [self.timelineTableView reloadData];
 
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}




@end
