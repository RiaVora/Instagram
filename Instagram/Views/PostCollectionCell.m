//
//  PostCollectionCell.m
//  Instagram
//
//  Created by Ria Vora on 7/8/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import "PostCollectionCell.h"

@interface PostCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (strong, nonatomic) Post *post;

@end

@implementation PostCollectionCell

#pragma mark - Setup

- (void)updateValues:(Post *)post {
    self.post = post;
    
    self.pictureView.image = nil;
    [post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error with getting data from Image: %@", error.localizedDescription);
        } else {
            self.pictureView.image = [UIImage imageWithData:data];
        }
    }];
}

@end
