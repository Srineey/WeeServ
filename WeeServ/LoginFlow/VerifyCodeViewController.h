//
//  VerifyCodeViewController.h
//  WeeServ
//
//  Created by saran c on 10/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyCodeViewController : UIViewController <UITextFieldDelegate>
{
    UILabel *lblTextTop1, *lblTextTop2, *lblTextBelow, *lblLineTop, *lblLineBottom, *lblText;
    UILabel *lblOne, *lblTwo, *lblThree, *lblFour;
    UITextField *txtCode;
    UIButton *btnResend;
    
    int viewWidth, viewHeight;
}
@end
