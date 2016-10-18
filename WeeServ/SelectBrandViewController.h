//
//  SelectBrandViewController.h
//  WeeServ
//
//  Created by saran c on 13/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBrandViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *dictCategoryBrand;
    NSArray *aryBrandCategories;
    int viewWidth, viewHeight;
    
    UITableView *categoryBrandTable;
}
@end
