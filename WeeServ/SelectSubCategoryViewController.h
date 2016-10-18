//
//  SelectSubCategoryViewController.h
//  WeeServ
//
//  Created by saran c on 13/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectSubCategoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *dictSubCategory;
    NSArray *arySubCategories;
    int viewWidth, viewHeight;
    
    UITableView *subCategoryTable;
}
@end
