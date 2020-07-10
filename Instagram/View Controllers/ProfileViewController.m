//
//  ProfileViewController.m
//  Instagram
//
//  Created by Ria Vora on 7/8/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "PostCollectionCell.h"
#import "DetailsViewController.h"
#import "MBProgressHUD.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *posts;
@property (weak, nonatomic) IBOutlet UIImageView *profileView;

@end

@implementation ProfileViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self initValues];
    [self styleLayout];
    [self getPosts];
    [self initRefreshControl];
}

#pragma mark - Setup

- (void)initValues {
    if (self.user == nil) {
        self.user = [PFUser currentUser];
    }
    self.userLabel.text = self.user.username;
    
    if (self.user[@"image"]) {
        [self.user[@"image"] getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error with getting data from Image: %@", error.localizedDescription);
            } else {
                self.profileView.image = [UIImage imageWithData:data];
            }
        }];
    } else {
        self.profileView.image = [UIImage imageNamed:@"profile_tab"];
    }
}

- (void)initRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getPosts) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
}

- (void)styleLayout {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)
    self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    CGFloat postersPerLine = 2;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
}

#pragma mark - Data Query

- (void)getPosts {
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:self.user];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray <Post *>* _Nullable posts, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error with fetching posts specific to the user: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully got posts for profile!");
            
            self.posts = posts;
            [self.collectionView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:true];
            [self.refreshControl endRefreshing];
        }
    }];
}

#pragma mark - UICollectionViewDataSource

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    [cell updateValues:self.posts[indexPath.item]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

#pragma mark - Actions
- (IBAction)tappedProfilePhoto:(UITapGestureRecognizer *)sender {
    if ([self.user isEqual:PFUser.currentUser]) {
        [self initImagePicker];
    } else {
        NSString *message = [NSString stringWithFormat:@"You are logged in as '%@' so you cannot change the profile photo of '%@'", PFUser.currentUser.username, self.user.username];
        [self displayAlert:@"Cannot Change Picture" :message];
    }
    
}

#pragma mark - Alerts

- (void)displayAlert:(NSString *)title :(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{}];
}

#pragma mark - UIImagePickerController

- (void)initImagePicker {
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *resizedImage = [self resizeImage:originalImage withSize:(CGSizeMake(90, 90))];
    
    self.profileView.image = nil;
    self.profileView.image = resizedImage;
    self.user[@"image"] = [Post getPFFileFromImage:resizedImage];
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Successfully saved image");
        } else {
            NSLog(@"Error saving image: %@", error.localizedDescription);
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    Post *post = self.posts[indexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    
    detailsViewController.post = post;
}

@end
