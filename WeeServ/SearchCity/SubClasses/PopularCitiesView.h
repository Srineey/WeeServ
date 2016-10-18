//
//  PopularCitiesView.h
//  WeeServ
//
//  Created by saran c on 17/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol seletedPopularCity <NSObject>

- (void)seletedPopularCityDelegate;

@end

@interface PopularCitiesView : UIView
{
    UIView *citiesView, *popularCitiesView;
    UIScrollView *scrlView;
    NSArray *popularCitiesAry;
    
    int viewWidth, viewHeight;
}
@property (nonatomic, strong) id delegate;

- (void)popularCitiesList:(NSArray *)ary;

@end
