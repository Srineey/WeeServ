//
//  ConfirmationViewController.h
//  WeeServ
//
//  Created by saran c on 03/09/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmationViewController : UIViewController
{
    int viewWidth, viewHeight;
    
    UILabel *lblAmount, *lblBillAmnt, *lblDiscount, *lblTotalAmnt;
    UIScrollView *scrlView;
}
@end