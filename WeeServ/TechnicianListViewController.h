//
//  TechnicianListViewController.h
//  WeeServ
//
//  Created by saran c on 19/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#define kSelectedFontColor [UIColor colorWithRed:153.0/255.0 green:63.0/255.0 blue:233.0/255.0 alpha:1.0]
#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)

#import <UIKit/UIKit.h>

@interface TechnicianListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    int viewWidth, viewHeight;
    UIView *sortView, *priceSortView, *rateSortView, *distanceSortView;
    UILabel *lblPrice, *lblRate, *lblDistance;
    UIButton *btnPriceSort, *btnRateSort, *btnDistanceSort;
    UIImageView *imgArwPrice, *imgArwRate, *imgArwDistance;
    
    UITableView *techniciansTblView;
    
    NSString *recentTechnicianId;
    NSArray *technicianAry;
}
@end
