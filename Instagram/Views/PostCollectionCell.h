//
//  PostCollectionCell.h
//  Instagram
//
//  Created by Ria Vora on 7/8/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
