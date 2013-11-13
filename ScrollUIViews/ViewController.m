//
//  ViewCell.m
//  ScrollUIViews
//
//  Created by Sir Andrew on 11/8/13.
//  Copyright (c) 2013 edu.nyu.spcs. All rights reserved.
//

#import "ViewController.h"
#import "Video.h"
#import "ViewCell.h"

//image cache
#import "UIImageView+WebCache.h"

#define kYouTubeMostPop [NSURL URLWithString:@"http://gdata.youtube.com/feeds/api/standardfeeds/most_popular?v=2&alt=json"]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    
    
    
    _videos = [[NSMutableArray alloc] init];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        NSData * data = [NSData dataWithContentsOfURL:kYouTubeMostPop];
        
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //update ui
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if ([_videos count] > 0) {
                [_mCollectionView reloadData];
                
            }
            
        });
    });
}

- (void)fetchedData:(NSData *)responseData {

    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    NSDictionary * feed = [json objectForKey:@"feed"];
    
    for (NSString *s in feed) {
        NSLog(@"feed: %@", s );
    }
    
    NSLog(@"\n" );
    
    NSArray * entry = [feed objectForKey:@"entry"];
 
    
    NSDictionary * node = [entry objectAtIndex:0];
    
    for (NSString *s in node) {
        NSLog(@"node: %@", s );
    }
    
    NSDictionary * title = [node objectForKey:@"title"];
    
    NSLog(@"\n" );
    NSLog(@"title: %@", [title objectForKey:@"$t"] );
    
    NSDictionary * media = [node objectForKey:@"media$group"];
    NSArray * thumbArray = [media objectForKey:@"media$thumbnail"];
    
    NSDictionary * thumb = [thumbArray objectAtIndex:0];
    
    NSLog(@"\n" );
    NSLog(@"thumURL: %@", [thumb objectForKey:@"url"] );
    
    

    
    for (NSDictionary *e in entry) {
        
        NSDictionary * title = [e objectForKey:@"title"];
        
        NSLog(@"\n" );
        NSLog(@"title: %@", [title objectForKey:@"$t"] );
        
        NSDictionary * media = [e objectForKey:@"media$group"];
        NSArray * thumbArray = [media objectForKey:@"media$thumbnail"];
        
        NSDictionary *viewStat = [e objectForKey:@"yt$statistics"];
        NSString *viewCount = [viewStat objectForKey:@"viewCount"];
        NSLog(@"View count: %@", viewCount);
        
        NSArray *author = [e objectForKey:@"author"];
        NSDictionary *authorObj = [author objectAtIndex:0];
        
        NSDictionary *authorN = [authorObj objectForKey:@"name"];
        NSString *authorName = [authorN objectForKey:@"$t"];
        
        
        NSString *mediaDescription = [[media objectForKey:@"media$description"] objectForKey:@"$t"];
        
        
        
        NSDictionary * thumb = [thumbArray objectAtIndex:2];
        NSLog(@"thumURL: %@", [thumb objectForKey:@"url"] );
        
        NSArray *link = [e objectForKey:@"link"];
        
        NSDictionary *v = [link objectAtIndex:0];
        
        NSString *videoURL = [v objectForKeyedSubscript:@"href"];
        
        Video *videoObject = [[Video alloc] init];
        
        videoObject.title = [title objectForKey:@"$t"];
        videoObject.imageURL = [thumb objectForKey:@"url"];
        videoObject.authorName = authorName;
        videoObject.viewCount = viewCount;
        videoObject.videoDesctiption = mediaDescription;
        videoObject.videoURL = videoURL;
        
        [_videos addObject:videoObject];
    }
    
    NSLog(@"count:%d", [_videos count]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_videos count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Building cell", nil);
  ViewCell *cell = [_mCollectionView dequeueReusableCellWithReuseIdentifier:@"ViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blueColor];
    
    Video *vidObject = [_videos objectAtIndex:indexPath.row];
    
    
    cell.title.numberOfLines = 2;

    cell.title.text = [vidObject.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [cell.title sizeToFit];
    
    
    [cell.image setImageWithURL:[NSURL URLWithString:vidObject.imageURL]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    cell.author.text = vidObject.authorName;
    cell.viewCount.text = [NSString stringWithFormat:@"%@ %@", vidObject.viewCount, @"views"];
    cell.descriptionField.text = vidObject.videoDesctiption;
    
    cell.url = vidObject.videoURL;
    
    return cell;
}



@end
