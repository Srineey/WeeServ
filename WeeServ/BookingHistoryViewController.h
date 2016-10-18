//
//  BookingHistoryViewController.h
//  WeeServ
//
//  Created by saran c on 08/09/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingHistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    int viewWidth, viewHeight;
    NSUserDefaults *userDefaults;
    UITableView *tblView;
    NSMutableArray *arrBookingHistory;
}
@end
