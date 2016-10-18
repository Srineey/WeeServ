//
//  ConfrmationTrackViewController.h
//  WeeServ
//
//  Created by saran c on 29/09/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummaryBlock.h"
#import "ConfirmationBlock.h"

@interface ConfrmationTrackViewController : UIViewController
{
    int viewWidth, viewHeight;
    
    SummaryBlock *summaryBlock;
    ConfirmationBlock *confirmationBlock;
}

@end
