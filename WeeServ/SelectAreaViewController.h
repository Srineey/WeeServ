//
//  SelectAreaViewController.h
//  WeeServ
//
//  Created by saran c on 26/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectAreaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating> 
{
    int viewWidth, viewHeight;
    
    NSDictionary *dictCategory;
    NSArray *aryAreaList;
    
    NSMutableArray *aryFilteredAreaList, *aryDisplayAreaList;
    
    UITableView *tblView;
}
@property (nonatomic, strong) UISearchController *searchController;
@end
