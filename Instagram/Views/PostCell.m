//
//  PostCell.m
//  Instagram
//
//  Created by Ria Vora on 7/7/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import "PostCell.h"
#import "DateTools.h"

@implementation PostCell

#pragma mark - Init

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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

- (void)addLike {
    [self.post addLike];
    self.likeCount.text = [NSString stringWithFormat:@"%@", self.post.likeCount];
}

@end
