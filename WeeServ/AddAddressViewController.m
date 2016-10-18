//
//  AddAddressViewController.m
//  WeeServ
//
//  Created by saran c on 24/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "AddAddressViewController.h"
#import "GlobalResourcesViewController.h"

@interface AddAddressViewController ()

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    scrlView = [[UIScrollView alloc] init];
    [scrlView setFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [self.view addSubview:scrlView];
    
    [self setNavigationTitle];
    
    [self setupUI];
    
    [[GlobalResourcesViewController sharedManager] setIsSelectedArea:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([GlobalResourcesViewController sharedManager].isSelectedArea)
    {
        [txtLocality setText:[GlobalResourcesViewController sharedManager].selectedAreaName];
    }
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [navLabel1 setText:@"Add new address"];
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
    
    UIButton *doneButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setImage:[UIImage imageNamed:@"white_tick.png"] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(addNewAddress)forControlEvents:UIControlEventTouchUpInside];
    [doneButton setFrame:CGRectMake(0, 0, 44 ,44)];
    UIBarButtonItem *sideDoneButton = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    [self.navigationItem setRightBarButtonItem:sideDoneButton];
}

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SETUP UI

- (void)setupUI
{
    //HOUSE NO
    lblHouseNo = [[UILabel alloc]init];
    [lblHouseNo setFrame:CGRectMake(20, 20, 250, 20)];
    [lblHouseNo setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblHouseNo setBackgroundColor:[UIColor clearColor]];
    [lblHouseNo setTextColor:kHeadingTextColor];
    [lblHouseNo setText:@"HOUSE NO."];
    
    txtHouseNo = [[UITextField alloc] init];
    [txtHouseNo setFrame:CGRectMake(20, lblHouseNo.frame.origin.y + lblHouseNo.frame.size.height, viewWidth - 40, 30)];
    [txtHouseNo setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [txtHouseNo setPlaceholder:@"535"];
    [txtHouseNo setDelegate:self];
    
    lblHouseNoLine = [[UILabel alloc] init];
    [lblHouseNoLine setFrame:CGRectMake(20, txtHouseNo.frame.origin.y + txtHouseNo.frame.size.height, viewWidth - 40, 1)];
    [lblHouseNoLine setBackgroundColor:kLineBgColor];
    
    [scrlView addSubview:lblHouseNo];
    [scrlView addSubview:txtHouseNo];
    [scrlView addSubview:lblHouseNoLine];
    
    //STREET
    lblStreet = [[UILabel alloc]init];
    [lblStreet setFrame:CGRectMake(20, lblHouseNoLine.frame.origin.y + lblHouseNoLine.frame.size.height + 20, 250, 20)];
    [lblStreet setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblStreet setBackgroundColor:[UIColor clearColor]];
    [lblStreet setTextColor:kHeadingTextColor];
    [lblStreet setText:@"STREET"];
    
    txtStreet = [[UITextField alloc] init];
    [txtStreet setFrame:CGRectMake(20, lblStreet.frame.origin.y + lblStreet.frame.size.height, viewWidth - 40, 30)];
    [txtStreet setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [txtStreet setPlaceholder:@"Ramaswamy Street"];
    [txtStreet setDelegate:self];
    
    lblStreetLine = [[UILabel alloc] init];
    [lblStreetLine setFrame:CGRectMake(20, txtStreet.frame.origin.y + txtStreet.frame.size.height, viewWidth - 40, 1)];
    [lblStreetLine setBackgroundColor:kLineBgColor];
    
    [scrlView addSubview:lblStreet];
    [scrlView addSubview:txtStreet];
    [scrlView addSubview:lblStreetLine];
    
    //LOCALITY
    lblLocality = [[UILabel alloc]init];
    [lblLocality setFrame:CGRectMake(20, lblStreetLine.frame.origin.y + lblStreetLine.frame.size.height + 20, 250, 20)];
    [lblLocality setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblLocality setBackgroundColor:[UIColor clearColor]];
    [lblLocality setTextColor:kHeadingTextColor];
    [lblLocality setText:@"LOCALITY"];
    
    txtLocality = [[UITextField alloc] init];
    [txtLocality setFrame:CGRectMake(20, lblLocality.frame.origin.y + lblLocality.frame.size.height, viewWidth - 40, 30)];
    [txtLocality setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [txtLocality setPlaceholder:@"Perungudi"];
    [txtLocality setUserInteractionEnabled:NO];
    [txtLocality setDelegate:self];
    
    UIButton *btnSelectLocalty = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSelectLocalty setFrame:txtLocality.frame];
    [btnSelectLocalty addTarget:self action:@selector(selectLocality) forControlEvents:UIControlEventTouchUpInside];
    
    lblLocalityLine = [[UILabel alloc] init];
    [lblLocalityLine setFrame:CGRectMake(20, txtLocality.frame.origin.y + txtLocality.frame.size.height, viewWidth - 40, 1)];
    [lblLocalityLine setBackgroundColor:kLineBgColor];
    
    [scrlView addSubview:lblLocality];
    [scrlView addSubview:txtLocality];
    [scrlView addSubview:btnSelectLocalty];
    [scrlView addSubview:lblLocalityLine];
    
    //CITY
    lblCity = [[UILabel alloc]init];
    [lblCity setFrame:CGRectMake(20, lblLocalityLine.frame.origin.y + lblLocalityLine.frame.size.height + 20, 250, 20)];
    [lblCity setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblCity setBackgroundColor:[UIColor clearColor]];
    [lblCity setTextColor:kHeadingTextColor];
    [lblCity setText:@"CITY"];
    
    txtCity = [[UITextField alloc] init];
    [txtCity setFrame:CGRectMake(20, lblCity.frame.origin.y + lblCity.frame.size.height, viewWidth - 40, 30)];
    [txtCity setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [txtCity setPlaceholder:@"Chennai"];
    [txtCity setUserInteractionEnabled:NO];
    [txtCity setDelegate:self];
    
    lblCityLine = [[UILabel alloc] init];
    [lblCityLine setFrame:CGRectMake(20, txtCity.frame.origin.y + txtCity.frame.size.height, viewWidth - 40, 1)];
    [lblCityLine setBackgroundColor:kLineBgColor];
    
    [scrlView addSubview:lblCity];
    [scrlView addSubview:txtCity];
    [scrlView addSubview:lblCityLine];
    
    //LANDMARK
    lblLandMark = [[UILabel alloc]init];
    [lblLandMark setFrame:CGRectMake(20, lblCityLine.frame.origin.y + lblCityLine.frame.size.height + 20, 250, 20)];
    [lblLandMark setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblLandMark setBackgroundColor:[UIColor clearColor]];
    [lblLandMark setTextColor:kHeadingTextColor];
    [lblLandMark setText:@"LANDMARK"];
    
    txtLandMark = [[UITextField alloc] init];
    [txtLandMark setFrame:CGRectMake(20, lblLandMark.frame.origin.y + lblLandMark.frame.size.height, viewWidth - 40, 30)];
    [txtLandMark setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [txtLandMark setPlaceholder:@"Near RMZ IT Park"];
    [txtLandMark setDelegate:self];
    
    lblLandMarkLine = [[UILabel alloc] init];
    [lblLandMarkLine setFrame:CGRectMake(20, txtLandMark.frame.origin.y + txtLandMark.frame.size.height, viewWidth - 40, 1)];
    [lblLandMarkLine setBackgroundColor:kLineBgColor];
    
    [scrlView addSubview:lblLandMark];
    [scrlView addSubview:txtLandMark];
    [scrlView addSubview:lblLandMarkLine];
    
    //PINCODE
    lblPincode = [[UILabel alloc]init];
    [lblPincode setFrame:CGRectMake(20, lblLandMarkLine.frame.origin.y + lblLandMarkLine.frame.size.height + 20, 250, 20)];
    [lblPincode setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblPincode setBackgroundColor:[UIColor clearColor]];
    [lblPincode setTextColor:kHeadingTextColor];
    [lblPincode setText:@"PINCODE"];
    
    txtPincode = [[UITextField alloc] init];
    [txtPincode setFrame:CGRectMake(20, lblPincode.frame.origin.y + lblPincode.frame.size.height, viewWidth - 40, 30)];
    [txtPincode setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [txtPincode setPlaceholder:@"600096"];
    [txtPincode setDelegate:self];
    
    lblPincodeLine = [[UILabel alloc] init];
    [lblPincodeLine setFrame:CGRectMake(20, txtPincode.frame.origin.y + txtPincode.frame.size.height, viewWidth - 40, 1)];
    [lblPincodeLine setBackgroundColor:kLineBgColor];
    
    [scrlView addSubview:lblPincode];
    [scrlView addSubview:txtPincode];
    [scrlView addSubview:lblPincodeLine];
    
    txtHouseNo.text = @"535";
    txtStreet.text = @"Ramaswamy Street";
    txtLocality.text = @"Tambaram";
    txtCity.text = @"Chennai";
    txtLandMark.text = @"Near RMZ IT Park";
    txtPincode.text = @"600023";
}

#pragma mark - Select Locality

- (void)selectLocality
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self performSegueWithIdentifier:@"SelectArea" sender:nil];
    });
}

#pragma mark - Add Address Service

- (void)addNewAddress
{
    if ([txtHouseNo.text length] != 0 && [txtStreet.text length] != 0 && [txtLocality.text length] != 0 && [txtCity.text length] != 0 && [txtLandMark.text length] != 0 && [txtPincode.text length] != 0)
    {
        NSString *stringURL = [NSString stringWithFormat:@"%@/Address/AddNewAddress",kServerUrl];
        
        NSMutableDictionary *dictCity = [NSMutableDictionary dictionary];
        [dictCity setObject:[[GlobalResourcesViewController sharedManager] selectedCityId] forKey:@"id"];
        [dictCity setObject:[[GlobalResourcesViewController sharedManager] selectedCityName] forKey:@"name"];
        
        NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
        [dictRequest setObject:[[GlobalResourcesViewController sharedManager] strName] forKey:kname];
        [dictRequest setObject:txtHouseNo.text forKey:khouse_number];
        [dictRequest setObject:txtStreet.text forKey:kstreet_name];
        [dictRequest setObject:txtLocality.text forKey:klocality];
        [dictRequest setObject:txtLandMark.text forKey:klandmark];
        [dictRequest setObject:txtPincode.text forKey:kpincode_key];
        [dictRequest setObject:dictCity forKey:kcity];
        [dictRequest setObject:@"13.98765" forKey:klatitude];
        [dictRequest setObject:@"80.34567" forKey:klongtitude];
        
        NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dictRequest
                                                           options:0
                                                             error:nil];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *accessToken = [NSString stringWithFormat:@"Bearer %@ ",[userDefaults objectForKey:kaccess_token]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:accessToken forHTTPHeaderField:@"Authorization"];
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
                                              NSLog(@"Add New Address Response %@", responseDict);
                                              
                                              if ([[responseDict allKeys] containsObject:@"address"])
                                              {
                                                  NSDictionary *response = [responseDict objectForKey:@"address"];
                                                  
                                                  if ([[response allKeys] count] > 0)
                                                  {
                                                      if ([[response objectForKey:@"StatusCode"] intValue] ==200)
                                                      {
                                                          [[GlobalResourcesViewController sharedManager] showMessage:@"Address has been added successfully" withTitle:@"Success"];
                                                      }
                                                  }
                                              }
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      }];
        
        // Start the task.
        [task resume];

    }
    else
    {
        [[GlobalResourcesViewController sharedManager] showMessage:@"All fields mandatory" withTitle:nil];
    }
}

#pragma mark - Text filed delegates

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    /*if (textField == txtHouseNo)
    {
        [txtStreet becomeFirstResponder];
    }
    else if (textField == txtStreet)
    {
        [txtLocality becomeFirstResponder];
    }
    else if (textField == txtLocality)
    {
        [txtCity becomeFirstResponder];
    }
    else if (textField == txtCity)
    {
        [txtLandMark becomeFirstResponder];
    }
    else if (textField == txtLandMark)
    {
        [txtPincode becomeFirstResponder];
    }
    else if (textField == txtPincode)
    {
        [textField resignFirstResponder];
    }*/
    
    [textField resignFirstResponder];
    
    [scrlView setContentOffset:CGPointMake(0, 0)];
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == txtHouseNo)
    {
        [scrlView setContentOffset:CGPointMake(0, 0)];
    }
    else if (textField == txtStreet)
    {
        [scrlView setContentOffset:CGPointMake(0, 0)];
    }
    else if (textField == txtLocality)
    {
        [scrlView setContentOffset:CGPointMake(0, 0)];
    }
    else if (textField == txtCity)
    {
        [scrlView setContentOffset:CGPointMake(0, 100)];
    }
    else if (textField == txtLandMark)
    {
        [scrlView setContentOffset:CGPointMake(0, 100)];
    }
    else if (textField == txtPincode)
    {
        [scrlView setContentOffset:CGPointMake(0, 100)];
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
