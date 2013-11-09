//
//  ViewCell.m
//  ScrollUIViews
//
//  Created by Sir Andrew on 11/8/13.
//  Copyright (c) 2013 edu.nyu.spcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *viewCount;
@property (weak, nonatomic) IBOutlet UILabel *description;
- (IBAction)viewVideoAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *descriptionField;
@property (strong, nonatomic) NSString *url;
@end
