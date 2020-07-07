//
//  ComposeViewController.h
//  Instagram
//
//  Created by Ria Vora on 7/6/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *chosenImageView;
@property (weak, nonatomic) IBOutlet UITextField *captionTextField;

@end

NS_ASSUME_NONNULL_END
