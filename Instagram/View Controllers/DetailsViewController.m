//
//  DetailsViewController.m
//  Instagram
//
//  Created by Ria Vora on 7/8/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import "DetailsViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateValues];
}

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

@end
