//
//  ViewCell.m
//  ScrollUIViews
//
//  Created by Sir Andrew on 11/8/13.
//  Copyright (c) 2013 edu.nyu.spcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property (nonatomic, strong) NSMutableArray *videos;
@end
