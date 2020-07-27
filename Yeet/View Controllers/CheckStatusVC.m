//
//  CheckStatusVC.m
//  Yeet
//
//  Created by Sergio Santoyo on 7/25/20.
//  Copyright © 2020 ssantoyo. All rights reserved.
//

#import "CheckStatusVC.h"
#import "AppDelegate.h"

@interface CheckStatusVC ()

@property(nonatomic,strong) AppDelegate *delegate;

@end

@implementation CheckStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [self checkAccess];
}

-(void)checkAccess{
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
        [self performSegueWithIdentifier:@"songSegue" sender:nil];

           }];
           // add the OK action to the alert controller
           [alert addAction:authorizeAction];
    
    [self presentViewController:alert animated:YES completion:^{
    }];}
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
