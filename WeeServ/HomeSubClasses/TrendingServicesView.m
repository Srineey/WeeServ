//
//  TrendingServicesView.m
//  WeeServ
//
//  Created by saran c on 27/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "TrendingServicesView.h"
#import "UIImageView+WebCache.h"
#import "GlobalResourcesViewController.h"

@implementation TrendingServicesView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self    =   [super initWithFrame:frame];
    
    viewWidth = self.frame.size.width;
    viewHeight = self.frame.size.height;
    
    [self setUI];
    
    return self;
}

- (void)setUI
{
    recentUpdatesView = [[UIView alloc] init];
    [recentUpdatesView setFrame:CGRectMake(0, 0, viewWidth, 30)];
    [recentUpdatesView setBackgroundColor:kTrendingServicesBgColor];
    [self addSubview:recentUpdatesView];
    
    lblRecentUpdates = [[UILabel alloc] init];
    [lblRecentUpdates setFrame:CGRectMake(10, 7, 200, 16)];
    [lblRecentUpdates setTextColor:kServicesNameColor];
    [lblRecentUpdates setTextAlignment:NSTextAlignmentLeft];
    [lblRecentUpdates setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblRecentUpdates setText:@"Recent Updates"];
    [recentUpdatesView addSubview:lblRecentUpdates];
    
    recentUpdatesScrl = [[UIScrollView alloc] init];
    [recentUpdatesScrl setFrame:CGRectMake(0, recentUpdatesView.frame.origin.y + recentUpdatesView.frame.size.height, viewWidth, 100)];
    [recentUpdatesScrl setBackgroundColor:kTrendingServicesBgColor];
    [recentUpdatesScrl setShowsHorizontalScrollIndicator:NO];
    [recentUpdatesScrl setShowsVerticalScrollIndicator:NO];
    [self addSubview:recentUpdatesScrl];
}

- (void)categoryListView:(NSDictionary *)servicesDict
{
    int xPos = 10;
    
    @autoreleasepool {
        
        NSArray *categoryAry = [servicesDict objectForKey:@"trending"];
        
        for(int i = 0; i < [categoryAry count]; i++)
        {
            NSString *stringUrl = [[categoryAry objectAtIndex:i] objectForKey:@"icon"];
            
            UIView *circleView = [[UIView alloc] init];
            [circleView setFrame:CGRectMake(xPos, 0, kcategoryCircleWidth, kcategoryCircleHeight)];
            [circleView setBackgroundColor:[UIColor whiteColor]];
            [circleView.layer setCornerRadius:kcategoryCircleWidth/2];
            [circleView setClipsToBounds:YES];
            [recentUpdatesScrl addSubview:circleView];
            
            categoryImgIcon = [[UIImageView alloc] init];
            [categoryImgIcon setFrame:CGRectMake(20, 22, kcategoryImgWidth, kcategoryImgHeight)];
            [categoryImgIcon setBackgroundColor:[UIColor clearColor]];
            [categoryImgIcon sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"] ];
            [circleView addSubview:categoryImgIcon];
            
            lblCategoryName = [[UILabel alloc] init];
            [lblCategoryName setFrame:CGRectMake(xPos, circleView.frame.origin.y + kcategoryCircleHeight, kcategoryCircleWidth, 35)];
            [lblCategoryName setTextColor:kServicesNameColor];
            [lblCategoryName setTextAlignment:NSTextAlignmentCenter];
            [lblCategoryName setFont:[UIFont fontWithName:kRobotoRegular size:12]];
            [recentUpdatesScrl addSubview:lblCategoryName];
            
            [lblCategoryName setText:[[categoryAry objectAtIndex:i] objectForKey:@"name"]];
            
            xPos += kcategoryCircleWidth + 10;
        }
        
        [recentUpdatesScrl setBounces:NO];
        recentUpdatesScrl.contentSize = CGSizeMake((kcategoryCircleWidth * [categoryAry count]) + ([categoryAry count] * 11), 100);
        [recentUpdatesScrl setPagingEnabled:YES];
    }
}

@end
