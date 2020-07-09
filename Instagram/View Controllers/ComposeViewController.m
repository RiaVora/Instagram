//
//  ComposeViewController.m
//  Instagram
//
//  Created by Ria Vora on 7/6/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "MBProgressHUD.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *captionField;

@end

@implementation ComposeViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    self.chosenImageView.image = nil;
    self.chosenImageView.image = [self resizeImage:originalImage withSize:(CGSizeMake(325, 325))];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Actions

-(IBAction)pressedCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)pressedPost:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    NSString *caption = self.captionField.text;
    UIImage *image = self.chosenImageView.image;
    
    [Post postUserImage:image withCaption:caption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Post was successful!");
        } else {
            NSLog(@"Error posting photo: %@", error.localizedDescription);
        }
        [MBProgressHUD hideHUDForView:self.view animated:true];
    }];

    [self dismissViewControllerAnimated:true completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
