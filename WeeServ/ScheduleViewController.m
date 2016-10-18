//
//  ScheduleViewController.m
//  WeeServ
//
//  Created by saran c on 28/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "ScheduleViewController.h"
#import "GlobalResourcesViewController.h"
#import "GMDCircleLoader.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    selectedDateIndex = 0;
    isTimeSelected = NO;
    
    timesDict= [NSMutableDictionary dictionary];

    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
    
    [self setNavigationTitle];
    
    [self setupUI];
    
    [self getScheduleList];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [navLabel1 setText:@"Schedule"];
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

#pragma mark - SET UP UI

- (void)setupUI
{
    lblSelectDate = [[UILabel alloc]init];
    [lblSelectDate setFrame:CGRectMake(30, 20, 100,20)];
    [lblSelectDate setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblSelectDate setBackgroundColor:[UIColor clearColor]];
    [lblSelectDate setTextColor:[UIColor blackColor]];
    [lblSelectDate setText:@"Select Date"];
    [self.view addSubview:lblSelectDate];
    
    UIView *datesView = [[UIView alloc] init];
    [datesView setFrame:CGRectMake(0, 55, viewWidth, 70)];
    [datesView setBackgroundColor:[UIColor clearColor]];
    [datesView.layer setBorderWidth:1.0];
    [datesView.layer setBorderColor:[UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0].CGColor];
    [self.view addSubview:datesView];
    
    scrlView = [[UIScrollView alloc] init];
    [scrlView setFrame:CGRectMake(1, 0, viewWidth, 70)];
    [scrlView setBackgroundColor:[UIColor clearColor]];
    [scrlView setShowsVerticalScrollIndicator:NO];
    [scrlView setShowsHorizontalScrollIndicator:NO];
    [scrlView setBounces:NO];
    [datesView addSubview:scrlView];
    
    dates = [NSMutableArray array];
    NSDate *curDate = [NSDate date];
    NSDate *endDate = [curDate dateByAddingTimeInterval:60*60*24*9];
    while([curDate timeIntervalSince1970] <= [endDate timeIntervalSince1970]) //you can also use the earlier-method
    {
        [dates addObject:curDate];
        curDate = [NSDate dateWithTimeInterval:86400 sinceDate:curDate];
    }
    
    NSLog(@"Dates %@",dates);
    
    int tileWidth = viewWidth/5;
    int xPos = 0;
    
    for (int i = 0; i < dates.count; i++)
    {
        NSDate *currentDate = [dates objectAtIndex:i];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEEE"];
        NSString *strDay = [[formatter stringFromDate:currentDate] substringToIndex:3];
        [formatter setDateFormat:@"dd"];
        NSString *strDate = [formatter stringFromDate:currentDate];
        
        tileView = [[UIView alloc] init];
        [tileView setFrame:CGRectMake(xPos, 0, tileWidth, 70)];
        [tileView setTag:i+100];
        [scrlView addSubview:tileView];
        
        lblDay = [[UILabel alloc] init];
        [lblDay setTag:i+200];
        [lblDay.layer setName:@"Day"];
        [lblDay setFrame:CGRectMake(0, 5, tileWidth, 30)];
        [lblDay setTextColor:[UIColor colorWithRed:207.0/255.0 green:207.0/255.0 blue:207.0/255.0 alpha:1.0]];
        [lblDay setText:[strDay uppercaseString]];
        [lblDay setTextAlignment:NSTextAlignmentCenter];
        [lblDay setFont:[UIFont fontWithName:kRobotoRegular size:16]];
        [tileView addSubview:lblDay];
        
        lblDate = [[UILabel alloc] init];
        [lblDate setTag:i+300];
        [lblDate setFrame:CGRectMake(0, 35, tileWidth, 30)];
        [lblDate setTextColor:[UIColor blackColor]];
        [lblDate setText:strDate];
        [lblDate setTextAlignment:NSTextAlignmentCenter];
        [lblDate setFont:[UIFont fontWithName:kRobotoRegular size:15]];
        [tileView addSubview:lblDate];
        
        btnTile = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnTile setTag:i];
        [btnTile setFrame:tileView.frame];
        [btnTile addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventTouchUpInside];
        [scrlView addSubview:btnTile];
        
        xPos += tileWidth;
    }
    
    [scrlView setContentSize:CGSizeMake(xPos, 70)];
    
    //SELECT TIME
    lblSelectTime = [[UILabel alloc]init];
    [lblSelectTime setFrame:CGRectMake(30, 140, 100,20)];
    [lblSelectTime setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblSelectTime setBackgroundColor:[UIColor clearColor]];
    [lblSelectTime setTextColor:[UIColor blackColor]];
    [lblSelectTime setText:@"Select time"];
    [lblSelectTime setHidden:YES];
    [self.view addSubview:lblSelectTime];
    
    lblSelectTimeLine = [[UILabel alloc] init];
    [lblSelectTimeLine setFrame:CGRectMake(0, lblSelectTime.frame.origin.y + lblSelectTime.frame.size.height + 10, viewWidth, 1)];
    [lblSelectTimeLine setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [lblSelectTimeLine setHidden:YES];
    [self.view addSubview:lblSelectTimeLine];
    
    timesTblView = [[UITableView alloc] init];
    [timesTblView setFrame:CGRectMake(0, lblSelectTime.frame.origin.y + lblSelectTime.frame.size.height + 20, viewWidth, viewHeight - lblSelectTime.frame.origin.y + lblSelectTime.frame.size.height + 20 - 40 - 64)];
    [timesTblView setDelegate:self];
    [timesTblView setDataSource:self];
    [timesTblView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:timesTblView];
    
    btnContinue = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnContinue setFrame:CGRectMake(0, viewHeight - 104, viewWidth, 40)];
    [btnContinue setTitle:@"Continue" forState:UIControlStateNormal];
    [btnContinue setBackgroundColor:kAppBgColor];
    [btnContinue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnContinue.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [btnContinue addTarget:self action:@selector(continueClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnContinue setHidden:YES];
    [self.view addSubview:btnContinue];
}

#pragma mark - GET SCHEDULE LIST

- (void)getScheduleList
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/Technician/Availbility",kServerUrl];
    
    NSString *technicianId = [GlobalResourcesViewController sharedManager].selectedTechnicianId;
//    NSString *categoryId = [GlobalResourcesViewController sharedManager].selectedServiceId;
    
    NSDate *todayDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    NSString *strDate = [formatter stringFromDate:todayDate];
    
    NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
    [dictRequest setObject:technicianId forKey:@"technician_id"];
    [dictRequest setObject:strDate      forKey:@"startdate"];
    [dictRequest setObject:@"10"        forKey:@"days"];
    [dictRequest setObject:@"20"        forKey:@"service_id"];
    
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dictRequest
                                                       options:0
                                                         error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    request.HTTPBody = JSONData;
    
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
                                          
                                          [GMDCircleLoader hideFromView:self.view animated:YES];
                                          
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
                                          
                                          NSLog(@"Times Dict %@",timesDict);
                                          
                                      }
                                      else
                                      {
                                          [GMDCircleLoader hideFromView:self.view animated:YES];
                                          NSLog(@"Error: %@", error.localizedDescription);
                                      }
                                  }];
    
    // Start the task.
    [task resume];
    

}

#pragma mark - CONVERT TIME INTO 12 HOURS

- (NSString *)convertTimeFormat:(NSString *)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSDate *date = [formatter dateFromString:time];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *strDate = [formatter stringFromDate:date];

    return strDate;
}

#pragma mark - DATE SELECTED

- (IBAction)dateSelected:(id)sender
{
    selectedDateIndex = (int)[sender tag];
    
    [self setMonthLabel:[dates objectAtIndex:[sender tag]]];
    
    for(UIView * subView in scrlView.subviews)
    {
        if([subView isKindOfClass:[UIView class]])
        {
            if ([subView tag] == [sender tag]+100)
            {
                for(UIView * newView in subView.subviews)
                {
                    if([newView isKindOfClass:[UILabel class]])
                    {
                        if ([newView tag] == [sender tag]+200)
                        {
                            UILabel *lblDayView = (UILabel *)newView;
                            [lblDayView setTextColor:[UIColor whiteColor]];
                        }
                        
                        if ([newView tag] == [sender tag]+300)
                        {
                            UILabel *lblDateView = (UILabel *)newView;
                            [lblDateView setTextColor:[UIColor whiteColor]];
                        }
                        
                        [subView setBackgroundColor:kAppBgColor];
                    }
                }
            }
            else
            {
                [subView setBackgroundColor:[UIColor clearColor]];
                
                for(UIView * newView in subView.subviews)
                {
                    if([newView isKindOfClass:[UILabel class]])
                    {
                        if ([newView.layer.name isEqualToString:@"Day"])
                        {
                            UILabel *lblDayView = (UILabel *)newView;
                            [lblDayView setTextColor:[UIColor colorWithRed:207.0/255.0 green:207.0/255.0 blue:207.0/255.0 alpha:1.0]];
                        }
                        else
                        {
                            UILabel *lblDateView = (UILabel *)newView;
                            [lblDateView setTextColor:[UIColor blackColor]];
                        }
                    }
                }
            }
        }
    }
    
    NSDate *currentDate = [dates objectAtIndex:[sender tag]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/d/yyyy"];
    NSString *selectedDate = [formatter stringFromDate:currentDate];
    
    [lblSelectTime setHidden:NO];
    [lblSelectTimeLine setHidden:NO];
    
    selectedIndex = nil;
    isTimeSelected = NO;
    
    aryTimes = [NSArray array];
    
    if ([[timesDict allKeys] containsObject:selectedDate])
    {
        aryTimes = [timesDict objectForKey:selectedDate];
        
        if ([aryTimes count] > 0)
        {
            [btnContinue setHidden:NO];
            [timesTblView reloadData];
        }
        else
        {
            [btnContinue setHidden:YES];
        }
    }
}

- (void)defaultDateSelected
{
    int indexTag = 0;
    
    selectedDateIndex = indexTag;
    
    [self setMonthLabel:[dates objectAtIndex:indexTag]];
    
    for(UIView * subView in scrlView.subviews)
    {
        if([subView isKindOfClass:[UIView class]])
        {
            if ([subView tag] == indexTag+100)
            {
                for(UIView * newView in subView.subviews)
                {
                    if([newView isKindOfClass:[UILabel class]])
                    {
                        if ([newView tag] == indexTag+200)
                        {
                            UILabel *lblDayView = (UILabel *)newView;
                            [lblDayView setTextColor:[UIColor whiteColor]];
                        }
                        
                        if ([newView tag] == indexTag+300)
                        {
                            UILabel *lblDateView = (UILabel *)newView;
                            [lblDateView setTextColor:[UIColor whiteColor]];
                        }
                        
                        [subView setBackgroundColor:kAppBgColor];
                    }
                }
            }
        }
    }
    
    NSDate *currentDate = [dates objectAtIndex:indexTag];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/d/yyyy"];
    NSString *selectedDate = [formatter stringFromDate:currentDate];
    
    [lblSelectTime setHidden:NO];
    [lblSelectTimeLine setHidden:NO];
    
    selectedIndex = nil;
    
    aryTimes = [NSArray array];
    
    if ([[timesDict allKeys] containsObject:selectedDate])
    {
        aryTimes = [timesDict objectForKey:selectedDate];
        
        if ([aryTimes count] > 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [btnContinue setHidden:NO];
                [timesTblView reloadData];
            });
        }
        else
        {
            [btnContinue setHidden:YES];
        }
    }
}

#pragma mark - SET MONTH LABEL

- (void)setMonthLabel:(NSDate *)date
{
    [lblMonthName removeFromSuperview];
    
    NSDate *currentDate = date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM, yyyy"];
    NSString *strMonth = [formatter stringFromDate:currentDate];
    
    lblMonthName = [[UILabel alloc]init];
    [lblMonthName setFrame:CGRectMake(viewWidth - 100, 20, 100,20)];
    [lblMonthName setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblMonthName setBackgroundColor:[UIColor clearColor]];
    [lblMonthName setTextColor:[UIColor blackColor]];
    [lblMonthName setText:strMonth];
    [self.view addSubview:lblMonthName];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [aryTimes count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *timeView;
    UIImageView *radioBtnImgView;
    UILabel *lblTime;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setAccessoryView:nil];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        timeView = [[UIView alloc] init];
        [timeView setFrame:CGRectMake(0, 0, viewWidth, 50)];
        [timeView setTag:1];
        [cell.contentView addSubview:timeView];
        
        radioBtnImgView = [[UIImageView alloc] init];
        [radioBtnImgView setFrame:CGRectMake(20, 14, 24, 24)];
        [radioBtnImgView setTag:2];
        [timeView addSubview:radioBtnImgView];
        
        lblTime = [[UILabel alloc]init];
        [lblTime setFrame:CGRectMake(65, 15, 200,20)];
        [lblTime setTag:3];
        [lblTime setFont:[UIFont fontWithName:kRobotoRegular size:16]];
        [lblTime setBackgroundColor:[UIColor clearColor]];
        [lblTime setTextColor:[UIColor blackColor]];
        [timeView addSubview:lblTime];
    }
    else
    {
        timeView = (UIView *)[cell.contentView viewWithTag:1];
        radioBtnImgView = (UIImageView *)[cell.contentView viewWithTag:2];
        lblTime = (UILabel *)[cell.contentView viewWithTag:3];
    }
    
    if ([indexPath isEqual:selectedIndex])
    {
        [radioBtnImgView setImage:[UIImage imageNamed:@"checkboxFilled"]];
    }
    else
    {
        [radioBtnImgView setImage:[UIImage imageNamed:@"checkboxEmpty"]];
    }
    
    [lblTime setText:[NSString stringWithFormat:@"%@",[aryTimes objectAtIndex:indexPath.row]]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    isTimeSelected = YES;
    selectedIndex = indexPath;
    selectedTimeIndex = (int)indexPath.row;
    [timesTblView reloadData];
}

#pragma mark - CONTINUE Clicked

- (void)continueClicked
{
    if (isTimeSelected)
    {
        NSDate *currentDate = [dates objectAtIndex:selectedDateIndex];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"M/d/yyyy"];
        NSString *selectedDate = [formatter stringFromDate:currentDate];
        
        NSArray *aryTime = [NSArray array];
        
        if ([[timesDict allKeys] containsObject:selectedDate])
        {
            aryTime = [timesDict objectForKey:selectedDate];
            
            if ([aryTime count] > 0)
            {
                NSString *selectedTime = [aryTime objectAtIndex:selectedTimeIndex];
                NSLog(@"Selected %@",selectedTime);
                
                [[GlobalResourcesViewController sharedManager] setSelectedDate:selectedDate];
                [[GlobalResourcesViewController sharedManager] setSelectedTime:selectedTime];
                
                [self performSegueWithIdentifier:@"SuggestionVC" sender:nil];
            }
        }
    }
    else
    {
        [[GlobalResourcesViewController sharedManager] showMessage:@"Please select date" withTitle:nil];
    }
    
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
