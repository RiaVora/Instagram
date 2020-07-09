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

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

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
    self.userLabel.text = PFUser.currentUser.username;
    if (PFUser.currentUser[@"image"]) {
        [PFUser.currentUser[@"image"] getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error with getting data from Image: %@", error.localizedDescription);
            } else {
                self.profileView.image = [UIImage imageWithData:data];
            }
        }];        
    } else {
        self.profileView.image = [UIImage imageNamed:@"profile_tab"];
    }
    
    [self getPosts];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getPosts) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    
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
    [postQuery whereKey:@"author" equalTo:PFUser.currentUser];
    
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
    cell.post = self.posts[indexPath.item];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
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
