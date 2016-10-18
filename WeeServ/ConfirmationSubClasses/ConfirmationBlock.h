//
//  ConfirmationBlock.h
//  WeeServ
//
//  Created by saran c on 30/09/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmationBlock : UIView
{
    int viewWidth;
    
    UIImageView *confirmedImgView, *assignedImgView, *onTheWayImgView, *inProgressImgView;
    UIImageView *confirmedCircle, *assignedCircle, *onTheWayCircle, *inProgressCircle;
    
    UIButton *confirmedBtn, *assignedBtn, *onTheWayBtn, *inProgressBtn;
    
    
}
@end
