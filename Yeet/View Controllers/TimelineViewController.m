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

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;
@property (nonatomic, strong) NSMutableArray *posts;
//inital properties of my search bar
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *filteredData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UIRefreshControl *refreshControl;



@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.timelineTableView.dataSource = self;
    self.timelineTableView.delegate = self;
    self.timelineTableView.rowHeight = 200;
    
    [self getTimeline];
    //will refresh the table view
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTimeline) forControlEvents:UIControlEventValueChanged];
    [self.timelineTableView insertSubview:self.refreshControl atIndex:0];
    
    //added the local data, that can be searched 
    self.searchBar.delegate = self;

    self.data = @[@"New York, NY", @"Los Angeles, CA", @"Chicago, IL", @"Houston, TX",
                  @"Philadelphia, PA", @"Phoenix, AZ", @"San Diego, CA", @"San Antonio, TX",
                  @"Dallas, TX", @"Detroit, MI", @"San Jose, CA", @"Indianapolis, IN",
                  @"Jacksonville, FL", @"San Francisco, CA", @"Columbus, OH", @"Austin, TX",
                  @"Memphis, TN", @"Baltimore, MD", @"Charlotte, ND", @"Fort Worth, TX"];

    self.filteredData = self.data;
 
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
            //refreshes tableView data
            [self.timelineTableView reloadData];
            // do something with the array of object returned by the call
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
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
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    
    cell.reviewLabel.text = post.review;
    
    cell.userLabel.text = nil;
    cell.userLabel.text = cell.post.author[@"username"];
    
    cell.userImageView.file = nil;
    cell.userImageView.file = cell.post.author[@"userimage"];
    [cell.userImageView loadInBackground];
    cell.userImageView.layer.masksToBounds = true;
    cell.userImageView.layer.cornerRadius = 25;
    //cell.textLabel.text = self.filteredData[indexPath.row];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.filteredData.count;
}







- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject containsString:searchText];
        }];
        self.filteredData = [self.data filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@", self.filteredData);
    }
    else {
        self.filteredData = self.data;
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
