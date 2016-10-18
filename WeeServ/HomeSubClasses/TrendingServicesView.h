//
//  TrendingServicesView.h
//  WeeServ
//
//  Created by saran c on 27/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#define kcategoryCircleWidth       66.0f
#define kcategoryCircleHeight      66.0f
#define kcategoryImgWidth          26.0f
#define kcategoryImgHeight         21.0f
#define kTrendingServicesBgColor  [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]
#define kServicesNameColor        [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0]

#import <UIKit/UIKit.h>

@interface TrendingServicesView : UIView
{
    int viewWidth, viewHeight;
    UIView *recentUpdatesView;
    UILabel *lblRecentUpdates,*lblCategoryName;
    UIScrollView *recentUpdatesScrl;
    UIImageView *categoryImgIcon;
    
}

- (void)categoryListView:(NSDictionary *)servicesDict;

@end
