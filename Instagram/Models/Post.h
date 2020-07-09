//
//  Post.h
//  Instagram
//
//  Created by Ria Vora on 7/6/20.
//  Copyright © 2020 Ria Vora. All rights reserved.
//

/* The Post class represents a single Post PFObject from Parse (and is therefore a child class of PFObject). A Post instance has all the attributes from Parse readily accessible as attributes.*/


#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;
- (void)addLike;
@end
