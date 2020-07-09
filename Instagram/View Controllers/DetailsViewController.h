//
//  DetailsViewController.h
//  Instagram
//
//  Created by Ria Vora on 7/8/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

/* The DetailsViewController represents the detailed view of a post that the user sees after clicking on a PostCell in the FeedViewController or a PostCollectionCell in the ProfileViewController. The details view operates similar to the PostCell and PostCollection cell in that it takes a Post (passed through a segue) and uses it to initialize it's labels and views.*/


#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (strong, nonatomic) Post *post;

@end
NS_ASSUME_NONNULL_END
