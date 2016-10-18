//
//  PopularCitiesView.m
//  WeeServ
//
//  Created by saran c on 17/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "PopularCitiesView.h"
#import "UIImageView+WebCache.h"
#import "GlobalResourcesViewController.h"

@implementation PopularCitiesView


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
    citiesView = [[UIView alloc] init];
    [citiesView setFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [citiesView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:citiesView];
    
    UILabel *lblPopular = [[UILabel alloc] init];
    [lblPopular setFrame:CGRectMake(0, 0, viewWidth, 40)];
    [lblPopular setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.7]];
    [lblPopular setText:@"      POPULAR CITIES"];
    [lblPopular setTextAlignment:NSTextAlignmentLeft];
    [lblPopular setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblPopular setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:56.0/255.0 blue:242.0/255.0 alpha:0.9]];
    [citiesView addSubview:lblPopular];
    
    popularCitiesView = [[UIView alloc] init];
    [popularCitiesView setFrame:CGRectMake(0, 40, viewWidth, viewHeight - 40)];
    [popularCitiesView setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:56.0/255.0 blue:242.0/255.0 alpha:0.8]];
    [citiesView addSubview:popularCitiesView];
    
}

- (void)popularCitiesList:(NSArray *)ary
{
    popularCitiesAry = [NSArray arrayWithArray:ary];
    
    int xPos = 18;
    int yPos = 10;
    
    int imgWidth = (viewWidth - 100)/4;
    
    for (int i = 0; i<ary.count; i++)
    {
        
        NSDictionary *dictCities = [ary objectAtIndex:i];
        
        NSString *stringUrl = [dictCities objectForKey:@"icon"];
        
        UIImageView *cityImg = [[UIImageView alloc] init];
        [cityImg setFrame:CGRectMake(xPos, yPos, imgWidth, imgWidth)];
        [cityImg sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"]];
        [popularCitiesView addSubview:cityImg];

        UILabel *lblCityName = [[UILabel alloc] init];
        [lblCityName setFrame:CGRectMake(xPos, yPos + 75, imgWidth, 18)];
        [lblCityName setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.7]];
        [lblCityName setTextAlignment:NSTextAlignmentCenter];
        [lblCityName setFont:[UIFont fontWithName:kRobotoRegular size:15]];
        [lblCityName setText:[dictCities objectForKey:@"name"]];
        [popularCitiesView addSubview:lblCityName];
        
        UIButton *btnCity = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCity setTag:i];
        [btnCity setFrame:CGRectMake(xPos, yPos, imgWidth, imgWidth + 20)];
        [btnCity setBackgroundColor:[UIColor clearColor]];
        [btnCity addTarget:self action:@selector(selectedPopularCity:) forControlEvents:UIControlEventTouchUpInside];
        [popularCitiesView addSubview:btnCity];
        
        xPos += imgWidth + 20;
        
        if (i == 3)
        {
            xPos = 18;
            yPos = 125;
        }

    }
}

#pragma mark - SELECTED POPULAR CITY

- (void)selectedPopularCity:(UIButton *)sender
{
    NSDictionary *dictCity = [popularCitiesAry objectAtIndex:sender.tag];
    
    [[GlobalResourcesViewController sharedManager] setSelectedCityName:[dictCity objectForKey:@"name"]];
    [[GlobalResourcesViewController sharedManager] setSelectedCityId:[dictCity objectForKey:@"id"]];
    
    if ([self.delegate respondsToSelector:@selector(seletedPopularCityDelegate)])
    {
        [self.delegate seletedPopularCityDelegate];
    }
}

@end
