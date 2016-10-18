//
//  ConfirmationBlock.m
//  WeeServ
//
//  Created by saran c on 30/09/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "ConfirmationBlock.h"
#import "GlobalResourcesViewController.h"

@implementation ConfirmationBlock

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self    =   [super initWithFrame:frame];
    
    viewWidth = self.frame.size.width;
    
    [self setUI];
    
    return self;
}

- (void)setUI
{
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lblBookingStatus = [[UILabel alloc] init];
    [lblBookingStatus setFrame:CGRectMake(0, 10, viewWidth, 20)];
    [lblBookingStatus setTextColor:kAppBgColor];
    [lblBookingStatus setTextAlignment:NSTextAlignmentCenter];
    [lblBookingStatus setText:@"Booking Confirmed"];
    [lblBookingStatus setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [self addSubview:lblBookingStatus];
    
    UILabel *lblText = [[UILabel alloc] init];
    [lblText setFrame:CGRectMake(0, lblBookingStatus.frame.origin.y + lblBookingStatus.frame.size.height + 10, viewWidth, 20)];
    [lblText setTextColor:[UIColor grayColor]];
    [lblText setTextAlignment:NSTextAlignmentCenter];
    [lblText setText:@"We will send you the service provider shortly"];
    [lblText setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [self addSubview:lblText];
    
    int CircleWidth = 50;
    int CircleHight = 50;
    
    
}


@end
