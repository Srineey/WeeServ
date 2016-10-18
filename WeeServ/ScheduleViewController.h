//
//  ScheduleViewController.h
//  WeeServ
//
//  Created by saran c on 28/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    int viewWidth, viewHeight;
    
    int selectedDateIndex, selectedTimeIndex;
    
    bool isTimeSelected;
    
    UILabel *lblSelectDate, *lblMonthName, *lblSelectTime, *lblSelectTimeLine;
    UIView  *tileView;
    UILabel *lblDay, *lblDate;
    UIButton *btnTile;
    UIScrollView *scrlView;
    
    NSMutableArray *dates;
    NSMutableDictionary *timesDict;
    NSArray *aryTimes;
    
    UITableView *timesTblView;
    UIButton *btnContinue;
    
    NSIndexPath *selectedIndex;
}
@end
