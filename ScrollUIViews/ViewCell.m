//
//  ViewCell.m
//  ScrollUIViews
//
//  Created by Sir Andrew on 11/8/13.
//  Copyright (c) 2013 edu.nyu.spcs. All rights reserved.
//

#import "ViewCell.h"

@implementation ViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)viewVideoAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: self.url]];
}
@end
