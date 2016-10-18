//
//  AddressListViewController.h
//  WeeServ
//
//  Created by saran c on 24/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListViewController : UIViewController
{
    int viewWidth, viewHeight;
    int addressYpos;
    
    UIScrollView *scrlView;
    UIButton *btnAddNewAddress;
    
    NSArray *addressListArr;
}
@end
