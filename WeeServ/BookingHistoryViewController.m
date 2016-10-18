//
//  BookingHistoryViewController.m
//  WeeServ
//
//  Created by saran c on 08/09/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "BookingHistoryViewController.h"
#import "GlobalResourcesViewController.h"
#import "SWRevealViewController.h"
#import "UIImageView+WebCache.h"
#import "GMDCircleLoader.h"

@interface BookingHistoryViewController ()

@end

@implementation BookingHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    arrBookingHistory = [NSMutableArray array];
    
    [self setNavigationTitle];
    
    [self setupUI];
    
    [self getBookingHistory];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [navLabel1 setText:@"Booking History"];
    [navLabel1 setTextColor:[UIColor whiteColor]];
    [navLabel1 setTextAlignment:NSTextAlignmentLeft];
    [navLabel1 setBackgroundColor:[UIColor clearColor]];
    [viewNav addSubview:navLabel1];
    
    self.navigationItem.titleView = viewNav;
    
//    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(btnMenuClick)forControlEvents:UIControlEventTouchUpInside];
//    [button setFrame:CGRectMake(0, 0, 44 ,44)];
//    UIBarButtonItem *_sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    
//    [self.navigationItem setLeftBarButtonItem:_sidebarButton];
//    
//    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    if ([GlobalResourcesViewController sharedManager].isFromMenu)
    {
        UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
        [button addTarget:self.revealViewController action:@selector(revealToggle:)forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(0, 0, 44 ,44)];
        UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        [self.navigationItem setLeftBarButtonItem:sidebarButton];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    else
    {
        UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back-icon.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnBackClick)forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(0, 0, 44 ,44)];
        UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self.navigationItem setLeftBarButtonItem:sidebarButton];
    }
    
}

- (void)setupUI
{
    tblView = [[UITableView alloc] init];
    [tblView setFrame:CGRectMake(0, 0, viewWidth, viewHeight - 64)];
    [tblView setDelegate:self];
    [tblView setDataSource:self];
    [tblView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tblView setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]];
    [self.view addSubview:tblView];
}

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SIDE MENU CLICK

- (void)btnMenuClick
{
    // Change button color
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
//    _sidebarButton.target = self.revealViewController;
//    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

#pragma mark - GET BOOKING HISTORY

- (void)getBookingHistory
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/trade/tradelistUsers",kServerUrl];
    
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@ ",[userDefaults objectForKey:kaccess_token]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:accessToken forHTTPHeaderField:@"Authorization"];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data,
                                                                                     NSURLResponse *response,
                                                                                     NSError *error)
                                  {
                                      if (!error)
                                      {
                                          NSDictionary *responseDict   =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          NSLog(@"Booking List Response %@", responseDict);
                                          
                                          if ([[responseDict allKeys] containsObject:@"trade"])
                                          {
                                              arrBookingHistory = [responseDict objectForKey:@"trade"];
                                              
                                              if ([arrBookingHistory count] > 0)
                                              {
                                                      dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                          [GMDCircleLoader hideFromView:self.view animated:YES];
                                                          [tblView reloadData];
                                                      });
                                              }
                                              else
                                              {
                                                  NSLog(@"No Data");
                                              }
                                          }
                                      }
                                      else
                                      {
//                                          [GMDCircleLoader hideFromView:self.view animated:YES];
                                          NSLog(@"Error: %@", error.localizedDescription);
                                          [[GlobalResourcesViewController sharedManager] showMessage:@"Getting Booking List failed" withTitle:@"Error"];
                                      }
                                  }];
    
    // Start the task.
    [task resume];


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrBookingHistory count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *historyView;
    UIImageView *technicianImgView, *arrowIndicatorImg;
    UILabel *lblServiceName, *lblJobDate, *lblJobTime, *lblJobStatus;
//    UIButton *btnShow;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *bookingDict = [arrBookingHistory objectAtIndex:indexPath.row];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setAccessoryView:nil];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        historyView = [[UIView alloc] init];
        [historyView setFrame:CGRectMake(15, 12, viewWidth - 30, 105)];
        [historyView setTag:1];
        [historyView setBackgroundColor:[UIColor whiteColor]];
        [historyView.layer setBorderWidth:1.0];
        [historyView.layer setBorderColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0].CGColor];
        [historyView.layer setCornerRadius:5.0];
        [cell.contentView addSubview:historyView];
        
        technicianImgView = [[UIImageView alloc] init];
        [technicianImgView setFrame:CGRectMake(10, 10, 40, 40)];
        [technicianImgView setTag:2];
        [technicianImgView setBackgroundColor:[UIColor clearColor]];
        [technicianImgView.layer setCornerRadius:20];
        [technicianImgView.layer setMasksToBounds:YES];
        [technicianImgView.layer setBorderWidth:0.5];
        [technicianImgView.layer setBorderColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0].CGColor];
        [historyView addSubview:technicianImgView];
        
        arrowIndicatorImg = [[UIImageView alloc] init];
        [arrowIndicatorImg setFrame:CGRectMake(historyView.frame.size.width - 45, 38, 30, 30)];
        [arrowIndicatorImg setImage:[UIImage imageNamed:@"right_arrow_grey"]];
        [arrowIndicatorImg setTag:15];
        [historyView addSubview:arrowIndicatorImg];
        
        lblServiceName = [[UILabel alloc]init];
        [lblServiceName setFrame:CGRectMake(63, 10, 200,20)];
        [lblServiceName setTag:3];
        [lblServiceName setFont:[UIFont fontWithName:kRobotoMedium size:14]];
        [lblServiceName setBackgroundColor:[UIColor clearColor]];
        [lblServiceName setTextColor:[UIColor blackColor]];
        [historyView addSubview:lblServiceName];
        
        lblJobDate = [[UILabel alloc]init];
        [lblJobDate setFrame:CGRectMake(63, lblServiceName.frame.origin.y + lblServiceName.frame.size.height + 5, 150,20)];
        [lblJobDate setTag:5];
        [lblJobDate setFont:[UIFont fontWithName:kRobotoRegular size:14]];
        [lblJobDate setBackgroundColor:[UIColor clearColor]];
        [lblJobDate setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        [historyView addSubview:lblJobDate];
        
        lblJobTime = [[UILabel alloc]init];
        [lblJobTime setFrame:CGRectMake(63, lblJobDate.frame.origin.y + lblJobDate.frame.size.height, 150,20)];
        [lblJobTime setTag:6];
        [lblJobTime setFont:[UIFont fontWithName:kRobotoRegular size:14]];
        [lblJobTime setBackgroundColor:[UIColor clearColor]];
        [lblJobTime setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        [historyView addSubview:lblJobTime];
        
        lblJobStatus = [[UILabel alloc]init];
        [lblJobStatus setFrame:CGRectMake(63, lblJobTime.frame.origin.y + lblJobTime.frame.size.height + 5, 150,20)];
        [lblJobStatus setTag:7];
        [lblJobStatus setFont:[UIFont fontWithName:kRobotoMedium size:14]];
        [lblJobStatus setBackgroundColor:[UIColor clearColor]];
        [lblJobStatus setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        [historyView addSubview:lblJobStatus];
        
//        btnBook = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btnBook setFrame:CGRectMake(110, lblTechnicianCharge.frame.origin.y + lblTechnicianCharge.frame.size.height + 10, 70, 24)];
//        [btnBook setTag:12];
//        [btnBook.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:12]];
//        [btnBook setTitle:@"BOOK" forState:UIControlStateNormal];
//        [btnBook setTitleColor:[UIColor colorWithRed:155.0/255.0 green:210.0/255.0 blue:93.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//        [btnBook.layer setBorderWidth:0.5];
//        [btnBook.layer setBorderColor:[UIColor colorWithRed:155.0/255.0 green:210.0/255.0 blue:93.0/255.0 alpha:1.0].CGColor];
//        [btnBook addTarget:self action:@selector(bookClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [technicianView addSubview:btnBook];
    }
    else
    {
        historyView = (UIView *)[cell.contentView viewWithTag:1];
        technicianImgView = (UIImageView *)[cell.contentView viewWithTag:2];
        lblServiceName = (UILabel *)[cell.contentView viewWithTag:3];
        lblJobDate = (UILabel *)[cell.contentView viewWithTag:5];
        lblJobTime = (UILabel *)[cell.contentView viewWithTag:6];
        lblJobStatus = (UILabel *)[cell.contentView viewWithTag:7];
        arrowIndicatorImg = (UIImageView *)[cell.contentView viewWithTag:15];
    }
    
    NSString *stringUrl = [NSString stringWithFormat:@"%@",[bookingDict objectForKey:@"technician_photo"]];
    [technicianImgView sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"] ];
    
    [lblServiceName setText:[NSString stringWithFormat:@"%@",[bookingDict objectForKey:@"category"]]];
    [lblJobDate setText:[NSString stringWithFormat:@"%@",[bookingDict objectForKey:@"bookeddate"]]];
    [lblJobTime setText:[NSString stringWithFormat:@"%@",[bookingDict objectForKey:@"bookedtime"]]];
    [lblJobStatus setText:[NSString stringWithFormat:@"%@",[bookingDict objectForKey:@"status"]]];
    
//    if ([[technicianDict objectForKey:@"goldpartner"] boolValue])
//    {
//        [crownImg setHidden:NO];
//    }
//    else
//    {
//        [crownImg setHidden:YES];
//    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    [GlobalResourcesViewController sharedManager].selectedTechnicianId = [NSString stringWithFormat:@"%@",[[technicianAry objectAtIndex:indexPath.row] objectForKey:@"id"]];
    
//    [self performSegueWithIdentifier:@"A" sender:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"ConfrmationTrackViewController"];
    [self.navigationController pushViewController:ivc animated:YES];
    
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
