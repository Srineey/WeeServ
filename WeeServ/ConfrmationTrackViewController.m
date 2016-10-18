//
//  ConfrmationTrackViewController.m
//  WeeServ
//
//  Created by saran c on 29/09/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "ConfrmationTrackViewController.h"
#import "GlobalResourcesViewController.h"


@interface ConfrmationTrackViewController ()

@end

@implementation ConfrmationTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    [self getOrderDetails];
    
    [self setNavigationTitle];
    
    [self setupUI];
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

#pragma mark - GET ORDER DETAILS

- (void)getOrderDetails
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@/trade/10043",kServerUrl];
    
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
                                          NSLog(@"Order Details Response %@", responseDict);
                                          
//                                          if ([[responseDict allKeys] containsObject:@"address"])
//                                          {
//                                              NSDictionary *response = [responseDict objectForKey:@"address"];
//                                              
//                                              if ([[response allKeys] count] > 0)
//                                              {
//                                                  if ([[response objectForKey:@"StatusCode"] intValue] ==200)
//                                                  {
//                                                      dispatch_async(dispatch_get_main_queue(), ^(void) {
//                                                          [GMDCircleLoader hideFromView:self.view animated:YES];
//                                                          [self setupUI:response];
//                                                      });
//                                                  }
//                                                  else
//                                                  {
//                                                      [GMDCircleLoader hideFromView:self.view animated:YES];
//                                                      [[GlobalResourcesViewController sharedManager] showMessage:@"Getting Address List failed" withTitle:@"Error"];
//                                                  }
//                                              }
//                                          }
                                      }
                                      else
                                      {
//                                          [GMDCircleLoader hideFromView:self.view animated:YES];
//                                          NSLog(@"Error: %@", error.localizedDescription);
//                                          [[GlobalResourcesViewController sharedManager] showMessage:@"Getting Address List failed" withTitle:@"Error"];
                                      }
                                  }];
    
    // Start the task.
    [task resume];
}

#pragma mark - SETUP UI

- (void)setupUI
{
    UIScrollView *scrlView = [[UIScrollView alloc] init];
    [scrlView setFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [scrlView setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]];
    [self.view addSubview:scrlView];
    
    //TECHNICIAN VIEW
    
    UIView *technicianView = [[UIView alloc] init];
    [technicianView setFrame:CGRectMake(0, 0, viewWidth, 95)];
    [technicianView setBackgroundColor:[UIColor whiteColor]];
    [scrlView addSubview:technicianView];
    
    UIImageView *imgTechnicianProfile = [[UIImageView alloc] init];
    [imgTechnicianProfile setFrame:CGRectMake(20, 20, 44, 44)];
    [imgTechnicianProfile.layer setCornerRadius:22.0];
    [imgTechnicianProfile setImage:[UIImage imageNamed:@"profile_pic_default"]];
    [technicianView addSubview:imgTechnicianProfile];
    
    UILabel *lblID = [[UILabel alloc] init];
    [lblID setFrame:CGRectMake(85, 10, viewWidth - 100, 18)];
    [lblID setTextColor:[UIColor grayColor]];
    [lblID setFont:[UIFont fontWithName:kRobotoRegular size:14.0]];
    [lblID setText:@"ID:867534"];
    [technicianView addSubview:lblID];
    
    UILabel *lblServiceType = [[UILabel alloc] init];
    [lblServiceType setFrame:CGRectMake(85, 35, viewWidth - 100, 20)];
    [lblServiceType setTextColor:[UIColor blackColor]];
    [lblServiceType setFont:[UIFont fontWithName:kRobotoMedium size:16.0]];
    [lblServiceType setText:@"Home Services"];
    [technicianView addSubview:lblServiceType];
    
    UILabel *lblDate = [[UILabel alloc] init];
    [lblDate setFrame:CGRectMake(85, 65, viewWidth - 100, 18)];
    [lblDate setTextColor:[UIColor grayColor]];
    [lblDate setFont:[UIFont fontWithName:kRobotoRegular size:14.0]];
    [lblDate setText:@"June 15, 2016. Wednesday 10:00 AM"];
    [technicianView addSubview:lblDate];
    
    confirmationBlock = [[ConfirmationBlock alloc] initWithFrame:CGRectMake(0, technicianView.frame.origin.y + technicianView.frame.size.height + 2, viewWidth, 180)];
//    [servicesListView categoryListView:[aryServicesList objectAtIndex:i]];
    [scrlView addSubview:confirmationBlock];
    
    summaryBlock = [[SummaryBlock alloc] initWithFrame:CGRectMake(0, confirmationBlock.frame.origin.y + confirmationBlock.frame.size.height + 2, viewWidth, 500)];
    //    [servicesListView categoryListView:[aryServicesList objectAtIndex:i]];
    [scrlView addSubview:summaryBlock];
    
    [scrlView setContentSize:CGSizeMake(viewWidth, summaryBlock.frame.origin.y + summaryBlock.frame.size.height + 30)];
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
