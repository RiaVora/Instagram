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

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        [UIView animateWithDuration:0.1 animations:^{
            self.timestampLabel.hidden = NO;
        }];
    } else {
        self.timestampLabel.hidden = YES;
    }

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
    self.timestampLabel.hidden = YES;

}

@end
