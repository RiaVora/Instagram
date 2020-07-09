//
//  PostCell.h
//  Instagram
//
//  Created by Ria Vora on 7/7/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

/* The PostCell class represents a single TableViewCell in the Timeline view, and is used to information from the Post class and carry out actions such as liking a Post.*/

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (strong, nonatomic) Post *post;

- (void)updateValues;
- (void)addLike;

@end

NS_ASSUME_NONNULL_END
