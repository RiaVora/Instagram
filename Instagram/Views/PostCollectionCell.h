//
//  PostCollectionCell.h
//  Instagram
//
//  Created by Ria Vora on 7/8/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

/* The PostCollectionCell class represents a single CollectionViewCell in the Profile view, and is used to display the photo of the post by referencing the given Post object.*/

#import <UIKit/UIKit.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionCell : UICollectionViewCell

- (void)updateValues:(Post *)post;

@end

NS_ASSUME_NONNULL_END
