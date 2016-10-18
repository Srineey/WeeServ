//
//  ServicesListView.m
//  WeeServ
//
//  Created by saran c on 19/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "ServicesListView.h"
#import "UIImageView+WebCache.h"
#import "GlobalResourcesViewController.h"

@implementation ServicesListView

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
    
    [self setUI];
    
    return self;
}

- (void)setUI
{
    serviceTitleView = [[UIView alloc] init];
    [serviceTitleView setFrame:CGRectMake(0, 0, viewWidth, 30)];
    [serviceTitleView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:serviceTitleView];
    
    lblServiceName = [[UILabel alloc] init];
    [lblServiceName setFrame:CGRectMake(10, 8, 200, 14)];
    [lblServiceName setTextColor:kServiceNameFontColor];
    [lblServiceName setTextAlignment:NSTextAlignmentLeft];
    [lblServiceName setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [serviceTitleView addSubview:lblServiceName];
    
    lblSeeAll = [[UILabel alloc] init];
    [lblSeeAll setFrame:CGRectMake(viewWidth - 65, 8, 36, 14)];
    [lblSeeAll setTextColor:kSeeAllFontColor];
    [lblSeeAll setTextAlignment:NSTextAlignmentLeft];
    [lblSeeAll setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblSeeAll setText:@"See all"];
    [serviceTitleView addSubview:lblSeeAll];
    
    seeAllIndicatorImg = [[UIImageView alloc] init];
    [seeAllIndicatorImg setFrame:CGRectMake(lblSeeAll.frame.origin.x + lblSeeAll.frame.size.width + 8, 11, 5, 10)];
    [seeAllIndicatorImg setImage:[UIImage imageNamed:@"seeall_arrow_left"]];
    [serviceTitleView addSubview:seeAllIndicatorImg];
    
    btnSeeAll = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSeeAll setFrame:CGRectMake(viewWidth - 60, 8, 60, 14)];
    [btnSeeAll setBackgroundColor:[UIColor clearColor]];
    [btnSeeAll addTarget:self action:@selector(seeAllCategories:) forControlEvents:UIControlEventTouchUpInside];
    [serviceTitleView addSubview:btnSeeAll];
    
    serviceListScrl = [[UIScrollView alloc] init];
    [serviceListScrl setFrame:CGRectMake(0, serviceTitleView.frame.origin.y + serviceTitleView.frame.size.height, viewWidth, 150)];
    [serviceListScrl setBackgroundColor:[UIColor whiteColor]];
    [serviceListScrl setShowsHorizontalScrollIndicator:NO];
    [serviceListScrl setShowsVerticalScrollIndicator:NO];
    [self addSubview:serviceListScrl];
}

- (void)categoryListView:(NSDictionary *)servicesDict
{
    int xPos = 10;
    
    @autoreleasepool {
        
        currentServicesGroup = [NSDictionary dictionaryWithDictionary:servicesDict];
        
        lblServiceName.text = [servicesDict objectForKey:kServiceName];
        
        NSArray *categoryAry = [servicesDict objectForKey:@"category"];
        
        [btnSeeAll setTag:[[servicesDict objectForKey:@"id"] intValue]];
        
        for(int i = 0; i < [categoryAry count]; i++)
        {
            NSString *stringUrl = [[categoryAry objectAtIndex:i] objectForKey:@"image"];
            
            categoryImg = [[UIImageView alloc] init];
            [categoryImg setFrame:CGRectMake(xPos, 0, kcategoryImgWidth, kcategoryImgHeight)];
            [categoryImg setBackgroundColor:[UIColor clearColor]];
            [categoryImg sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"]];
            [serviceListScrl addSubview:categoryImg];
            
            lblCategoryName = [[UILabel alloc] init];
            [lblCategoryName setFrame:CGRectMake(xPos, categoryImg.frame.origin.y + kcategoryImgHeight + 6, 110, 35)];
            [lblCategoryName setTextColor:kCategoryNameFontColor];
            [lblCategoryName setTextAlignment:NSTextAlignmentLeft];
            [lblCategoryName setFont:[UIFont fontWithName:kRobotoRegular size:12]];
            [lblCategoryName setNumberOfLines:2];
            [serviceListScrl addSubview:lblCategoryName];
            
            [lblCategoryName setText:[[categoryAry objectAtIndex:i] objectForKey:kCategoryName]];
            
            btnCategory = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnCategory setFrame:CGRectMake(xPos, 0, kcategoryImgWidth, kcategoryImgHeight + 35)];
            [btnCategory setTag:[[[categoryAry objectAtIndex:i] objectForKey:@"id"] intValue]];
            [btnCategory setBackgroundColor:[UIColor clearColor]];
            [btnCategory addTarget:self action:@selector(categoryTapped:) forControlEvents:UIControlEventTouchUpInside];
            [serviceListScrl addSubview:btnCategory];
            
            xPos += kcategoryImgWidth + 10;
        }
        
        [serviceListScrl setBounces:NO];
        serviceListScrl.contentSize = CGSizeMake((kcategoryImgWidth * [categoryAry count]) + ([categoryAry count] * 11), 150);
        [serviceListScrl setPagingEnabled:YES];
    }
}

#pragma mark - SEE ALL TAP ACTION

- (IBAction)seeAllCategories:(UIButton *)sender
{
    NSLog(@"The btn Tag is %ld",(long)[sender tag]);
    
    NSDictionary *wholeCategory = [[GlobalResourcesViewController sharedManager] dictCategories];
    NSArray *categoriesAry      = [wholeCategory objectForKey:@"services"];
    
    for(int i = 0; i < [categoriesAry count]; i++)
    {
        NSDictionary *dictCategory = [categoriesAry objectAtIndex:i];
        
        if ([[dictCategory objectForKey:@"id"] intValue] == [sender tag])
        {
            NSString *selectedServiceId = [dictCategory objectForKey:@"id"];
            
            [[GlobalResourcesViewController sharedManager] setSelectedService:dictCategory];
            [[GlobalResourcesViewController sharedManager] setSelectedServiceId:selectedServiceId];
            
            if ([self.delegate respondsToSelector:@selector(selectedServiceDelegate)])
            {
                [self.delegate selectedServiceDelegate];
            }
            break;
        }
    }
}

#pragma mark - CATEGORY TAP ACTION

- (IBAction)categoryTapped:(UIButton *)sender
{
    NSLog(@"The category Tag is %ld",(long)[sender tag]);
    
    NSArray *categoriesAry      = [currentServicesGroup objectForKey:@"category"];
    NSString *selectedServiceId = [currentServicesGroup objectForKey:@"id"];
    
    for(int i = 0; i < [categoriesAry count]; i++)
    {
        NSDictionary *dictCategory = [categoriesAry objectAtIndex:i];
        
        if ([[dictCategory objectForKey:@"id"] intValue] == [sender tag])
        {
            NSString *selectedCategoryId = [dictCategory objectForKey:@"id"];
            
            [[GlobalResourcesViewController sharedManager] setSelectedCategory:dictCategory];
            [[GlobalResourcesViewController sharedManager] setSelectedServiceId:selectedServiceId];
            [[GlobalResourcesViewController sharedManager] setSelectedCategoryId:selectedCategoryId];
            
            if ([self.delegate respondsToSelector:@selector(seletedCategoryDelegate)])
            {
                [self.delegate seletedCategoryDelegate];
            }
            break;
        }
    }
}

@end
