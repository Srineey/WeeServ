//
//  SearchCityViewController.h
//  WeeServ
//
//  Created by saran c on 17/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopularCitiesView.h"

@interface SearchCityViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, seletedPopularCity>
{
    UIScrollView *scrlView;
    UITableView *tblViewCities;
    
    NSArray *aryLocationsList;
    
    int viewWidth, viewHeight;
}
@property (nonatomic, strong) id delegate;

@end
