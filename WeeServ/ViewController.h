//
//  ViewController.h
//  WeeServ
//
//  Created by saran c on 03/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.

#define kMainScrlBgColor [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]

#import <UIKit/UIKit.h>
#import "HomeCarouselView.h"
#import "TrendingServicesView.h"
#import "ServicesListView.h"
#import "PopularCitiesView.h"
#import "SearchCityViewController.h"

@interface ViewController : UIViewController <seletedCategory>
{
    int viewWidth;
    int viewHeight;
    
    HomeCarouselView *homeCarouselView;
    TrendingServicesView *trendingServicesView;
    ServicesListView *servicesListView;
    SearchCityViewController *searchCity;
    
    UILabel *lblCityName;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrl;

- (void)serviceCalls;

@end

