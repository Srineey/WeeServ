//
//  ServicesListView.h
//  WeeServ
//
//  Created by saran c on 19/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#define kServiceName            @"name"
#define kCategoryName           @"name"
#define kcategoryImgWidth       120.0f
#define kcategoryImgHeight      100.0f
#define kServiceNameFontColor   [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]
#define kCategoryNameFontColor  [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0]
#define kSeeAllFontColor        [UIColor colorWithRed:150.0/255.0 green:56.0/255.0 blue:242.0/255.0 alpha:1.0]

#import <UIKit/UIKit.h>

@protocol seletedCategory <NSObject>

- (void)seletedCategoryDelegate;
- (void)selectedServiceDelegate;

@end

@interface ServicesListView : UIView
{
    int viewWidth, viewHeight;
    
    UIScrollView *serviceListScrl;
    UILabel *lblServiceName,*lblCategoryName,*lblSeeAll;
    UIImageView *categoryImg,*seeAllIndicatorImg;
    UIView *serviceTitleView;
    UIButton *btnSeeAll, *btnCategory;
    
    NSDictionary *currentServicesGroup;
}

//@property (nonatomic, strong) id <seletedCategoryDelegate> seletedCategoryDelegate;
@property (nonatomic, strong) id delegate;

- (void)categoryListView:(NSDictionary *)servicesDict;
@end
