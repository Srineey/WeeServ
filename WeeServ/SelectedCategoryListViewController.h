//
//  SelectedCategoryListViewController.h
//  WeeServ
//
//  Created by saran c on 09/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedCategoryListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating> 
{
    NSDictionary *dictCategory;
    NSArray *aryCategories;
    
    NSMutableArray *aryFilteredCategories, *aryDisplayCategories;
    int viewWidth, viewHeight;
    
    UITableView *categoryListTable;
}

@property (nonatomic, strong) UISearchController *searchController;

@end
