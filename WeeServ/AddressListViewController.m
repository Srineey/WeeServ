//
//  AddressListViewController.m
//  WeeServ
//
//  Created by saran c on 24/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "AddressListViewController.h"
#import "GlobalResourcesViewController.h"
#import "GMDCircleLoader.h"

@interface AddressListViewController ()

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    scrlView = [[UIScrollView alloc] init];
    [scrlView setFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [scrlView setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0]];
    [self.view addSubview:scrlView];
    
    [self setNavigationTitle];
    
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
    [self getAddressList];

}

- (void)viewWillAppear:(BOOL)animated
{
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [navLabel1 setText:@"Select address"];
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

#pragma mark - GET ADDRESS LIST

- (void)getAddressList
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@/Address/list",kServerUrl];
    
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
                                          NSLog(@"Address List Response %@", responseDict);
                                          
                                          if ([[responseDict allKeys] containsObject:@"address"])
                                          {
                                              NSDictionary *response = [responseDict objectForKey:@"address"];
                                              
                                              if ([[response allKeys] count] > 0)
                                              {
                                                  if ([[response objectForKey:@"StatusCode"] intValue] ==200)
                                                  {
                                                      dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                          [GMDCircleLoader hideFromView:self.view animated:YES];
                                                          [self setupUI:response];
                                                      });
                                                  }
                                                  else
                                                  {
                                                      [GMDCircleLoader hideFromView:self.view animated:YES];
                                                      [[GlobalResourcesViewController sharedManager] showMessage:@"Getting Address List failed" withTitle:@"Error"];
                                                  }
                                              }
                                          }
                                      }
                                      else
                                      {
                                          [GMDCircleLoader hideFromView:self.view animated:YES];
                                          NSLog(@"Error: %@", error.localizedDescription);
                                          [[GlobalResourcesViewController sharedManager] showMessage:@"Getting Address List failed" withTitle:@"Error"];
                                      }
                                  }];
    
    // Start the task.
    [task resume];
}

#pragma mark - SETUP UI

- (void)setupUI:(NSDictionary *)addressList
{
    if ([[addressList allKeys] containsObject:@"list"])
    {
        addressListArr = [NSArray array];
        addressListArr = [addressList objectForKey:@"list"];
        
        if ([addressListArr count] > 0)
        {
            [GlobalResourcesViewController sharedManager];
            
            UIView *addressBlock;
           
            addressYpos = 20;
            
            for (int i = 0; i < addressListArr.count; i++)
            {
                addressBlock = [self addressDetails:[addressListArr objectAtIndex:i]];
                
                UIButton *btnAddressBlock = [UIButton buttonWithType:UIButtonTypeCustom];
                [btnAddressBlock setFrame:addressBlock.frame];
                [btnAddressBlock addTarget:self action:@selector(addressBlockSelected:) forControlEvents:UIControlEventTouchUpInside];
                [btnAddressBlock setTag:i];
                [scrlView addSubview:btnAddressBlock];
                
                addressYpos += 140;
            }
            
            UILabel *lblor = [[UILabel alloc]init];
            [lblor setFrame:CGRectMake(0, addressBlock.frame.origin.y + addressBlock.frame.size.height + 20, viewWidth, 20)];
            [lblor setFont:[UIFont fontWithName:kRobotoRegular size:16]];
            [lblor setBackgroundColor:[UIColor clearColor]];
            [lblor setTextColor:[UIColor grayColor]];
            [lblor setTextAlignment:NSTextAlignmentCenter];
            [lblor setText:@"or"];
            [scrlView addSubview:lblor];
            
            btnAddNewAddress = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnAddNewAddress setFrame:CGRectMake(20, addressBlock.frame.origin.y + addressBlock.frame.size.height + 60, viewWidth - 40, 40)];
            [btnAddNewAddress setTitle:@"Add new address" forState:UIControlStateNormal];
            [btnAddNewAddress setTitleColor:kAppBgColor forState:UIControlStateNormal];
            [btnAddNewAddress.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:14.0]];
            [btnAddNewAddress setBackgroundColor:[UIColor whiteColor]];
            [btnAddNewAddress.layer setBorderWidth:1.0];
            [btnAddNewAddress.layer setBorderColor:kAppBgColor.CGColor];
            [btnAddNewAddress addTarget:self action:@selector(addNewAddressClicked) forControlEvents:UIControlEventTouchUpInside];
            [scrlView addSubview:btnAddNewAddress];
            
            [scrlView setContentSize:CGSizeMake(viewWidth, btnAddNewAddress.frame.origin.y + btnAddNewAddress.frame.size.height + 25)];
        }
        else
        {
            btnAddNewAddress = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnAddNewAddress setFrame:CGRectMake(20, 30, viewWidth - 40, 40)];
            [btnAddNewAddress setTitle:@"Add new address" forState:UIControlStateNormal];
            [btnAddNewAddress setTitleColor:kAppBgColor forState:UIControlStateNormal];
            [btnAddNewAddress setBackgroundColor:[UIColor whiteColor]];
            [btnAddNewAddress.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:14.0]];
            [btnAddNewAddress.layer setBorderWidth:1.0];
            [btnAddNewAddress.layer setBorderColor:kAppBgColor.CGColor];
            [btnAddNewAddress addTarget:self action:@selector(addNewAddressClicked) forControlEvents:UIControlEventTouchUpInside];
            [scrlView addSubview:btnAddNewAddress];
        }
    }
}

#pragma mark - CREATING ADDRESS VIEW

- (UIView *)addressDetails:(NSDictionary *)list
{
    UIView *addressView = [[UIView alloc] init];
    [addressView setFrame:CGRectMake(20, addressYpos, viewWidth - 40, 120)];
    [addressView setBackgroundColor:[UIColor whiteColor]];
    
    NSString *houseNum = [NSString stringWithFormat:@"%@, %@,",[list objectForKey:khouse_number],[list objectForKey:kstreet_name]];
    
    UILabel *lblHouseNo = [[UILabel alloc]init];
    [lblHouseNo setFrame:CGRectMake(15, 15, addressView.frame.size.width - 30, 20)];
    [lblHouseNo setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblHouseNo setBackgroundColor:[UIColor clearColor]];
    [lblHouseNo setTextColor:[UIColor blackColor]];
    [lblHouseNo setText:houseNum];
    [addressView addSubview:lblHouseNo];
    
    NSString *landmark = [NSString stringWithFormat:@"%@,",[list objectForKey:klandmark]];
    
    UILabel *lblLandmark = [[UILabel alloc]init];
    [lblLandmark setFrame:CGRectMake(15, 40, addressView.frame.size.width - 30, 20)];
    [lblLandmark setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblLandmark setBackgroundColor:[UIColor clearColor]];
    [lblLandmark setTextColor:[UIColor blackColor]];
    [lblLandmark setText:landmark];
    [addressView addSubview:lblLandmark];
    
    NSString *area = [NSString stringWithFormat:@"%@,",[list objectForKey:klocality]];
    
    UILabel *lblArea = [[UILabel alloc]init];
    [lblArea setFrame:CGRectMake(15, 65, addressView.frame.size.width - 30, 20)];
    [lblArea setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblArea setBackgroundColor:[UIColor clearColor]];
    [lblArea setTextColor:[UIColor blackColor]];
    [lblArea setText:area];
    [addressView addSubview:lblArea];
    
    NSString *city = [NSString stringWithFormat:@"%@, %@",[[list objectForKey:kcity] objectForKey:@"name"],[list objectForKey:@"pincode"]];
    
    UILabel *lblCity = [[UILabel alloc]init];
    [lblCity setFrame:CGRectMake(15, 90, addressView.frame.size.width - 30, 20)];
    [lblCity setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblCity setBackgroundColor:[UIColor clearColor]];
    [lblCity setTextColor:[UIColor blackColor]];
    [lblCity setText:city];
    [addressView addSubview:lblCity];
    
    UIImageView *seeAllIndicatorImg = [[UIImageView alloc] init];
    [seeAllIndicatorImg setFrame:CGRectMake(addressView.frame.size.width - 30, 45, 30, 30)];
    [seeAllIndicatorImg setImage:[UIImage imageNamed:@"right_arrow_grey"]];
    [addressView addSubview:seeAllIndicatorImg];
    
    [scrlView addSubview:addressView];
    
    return addressView;
}

#pragma mark - ADDRESS SELECTED

- (IBAction)addressBlockSelected:(id)sender
{
    NSDictionary *dictSelectedAddress = [addressListArr objectAtIndex:[sender tag]];
    NSString *selectedAddressId = [dictSelectedAddress objectForKey:@"id"];
    [[GlobalResourcesViewController sharedManager] setSelectedAddress:dictSelectedAddress];
    [[GlobalResourcesViewController sharedManager] setSelectedAddressId:selectedAddressId];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self performSegueWithIdentifier:@"scheduleDate" sender:nil];
    });
}

#pragma mark - ADD NEW ADDRESS CLICKED

- (void)addNewAddressClicked
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self performSegueWithIdentifier:@"AddNewAddress" sender:nil];
    });
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
