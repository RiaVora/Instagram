//
//  DetailsViewController.m
//  Instagram
//
//  Created by Ria Vora on 7/8/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import "DetailsViewController.h"
#import "DateTools.h"
#import "ProfileViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;


@end

@implementation DetailsViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateValues];
}

#pragma mark - Setup

- (void)updateValues {
    [self.post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error with getting data from Image: %@", error.localizedDescription);
        } else {
            self.pictureView.image = [UIImage imageWithData:data];
        }
    }];
    
    self.userLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    self.likeCount.text = [NSString stringWithFormat:@"%@", self.post.likeCount];
    self.commentCount.text = [NSString stringWithFormat:@"%@", self.post.commentCount];
    self.timestampLabel.text = [NSString stringWithFormat:@"|  Posted %@ ago", self.post.createdAt.shortTimeAgoSinceNow];
}

#pragma mark - Actions

- (IBAction)tappedUser:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"profileSegue" sender:sender];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"profileSegue"]) {
        ProfileViewController *profilevc = [segue destinationViewController];
        profilevc.user = self.post.author;
    }
}

@end
