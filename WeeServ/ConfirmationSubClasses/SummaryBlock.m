//
//  SummaryBlock.m
//  WeeServ
//
//  Created by saran c on 02/10/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "SummaryBlock.h"
#import "GlobalResourcesViewController.h"

@implementation SummaryBlock

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
    UIView *mainView = [[UIView alloc] init];
    [mainView setFrame:CGRectMake(0, 0, viewWidth, 500)];
    [mainView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:mainView];
    
    UIView *summaryView = [[UIView alloc] init];
    [summaryView setFrame:CGRectMake(20, 20, viewWidth - 40, 400)];
    [summaryView.layer setBorderWidth:2.0];
    [summaryView.layer setBorderColor:[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor];
    [summaryView.layer setCornerRadius:3.0];
    [mainView addSubview:summaryView];
    
    //SERVICE TYPE
    
    UILabel *lblServiceType = [[UILabel alloc] init];
    [lblServiceType setFrame:CGRectMake(10, 10, 100, 20)];
    [lblServiceType setFont:[UIFont fontWithName:kRobotoRegular size:14.0]];
    [lblServiceType setText:@"Service type"];
    [lblServiceType setTextColor:[UIColor grayColor]];
    [summaryView addSubview:lblServiceType];
    
    UIImageView *imgServiceType = [[UIImageView alloc] init];
    [imgServiceType setFrame:CGRectMake(10, lblServiceType.frame.origin.y + lblServiceType.frame.size.height + 5, 15, 15)];
    [imgServiceType setImage:[UIImage imageNamed:@""]];
    [summaryView addSubview:imgServiceType];
    
    UILabel *lblServiceName = [[UILabel alloc] init];
    [lblServiceName setFrame:CGRectMake(45, lblServiceType.frame.origin.y + lblServiceType.frame.size.height + 5, 200, 20)];
    [lblServiceName setFont:[UIFont fontWithName:kRobotoRegular size:14.0]];
    [lblServiceName setText:@"Home Painting"];
    [lblServiceName setTextColor:[UIColor blackColor]];
    [summaryView addSubview:lblServiceName];
    
    UILabel *lblSubServiceName = [[UILabel alloc] init];
    [lblSubServiceName setFrame:CGRectMake(45, lblServiceName.frame.origin.y + lblServiceName.frame.size.height + 5, 200, 20)];
    [lblSubServiceName setFont:[UIFont fontWithName:kRobotoRegular size:12.0]];
    [lblSubServiceName setText:@"Individual Service"];
    [lblSubServiceName setTextColor:[UIColor blackColor]];
    [summaryView addSubview:lblSubServiceName];
    
    UILabel *line1 = [[UILabel alloc] init];
    [line1 setFrame:CGRectMake(0, lblSubServiceName.frame.origin.y + lblSubServiceName.frame.size.height + 5, summaryView.frame.size.width, 1)];
    [line1 setBackgroundColor:[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0]];
    [summaryView addSubview:line1];
    
    //SCHEDULE
    
//    NSString *strSelectedDate = [[GlobalResourcesViewController sharedManager] selectedDate];
//    strSelectedDate = [self getDate:strSelectedDate];
    
//    NSString *strSelectedTime = [[GlobalResourcesViewController sharedManager] selectedTime];
    
    UIView *scheduleView = [[UIView alloc] init];
    [scheduleView setFrame:CGRectMake(0, line1.frame.origin.y + line1.frame.size.height + 2, summaryView.frame.size.width, 75)];
    [scheduleView setBackgroundColor:[UIColor clearColor]];
    [summaryView addSubview:scheduleView];
    
    UIImageView *seeAllIndicatorImg = [[UIImageView alloc] init];
    [seeAllIndicatorImg setFrame:CGRectMake(scheduleView.frame.size.width - 40, 28, 30, 30)];
    [seeAllIndicatorImg setImage:[UIImage imageNamed:@"right_arrow_grey"]];
    [scheduleView addSubview:seeAllIndicatorImg];
    
    UILabel *txtSchedule = [[UILabel alloc] init];
    [txtSchedule setFrame:CGRectMake(10, 10, 100, 20)];
    [txtSchedule setText:@"Scheduled on"];
    [txtSchedule setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [txtSchedule setTextColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]];
    [scheduleView addSubview:txtSchedule];
    
    UIImageView *imgScheduleType = [[UIImageView alloc] init];
    [imgScheduleType setFrame:CGRectMake(10, txtSchedule.frame.origin.y + txtSchedule.frame.size.height + 5, 15, 15)];
    [imgScheduleType setImage:[UIImage imageNamed:@""]];
    [scheduleView addSubview:imgScheduleType];
    
    UILabel *lblScheduleDate = [[UILabel alloc] init];
    [lblScheduleDate setFrame:CGRectMake(45, 35, 250, 20)];
    [lblScheduleDate setText:@"November 15, 2016. Widnesday"];
    [lblScheduleDate setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblScheduleDate setTextColor:[UIColor blackColor]];
    [scheduleView addSubview:lblScheduleDate];
    
    UILabel *lblScheduleTime = [[UILabel alloc] init];
    [lblScheduleTime setFrame:CGRectMake(45, 55, 250, 20)];
    [lblScheduleTime setText:@"10:00 AM - 12:00 PM"];
    [lblScheduleTime setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblScheduleTime setTextColor:[UIColor blackColor]];
    [scheduleView addSubview:lblScheduleTime];
    
    //ADDRESS
    
//    NSDictionary *dictSelectedAddress = [[GlobalResourcesViewController sharedManager] selectedAddress];
    
//    NSString *strLabel1 = [NSString stringWithFormat:@"%@, %@, %@, %@",[dictSelectedAddress objectForKey:@"house_number"], [dictSelectedAddress objectForKey:@"street_name"], [dictSelectedAddress objectForKey:@"landmark"], [dictSelectedAddress objectForKey:@"locality"]];
//    
//    NSString *strLabel2 = [NSString stringWithFormat:@"%@ %@",[[dictSelectedAddress objectForKey:@"city"] objectForKey:@"name"], [dictSelectedAddress objectForKey:@"pincode"]];
    
    UIView *addressView = [[UIView alloc] init];
    [addressView setFrame:CGRectMake(0, scheduleView.frame.origin.y + scheduleView.frame.size.height, summaryView.frame.size.width, 75)];
    [addressView setBackgroundColor:[UIColor clearColor]];
    [summaryView addSubview:addressView];
    
    UIImageView *seeAllIndicatorImg1 = [[UIImageView alloc] init];
    [seeAllIndicatorImg1 setFrame:CGRectMake(scheduleView.frame.size.width - 40, 28, 30, 30)];
    [seeAllIndicatorImg1 setImage:[UIImage imageNamed:@"right_arrow_grey"]];
    [addressView addSubview:seeAllIndicatorImg1];
    
    UILabel *txtAddress = [[UILabel alloc] init];
    [txtAddress setFrame:CGRectMake(10, 10, 100, 20)];
    [txtAddress setText:@"Address"];
    [txtAddress setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [txtAddress setTextColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]];
    [addressView addSubview:txtAddress];
    
    UIImageView *imgAddressType = [[UIImageView alloc] init];
    [imgAddressType setFrame:CGRectMake(10, txtAddress.frame.origin.y + txtAddress.frame.size.height + 5, 15, 15)];
    [imgAddressType setImage:[UIImage imageNamed:@""]];
    [addressView addSubview:imgAddressType];
    
    UILabel *lblAddressLine1 = [[UILabel alloc] init];
    [lblAddressLine1 setFrame:CGRectMake(45, 35, summaryView.frame.size.width - 60, 45)];
    [lblAddressLine1 setText:@"21, Ramagiri Nagar, Near TCS, Adyar, Chennai 600123"];
    [lblAddressLine1 setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblAddressLine1 setTextColor:[UIColor blackColor]];
    [lblAddressLine1 setLineBreakMode:NSLineBreakByWordWrapping];
    [lblAddressLine1 setNumberOfLines:2];
    [lblAddressLine1 setTextAlignment:NSTextAlignmentLeft];
    [addressView addSubview:lblAddressLine1];
    
    //OTHER DETAILS
    
    NSString *enteredText = [[GlobalResourcesViewController sharedManager] enteredSuggestion];
    
    if ([enteredText length] == 0)
    {
        enteredText = @"No other details";
    }
    
    UIView *otherView = [[UIView alloc] init];
    [otherView setFrame:CGRectMake(0, addressView.frame.origin.y + addressView.frame.size.height, summaryView.frame.size.width, 60)];
    [otherView setBackgroundColor:[UIColor clearColor]];
    [summaryView addSubview:otherView];
    
    UILabel *txtOther = [[UILabel alloc] init];
    [txtOther setFrame:CGRectMake(10, 10, 100, 20)];
    [txtOther setText:@"Other"];
    [txtOther setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [txtOther setTextColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]];
    [otherView addSubview:txtOther];
    
    UIImageView *imgOtherType = [[UIImageView alloc] init];
    [imgOtherType setFrame:CGRectMake(10, txtOther.frame.origin.y + txtOther.frame.size.height + 5, 15, 15)];
    [imgOtherType setImage:[UIImage imageNamed:@""]];
    [otherView addSubview:imgOtherType];
    
    UILabel *lblOther = [[UILabel alloc] init];
    [lblOther setFrame:CGRectMake(45, 35, summaryView.frame.size.width - 60, 20)];
    [lblOther setText:enteredText];
    [lblOther setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblOther setTextColor:[UIColor blackColor]];
    [lblOther setLineBreakMode:NSLineBreakByWordWrapping];
    [lblOther setNumberOfLines:2];
    [otherView addSubview:lblOther];
    
//    CGFloat height = [self getLabelHeight:lblOther];
    
//    [lblOther setFrame:CGRectMake(20, 35, serviceView.frame.size.width - 60, height+10)];
//    [otherView setFrame:CGRectMake(0, addressView.frame.origin.y + addressView.frame.size.height, serviceView.frame.size.width, lblOther.frame.origin.y + lblOther.frame.size.height)];
    
    UIImageView *seeAllIndicatorImg2 = [[UIImageView alloc] init];
    [seeAllIndicatorImg2 setFrame:CGRectMake(scheduleView.frame.size.width - 40, (otherView.frame.size.height - 15)/2, 30, 30)];
    [seeAllIndicatorImg2 setImage:[UIImage imageNamed:@"right_arrow_grey"]];
    [otherView addSubview:seeAllIndicatorImg2];
    
//    [serviceView setFrame:CGRectMake(20, billingView.frame.origin.y + billingView.frame.size.height + 50, viewWidth - 40, otherView.frame.origin.y + otherView.frame.size.height + 10)];
//    
//    [scrlView setContentSize:CGSizeMake(viewWidth, serviceView.frame.origin.y + serviceView.frame.size.height + 30)];

    //SPARE PARTS DETAILS
    UIView *spareView = [[UIView alloc] init];
    [spareView setFrame:CGRectMake(0, otherView.frame.origin.y + otherView.frame.size.height, summaryView.frame.size.width, 60)];
    [spareView setBackgroundColor:[UIColor clearColor]];
    [summaryView addSubview:spareView];
    
    UILabel *txtSpare = [[UILabel alloc] init];
    [txtSpare setFrame:CGRectMake(10, 10, 100, 20)];
    [txtSpare setText:@"Spare Parts"];
    [txtSpare setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [txtSpare setTextColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]];
    [spareView addSubview:txtSpare];
    
    UIImageView *imgSpareType = [[UIImageView alloc] init];
    [imgSpareType setFrame:CGRectMake(10, txtSpare.frame.origin.y + txtSpare.frame.size.height + 5, 15, 15)];
    [imgSpareType setImage:[UIImage imageNamed:@""]];
    [spareView addSubview:imgSpareType];
    
    UILabel *lblSpares = [[UILabel alloc] init];
    [lblSpares setFrame:CGRectMake(45, 35, summaryView.frame.size.width - 60, 20)];
    [lblSpares setText:enteredText];
    [lblSpares setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblSpares setTextColor:[UIColor blackColor]];
    [lblSpares setLineBreakMode:NSLineBreakByWordWrapping];
    [lblSpares setNumberOfLines:2];
    [spareView addSubview:lblSpares];
    
    UIImageView *seeAllIndicatorImg3 = [[UIImageView alloc] init];
    [seeAllIndicatorImg3 setFrame:CGRectMake(scheduleView.frame.size.width - 40, (spareView.frame.size.height - 15)/2, 30, 30)];
    [seeAllIndicatorImg3 setImage:[UIImage imageNamed:@"right_arrow_grey"]];
    [spareView addSubview:seeAllIndicatorImg3];
    
}

@end
