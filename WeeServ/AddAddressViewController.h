//
//  AddAddressViewController.h
//  WeeServ
//
//  Created by saran c on 24/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHeadingTextColor  [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]
#define kLineBgColor       [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]
#define kTextFieldColor    [UIColor blackColor]

@interface AddAddressViewController : UIViewController <UITextFieldDelegate>
{
    int viewWidth, viewHeight;
    
    UIScrollView *scrlView;
    UILabel *lblHouseNo, *lblStreet, *lblLocality, *lblCity, *lblLandMark, *lblPincode;
    UITextField *txtHouseNo, *txtStreet, *txtLocality, *txtCity, *txtLandMark, *txtPincode;
    UILabel *lblHouseNoLine, *lblStreetLine, *lblLocalityLine, *lblCityLine, *lblLandMarkLine, *lblPincodeLine;
}
@end
