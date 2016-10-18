//
//  LoginViewController.h
//  WeeServ
//
//  Created by saran c on 18/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UIScrollView *scrlView;
    UILabel *lbl1, *lbl2, *lbl3, *lbl4;
    UILabel *lblCountry, *lblUserName;
    UILabel *lblLine1, *lblLine2, *lblLine3;
    UITextField *txtCountry, *txtCountryCode, *txtPhoneNumber;
    UIButton *btnGetStarted;
    
    int viewWidth, viewHeight;
}
@end
