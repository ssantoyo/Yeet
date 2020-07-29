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

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;
@property (nonatomic, strong) NSMutableArray *posts;
@property (strong, nonatomic) NSMutableArray *filteredData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong,nonatomic) AppDelegate *delegate;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.timelineTableView.dataSource = self;
    self.timelineTableView.delegate = self;
    self.timelineTableView.rowHeight = 200;
    
    //stores session information for the Spotify SDK
    self.delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self getTimeline];
    //will refresh the table view
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTimeline) forControlEvents:UIControlEventValueChanged];
    [self.timelineTableView insertSubview:self.refreshControl atIndex:0];
    
    //added the local data, that can be searched 
    self.searchBar.delegate = self;
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
            // do something with the array of object returned by the call
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
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
    cell.userLabel.text = nil;
    cell.userLabel.text = cell.post.author[@"username"];
    cell.userImageView.file = nil;
    cell.userImageView.file = cell.post.author[@"userimage"];
    [cell.userImageView loadInBackground];
    cell.userImageView.layer.masksToBounds = true;
    cell.userImageView.layer.cornerRadius = 60;
    
    NSNumber *number = cell.post.likeCount;
      int value = [number intValue];
      [cell.likeButton setTitle:[NSString stringWithFormat:@"%i", value] forState:UIControlStateNormal];
    
    return cell;
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
