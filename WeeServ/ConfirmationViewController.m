//
//  ConfirmationViewController.m
//  WeeServ
//
//  Created by saran c on 03/09/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "GlobalResourcesViewController.h"

@interface ConfirmationViewController ()

@end

@implementation ConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    [self setNavigationTitle];
    
    [self setupUI];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(0, viewHeight - 108, viewWidth, 44)];
    [confirmBtn setTitle:@"Confirm Booking" forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:kAppBgColor];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [navLabel1 setText:@"Confirmation"];
    [navLabel1 setTextColor:[UIColor whiteColor]];
    [navLabel1 setTextAlignment:NSTextAlignmentLeft];
    [navLabel1 setBackgroundColor:[UIColor clearColor]];
    [viewNav addSubview:navLabel1];
    
    self.navigationItem.titleView = viewNav;
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back-icon.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnBackClick)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 44 ,44)];
    UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:sidebarButton];
}

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SETUP UI

- (void)setupUI
{
    //AMOUNT VIEW
    
    UIView *amountView = [[UIView alloc] init];
    [amountView setFrame:CGRectMake(0, 0, viewWidth, 44)];
    [amountView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:amountView];
    
    UILabel *txtAmount = [[UILabel alloc] init];
    [txtAmount setFrame:CGRectMake(20, 0, 100, 44)];
    [txtAmount setText:@"Amount"];
    [txtAmount setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [txtAmount setTextColor:[UIColor blackColor]];
    [amountView addSubview:txtAmount];
    
    lblAmount = [[UILabel alloc] init];
    [lblAmount setFrame:CGRectMake(viewWidth - 40 - 80, 0, 100, 44)];
    [lblAmount setText:@"$ 2300"];
    [lblAmount setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [lblAmount setTextColor:kAppBgColor];
    [lblAmount setTextAlignment:NSTextAlignmentRight];
    [amountView addSubview:lblAmount];
    
    //SCROLL VIEW
    
    scrlView = [[UIScrollView alloc] init];
    [scrlView setFrame:CGRectMake(0, amountView.frame.origin.y + amountView.frame.size.height, viewWidth, viewHeight - 64 - 88)];
    [scrlView setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]];
    [scrlView setShowsVerticalScrollIndicator:NO];
    [scrlView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:scrlView];
    
    //BILLING VIEW
    
    UILabel *txtBilling = [[UILabel alloc] init];
    [txtBilling setFrame:CGRectMake(20, 10, 100, 20)];
    [txtBilling setText:@"Bill summary"];
    [txtBilling setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [txtBilling setTextColor:[UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1.0]];
    [scrlView addSubview:txtBilling];
    
    UIView *billingView = [[UIView alloc] init];
    [billingView setFrame:CGRectMake(20, 40, viewWidth - 40, 125)];
    [billingView setBackgroundColor:[UIColor whiteColor]];
    [billingView.layer setBorderWidth:1.5];
    [billingView.layer setBorderColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0].CGColor];
    [billingView.layer setCornerRadius:5.0];
    [scrlView addSubview:billingView];
    
    UILabel *txtBillAmnt = [[UILabel alloc] init];
    [txtBillAmnt setFrame:CGRectMake(20, 15, 100, 20)];
    [txtBillAmnt setText:@"Bill Amount"];
    [txtBillAmnt setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [txtBillAmnt setTextColor:[UIColor blackColor]];
    [billingView addSubview:txtBillAmnt];
    
    lblBillAmnt = [[UILabel alloc] init];
    [lblBillAmnt setFrame:CGRectMake(viewWidth - 160, 15, 100, 20)];
    [lblBillAmnt setText:@"$ 2450"];
    [lblBillAmnt setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [lblBillAmnt setTextColor:[UIColor blackColor]];
    [lblBillAmnt setTextAlignment:NSTextAlignmentRight];
    [billingView addSubview:lblBillAmnt];
    
    UILabel *txtDiscount = [[UILabel alloc] init];
    [txtDiscount setFrame:CGRectMake(20, 45, 100, 20)];
    [txtDiscount setText:@"Discount"];
    [txtDiscount setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [txtDiscount setTextColor:[UIColor blackColor]];
    [billingView addSubview:txtDiscount];
    
    lblDiscount = [[UILabel alloc] init];
    [lblDiscount setFrame:CGRectMake(viewWidth - 160, 45, 100, 20)];
    [lblDiscount setText:@"$ 150"];
    [lblDiscount setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [lblDiscount setTextColor:[UIColor blackColor]];
    [lblDiscount setTextAlignment:NSTextAlignmentRight];
    [billingView addSubview:lblDiscount];
    
    UILabel *txtTotalAmnt = [[UILabel alloc] init];
    [txtTotalAmnt setFrame:CGRectMake(20, 90, 100, 20)];
    [txtTotalAmnt setText:@"Total Amount"];
    [txtTotalAmnt setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [txtTotalAmnt setTextColor:[UIColor blackColor]];
    [billingView addSubview:txtTotalAmnt];
    
    lblTotalAmnt = [[UILabel alloc] init];
    [lblTotalAmnt setFrame:CGRectMake(viewWidth - 160, 90, 100, 20)];
    [lblTotalAmnt setText:@"$ 2300"];
    [lblTotalAmnt setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [lblTotalAmnt setTextColor:[UIColor blackColor]];
    [lblTotalAmnt setTextAlignment:NSTextAlignmentRight];
    [billingView addSubview:lblTotalAmnt];
    
    //SERVICE VIEW
    
    UILabel *txtService = [[UILabel alloc] init];
    [txtService setFrame:CGRectMake(20, billingView.frame.origin.y + billingView.frame.size.height + 25, 100, 20)];
    [txtService setText:@"Service details"];
    [txtService setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [txtService setTextColor:[UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1.0]];
    [scrlView addSubview:txtService];
    
    UIView *serviceView = [[UIView alloc] init];
    [serviceView setFrame:CGRectMake(20, billingView.frame.origin.y + billingView.frame.size.height + 50, viewWidth - 40, 236)];
    [serviceView setBackgroundColor:[UIColor whiteColor]];
    [serviceView.layer setBorderWidth:1.5];
    [serviceView.layer setBorderColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0].CGColor];
    [serviceView.layer setCornerRadius:5.0];
    [scrlView addSubview:serviceView];
    
    //SCHEDULE
    
    NSString *strSelectedDate = [[GlobalResourcesViewController sharedManager] selectedDate];
    strSelectedDate = [self getDate:strSelectedDate];
    
    NSString *strSelectedTime = [[GlobalResourcesViewController sharedManager] selectedTime];
    
    UIView *scheduleView = [[UIView alloc] init];
    [scheduleView setFrame:CGRectMake(0, 0, serviceView.frame.size.width, 86)];
    [scheduleView setBackgroundColor:[UIColor clearColor]];
    [serviceView addSubview:scheduleView];
    
    UIImageView *seeAllIndicatorImg = [[UIImageView alloc] init];
    [seeAllIndicatorImg setFrame:CGRectMake(scheduleView.frame.size.width - 40, 28, 30, 30)];
    [seeAllIndicatorImg setImage:[UIImage imageNamed:@"right_arrow_grey"]];
    [scheduleView addSubview:seeAllIndicatorImg];
    
    UILabel *txtSchedule = [[UILabel alloc] init];
    [txtSchedule setFrame:CGRectMake(20, 10, 100, 20)];
    [txtSchedule setText:@"Scheduled on"];
    [txtSchedule setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [txtSchedule setTextColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]];
    [scheduleView addSubview:txtSchedule];
    
    UILabel *lblScheduleDate = [[UILabel alloc] init];
    [lblScheduleDate setFrame:CGRectMake(20, 35, 250, 20)];
    [lblScheduleDate setText:strSelectedDate];
    [lblScheduleDate setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblScheduleDate setTextColor:[UIColor blackColor]];
    [scheduleView addSubview:lblScheduleDate];
    
    UILabel *lblScheduleTime = [[UILabel alloc] init];
    [lblScheduleTime setFrame:CGRectMake(20, 55, 250, 20)];
    [lblScheduleTime setText:strSelectedTime];
    [lblScheduleTime setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblScheduleTime setTextColor:[UIColor blackColor]];
    [scheduleView addSubview:lblScheduleTime];
    
    UILabel *lblLine1 = [[UILabel alloc] init];
    [lblLine1 setFrame:CGRectMake(0, 85, serviceView.frame.size.width, 1)];
    [lblLine1 setBackgroundColor:[UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0]];
    [scheduleView addSubview:lblLine1];
    
    //ADDRESS
    
    NSDictionary *dictSelectedAddress = [[GlobalResourcesViewController sharedManager] selectedAddress];
    
    NSString *strLabel1 = [NSString stringWithFormat:@"%@, %@, %@, %@",[dictSelectedAddress objectForKey:@"house_number"], [dictSelectedAddress objectForKey:@"street_name"], [dictSelectedAddress objectForKey:@"landmark"], [dictSelectedAddress objectForKey:@"locality"]];
    
    NSString *strLabel2 = [NSString stringWithFormat:@"%@ %@",[[dictSelectedAddress objectForKey:@"city"] objectForKey:@"name"], [dictSelectedAddress objectForKey:@"pincode"]];
    
    UIView *addressView = [[UIView alloc] init];
    [addressView setFrame:CGRectMake(0, scheduleView.frame.origin.y + scheduleView.frame.size.height, serviceView.frame.size.width, 86)];
    [addressView setBackgroundColor:[UIColor clearColor]];
    [serviceView addSubview:addressView];
    
    UIImageView *seeAllIndicatorImg1 = [[UIImageView alloc] init];
    [seeAllIndicatorImg1 setFrame:CGRectMake(scheduleView.frame.size.width - 40, 28, 30, 30)];
    [seeAllIndicatorImg1 setImage:[UIImage imageNamed:@"right_arrow_grey"]];
    [addressView addSubview:seeAllIndicatorImg1];
    
    UILabel *txtAddress = [[UILabel alloc] init];
    [txtAddress setFrame:CGRectMake(20, 10, 100, 20)];
    [txtAddress setText:@"Address"];
    [txtAddress setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [txtAddress setTextColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]];
    [addressView addSubview:txtAddress];
    
    UILabel *lblAddressLine1 = [[UILabel alloc] init];
    [lblAddressLine1 setFrame:CGRectMake(20, 35, serviceView.frame.size.width - 60, 20)];
    [lblAddressLine1 setText:strLabel1];
    [lblAddressLine1 setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblAddressLine1 setTextColor:[UIColor blackColor]];
    [addressView addSubview:lblAddressLine1];
    
    UILabel *lblAddressLine2 = [[UILabel alloc] init];
    [lblAddressLine2 setFrame:CGRectMake(20, 55, 250, 20)];
    [lblAddressLine2 setText:strLabel2];
    [lblAddressLine2 setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblAddressLine2 setTextColor:[UIColor blackColor]];
    [addressView addSubview:lblAddressLine2];
    
    UILabel *lblLine2 = [[UILabel alloc] init];
    [lblLine2 setFrame:CGRectMake(0, 85, serviceView.frame.size.width, 1)];
    [lblLine2 setBackgroundColor:[UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0]];
    [addressView addSubview:lblLine2];
    
    //OTHER DETAILS
    
    NSString *enteredText = [[GlobalResourcesViewController sharedManager] enteredSuggestion];
    
    if ([enteredText length] == 0)
    {
        enteredText = @"No other details";
    }
    
    UIView *otherView = [[UIView alloc] init];
    [otherView setFrame:CGRectMake(0, addressView.frame.origin.y + addressView.frame.size.height, serviceView.frame.size.width, 85)];
    [otherView setBackgroundColor:[UIColor clearColor]];
    [serviceView addSubview:otherView];
    
    UILabel *txtOther = [[UILabel alloc] init];
    [txtOther setFrame:CGRectMake(20, 10, 100, 20)];
    [txtOther setText:@"Other"];
    [txtOther setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [txtOther setTextColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0]];
    [otherView addSubview:txtOther];
    
    UILabel *lblOther = [[UILabel alloc] init];
    [lblOther setFrame:CGRectMake(20, 35, serviceView.frame.size.width - 60, 20)];
    [lblOther setText:enteredText];
    [lblOther setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblOther setTextColor:[UIColor blackColor]];
    [lblOther setLineBreakMode:NSLineBreakByWordWrapping];
    [lblOther setNumberOfLines:2];
    [otherView addSubview:lblOther];
    
    CGFloat height = [self getLabelHeight:lblOther];
    
    [lblOther setFrame:CGRectMake(20, 35, serviceView.frame.size.width - 60, height+10)];
    [otherView setFrame:CGRectMake(0, addressView.frame.origin.y + addressView.frame.size.height, serviceView.frame.size.width, lblOther.frame.origin.y + lblOther.frame.size.height)];
    
    UIImageView *seeAllIndicatorImg2 = [[UIImageView alloc] init];
    [seeAllIndicatorImg2 setFrame:CGRectMake(scheduleView.frame.size.width - 40, (otherView.frame.size.height - 30)/2, 30, 30)];
    [seeAllIndicatorImg2 setImage:[UIImage imageNamed:@"right_arrow_grey"]];
    [otherView addSubview:seeAllIndicatorImg2];
    
    [serviceView setFrame:CGRectMake(20, billingView.frame.origin.y + billingView.frame.size.height + 50, viewWidth - 40, otherView.frame.origin.y + otherView.frame.size.height + 10)];
    
    [scrlView setContentSize:CGSizeMake(viewWidth, serviceView.frame.origin.y + serviceView.frame.size.height + 30)];
    
}

#pragma mark - DYNAMIC LABEL HEIGHT

- (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

#pragma mark - GET JOB DATE

- (NSString *)getDate:(NSString *)strDate
{
    NSString *jobDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/d/yyyy"];
    NSDate *selectedDate = [formatter dateFromString:strDate];
    [formatter setDateFormat:@"MMM dd, yyyy. EEEE"];
    jobDate = [formatter stringFromDate:selectedDate];
    
    return jobDate;
}

- (NSString *)getJobDate:(NSString *)strDate
{
    NSString *jobDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/d/yyyy"];
    NSDate *selectedDate = [formatter dateFromString:strDate];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    jobDate = [formatter stringFromDate:selectedDate];
    
    return jobDate;
}


#pragma mark - GET JOB TIME

- (NSString *)getJobTime:(NSString *)strTime
{
    NSString *jobTime;
    
    jobTime = [strTime componentsSeparatedByString:@"-"].firstObject;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSDate *date = [formatter dateFromString:jobTime];
    [formatter setDateFormat:@"HH:mm"];
    NSString *strDate = [formatter stringFromDate:date];
    
    return strDate;
}


#pragma mark - CONFIRM BOOKING

- (void)confirmBtnClicked
{
//    "service_id": 1,
//    "category_id": 2,
//    "brand_id": 1,
//    "subcategory_id": 1,
//    "technician_id": 3,
//    "address_id": 4,
//    "job_start_day": "2016-09-08T10:32:30.9752743-07:00",
//    "job_start_time": "sample string 6",
//    "latitude": "sample string 7",
//    "longtitude": "sample string 8",
//    "suggestion": "sample string 9",
    
    NSString *service_id = [[GlobalResourcesViewController sharedManager] selectedServiceId];
    NSString *category_id = [[GlobalResourcesViewController sharedManager] selectedCategoryId];
    NSString *brand_id = [[GlobalResourcesViewController sharedManager] selectedBrandId];
    NSString *subcategory_id = [[GlobalResourcesViewController sharedManager] selectedSubCategoryId];
    NSString *technician_id = [[GlobalResourcesViewController sharedManager] selectedTechnicianId];
    NSString *address_id = [[GlobalResourcesViewController sharedManager] selectedAddressId];
    NSString *job_start_day = [self getJobDate:[[GlobalResourcesViewController sharedManager] selectedDate]];
    NSString *job_start_time = [self getJobTime:[[GlobalResourcesViewController sharedManager] selectedTime]];
    NSString *latitude = @"12.80976";
    NSString *longtitude = @"80.67232";
    NSString *suggestion = @"";
    
    
    NSString *stringURL = [NSString stringWithFormat:@"%@/trade/request",kServerUrl];
    
    NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
    [dictRequest setObject:service_id       forKey:@"service_id"];
    [dictRequest setObject:category_id      forKey:@"category_id"];
    [dictRequest setObject:brand_id         forKey:@"brand_id"];
    [dictRequest setObject:subcategory_id   forKey:@"subcategory_id"];
    [dictRequest setObject:technician_id    forKey:@"technician_id"];
    [dictRequest setObject:address_id       forKey:@"address_id"];
    [dictRequest setObject:job_start_day    forKey:@"job_start_day"];
    [dictRequest setObject:job_start_time   forKey:@"job_start_time"];
    [dictRequest setObject:latitude         forKey:@"latitude"];
    [dictRequest setObject:longtitude       forKey:@"longtitude"];
    [dictRequest setObject:suggestion       forKey:@"suggestion"];
    
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dictRequest
                                                       options:0
                                                         error:nil];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@ ",[userDefaults objectForKey:kaccess_token]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:accessToken forHTTPHeaderField:@"Authorization"];
    request.HTTPMethod = @"POST";
//    request.HTTPBody = JSONData;
    
    // Create a task.
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data,
                                                                                     NSURLResponse *response,
                                                                                     NSError *error)
                                  {
                                      if (!error)
                                      {
                                          
                                          NSDictionary *responseDict   =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          NSLog(@"Technician Availability List %@", responseDict);
                                          
                                          /*[GMDCircleLoader hideFromView:self.view animated:YES];
                                          
                                          if ([[responseDict allKeys] count] > 0)
                                          {
                                              if ([[responseDict allKeys] containsObject:@"technician_availability"])
                                              {
                                                  NSArray *totalAvailbilityAry = [responseDict objectForKey:@"technician_availability"];
                                                  
                                                  if ([totalAvailbilityAry count] > 0)
                                                  {
                                                      for (int i=0; i<totalAvailbilityAry.count; i++)
                                                      {
                                                          NSArray *availAry = [[totalAvailbilityAry objectAtIndex:i] objectForKey:@"availability"];
                                                          
                                                          NSMutableArray *aryTimesNew = [NSMutableArray array];
                                                          
                                                          if ([availAry count] > 0)
                                                          {
                                                              for (int j=0; j<availAry.count; j++)
                                                              {
                                                                  NSDictionary *dict = [availAry objectAtIndex:j];
                                                                  
                                                                  if ([[dict objectForKey:@"available"] boolValue])
                                                                  {
                                                                      NSString *startTime = [self convertTimeFormat:[dict objectForKey:@"start"]];
                                                                      NSString *endTime = [self convertTimeFormat:[dict objectForKey:@"end"]];
                                                                      
                                                                      NSString *time = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
                                                                      
                                                                      [aryTimesNew addObject:time];
                                                                  }
                                                                  
                                                              }
                                                          }
                                                          
                                                          [timesDict setObject:aryTimesNew forKey:[[totalAvailbilityAry objectAtIndex:i] objectForKey:@"day"]];
                                                          
                                                      }
                                                      
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          [self defaultDateSelected];
                                                      });
                                                  }
                                              }
                                          }
                                          
                                          NSLog(@"Times Dict %@",timesDict);*/
                                          
                                      }
                                      else
                                      {
//                                          [GMDCircleLoader hideFromView:self.view animated:YES];
                                          NSLog(@"Error: %@", error.localizedDescription);
                                      }
                                  }];
    
    // Start the task.
    [task resume];
    

    [[GlobalResourcesViewController sharedManager] setIsFromMenu:NO];
    [self performSegueWithIdentifier:@"BookingHistory" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
