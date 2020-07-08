//
//  PostCollectionCell.m
//  Instagram
//
//  Created by Ria Vora on 7/8/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import "PostCollectionCell.h"

@implementation PostCollectionCell

- (void)setPicture:(Post *)post {
    _post = post;


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
