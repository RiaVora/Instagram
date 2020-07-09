//
//  ComposeViewController.h
//  Instagram
//
//  Created by Ria Vora on 7/6/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

/* The ComposeViewController gives the user the option to create a new post, and is initiated from the camera button on the FeedViewController. With a UIImagePicker the ComposeViewController gives the user the option to choose a photo from their existing camera roll or take a photo, and post it with a caption. When posted, the ComposeViewController references a method in the Post class that creates a new Post.*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *chosenImageView;
@property (weak, nonatomic) IBOutlet UITextField *captionTextField;

@end

NS_ASSUME_NONNULL_END
