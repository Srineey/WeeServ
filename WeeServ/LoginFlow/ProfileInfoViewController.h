//
//  ProfileInfoViewController.h
//  WeeServ
//
//  Created by saran c on 08/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileInfoViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIScrollView *scrlView;
    UILabel *lblText, *lblLine, *lblText2, *lblLine2;
    UIImageView *imgProfile;
    UITextField *txtName, *txtEmail;
    UIButton *btnUpdate, *uploadPhoto;
    
    int viewWidth, viewHeight;
    NSUserDefaults *userDefaults;
    
    UIImagePickerController *ipc;
    NSData *dataImage;
}
@end
