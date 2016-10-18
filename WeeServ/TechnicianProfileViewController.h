//
//  TechnicianProfileViewController.h
//  WeeServ
//
//  Created by saran c on 28/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalResourcesViewController.h"

#define kHeadingTextColor  [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]

@interface TechnicianProfileViewController : UIViewController
{
    int viewWidth, viewHeight;
    
    UIScrollView *mainScrlView;
    UIImageView *coverImg, *profileImg, *briefCaseImg;
    UILabel *lblTechnicianName, *lblTechnicianExp;
    UIView *aboutView;
    NSArray *aryComents;
    UIButton *btnBook;
    
    int yPos;
    bool showMoreComments;
}

@end
