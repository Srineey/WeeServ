//
//  LoginViewController.m
//  WeeServ
//
//  Created by saran c on 18/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "LoginViewController.h"
#import "GlobalResourcesViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    [self.navigationController setNavigationBarHidden:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if ([[userDefaults objectForKey:kisUserLoggedIn] boolValue])
    {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self performSegueWithIdentifier:@"goMain" sender:nil];
        });
    }
    else
    {
        [self setupUI];
    }
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - SETUP UI

- (void)setupUI
{
    int width = viewWidth - 70;
    
    lbl1 = [[UILabel alloc] init];
    [lbl1 setFrame:CGRectMake(32, 120, width, 15)];
    [lbl1 setText:@"Please confirm your country code and enter your"];
    [lbl1 setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lbl1 setTextColor:[UIColor blackColor]];
    [lbl1 setTextAlignment:NSTextAlignmentLeft];
    [scrlView addSubview:lbl1];
    
    lbl2 = [[UILabel alloc] init];
    [lbl2 setFrame:CGRectMake(32, lbl1.frame.origin.y + lbl1.frame.size.height + 3, width, 15)];
    [lbl2 setText:@"phone number"];
    [lbl2 setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lbl2 setTextColor:[UIColor blackColor]];
    [lbl2 setTextAlignment:NSTextAlignmentLeft];
    [scrlView addSubview:lbl2];
    
    
    //COUNTRTY
    
    lblCountry = [[UILabel alloc] init];
    [lblCountry setFrame:CGRectMake(32, lbl2.frame.origin.y + lbl2.frame.size.height + 30, width, 15)];
    [lblCountry setText:@"COUNTRY"];
    [lblCountry setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblCountry setTextColor:[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]];
    [lblCountry setTextAlignment:NSTextAlignmentLeft];
    [scrlView addSubview:lblCountry];
    
    lblLine1 = [[UILabel alloc] init];
    [lblLine1 setFrame:CGRectMake(32, lblCountry.frame.origin.y + lblCountry.frame.size.height + 35, width, 2)];
    [lblLine1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [scrlView addSubview:lblLine1];
    
    txtCountry = [[UITextField alloc] init];
    [txtCountry setFrame:CGRectMake(32, lblCountry.frame.origin.y + lblCountry.frame.size.height + 5, width - 30, 25)];
    [txtCountry setText:@"India"];
    [txtCountry setTextColor:[UIColor blackColor]];
    [txtCountry setFont:[UIFont fontWithName:kRobotoRegular size:13]];
    [txtCountry setEnabled:NO];
    [scrlView addSubview:txtCountry];
    
    UIImageView *imgDownArrow = [[UIImageView alloc] init];
    [imgDownArrow setFrame:CGRectMake(width, lblCountry.frame.origin.y + lblCountry.frame.size.height + 10, 24, 24)];
    [imgDownArrow setImage:[UIImage imageNamed:@"down_arrow"]];
    [scrlView addSubview:imgDownArrow];

    //PHONE NUMBER
    
    lblUserName = [[UILabel alloc] init];
    [lblUserName setFrame:CGRectMake(32, lblLine1.frame.origin.y + lblLine1.frame.size.height + 30, width, 15)];
    [lblUserName setText:@"USERNAME"];
    [lblUserName setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblUserName setTextColor:[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]];
    [lblUserName setTextAlignment:NSTextAlignmentLeft];
    [scrlView addSubview:lblUserName];
    
    lblLine2 = [[UILabel alloc] init];
    [lblLine2 setFrame:CGRectMake(32, lblUserName.frame.origin.y + lblUserName.frame.size.height + 35, width, 2)];
    [lblLine2 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [scrlView addSubview:lblLine2];
    
    txtCountryCode = [[UITextField alloc] init];
    [txtCountryCode setFrame:CGRectMake(32, lblUserName.frame.origin.y + lblUserName.frame.size.height + 5, 55, 25)];
    [txtCountryCode setText:@"+91"];
    [txtCountryCode setTextColor:[UIColor blackColor]];
    [txtCountryCode setFont:[UIFont fontWithName:kRobotoRegular size:13]];
    [txtCountryCode setTextAlignment:NSTextAlignmentCenter];
    [txtCountryCode setEnabled:NO];
    [scrlView addSubview:txtCountryCode];
    
    lblLine3 = [[UILabel alloc] init];
    [lblLine3 setFrame:CGRectMake(txtCountryCode.frame.origin.x + txtCountryCode.frame.size.width + 5, lblUserName.frame.origin.y + lblUserName.frame.size.height + 5, 2, 25)];
    [lblLine3 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [scrlView addSubview:lblLine3];
    
    txtPhoneNumber = [[UITextField alloc] init];
    [txtPhoneNumber setFrame:CGRectMake(txtCountryCode.frame.origin.x + txtCountryCode.frame.size.width + 25, lblUserName.frame.origin.y + lblUserName.frame.size.height + 5, 200, 25)];
    [txtPhoneNumber setPlaceholder:@"Enter 10 digit phone number"];
    [txtPhoneNumber setTextColor:[UIColor blackColor]];
    [txtPhoneNumber setFont:[UIFont fontWithName:kRobotoRegular size:13]];
    [txtPhoneNumber setTextAlignment:NSTextAlignmentLeft];
    [txtPhoneNumber setDelegate:self];
    [txtPhoneNumber setText:@"9176732313"];
//    [txtPhoneNumber setKeyboardType:UIKeyboardTypeNumberPad];
    [scrlView addSubview:txtPhoneNumber];
    
    //GET STARTED BUTTON
    
    btnGetStarted = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnGetStarted setFrame:CGRectMake(32, lblLine2.frame.origin.y + lblLine2.frame.size.height + 30, width, 50)];
    [btnGetStarted setTitle:@"Get Started" forState:UIControlStateNormal];
    [btnGetStarted.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [btnGetStarted setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnGetStarted.layer setCornerRadius:25.0];
    [btnGetStarted setClipsToBounds:YES];
    [btnGetStarted setBackgroundColor:[UIColor colorWithRed:153.0/255.0 green:63.0/255.0 blue:233.0/255.0 alpha:1.0]];
    [btnGetStarted addTarget:self action:@selector(getStartedTap) forControlEvents:UIControlEventTouchUpInside];
    [scrlView addSubview:btnGetStarted];
    
    //BOTTOM
    
    lbl3 = [[UILabel alloc] init];
    [lbl3 setFrame:CGRectMake(32, btnGetStarted.frame.origin.y + btnGetStarted.frame.size.height + 100, width, 15)];
    [lbl3 setText:@"WeeServ will send a one time sms message"];
    [lbl3 setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lbl3 setTextColor:[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]];
    [lbl3 setTextAlignment:NSTextAlignmentCenter];
    [scrlView addSubview:lbl3];
    
    lbl4 = [[UILabel alloc] init];
    [lbl4 setFrame:CGRectMake(32, btnGetStarted.frame.origin.y + btnGetStarted.frame.size.height + 118, width, 15)];
    [lbl4 setText:@"to verify your phone number"];
    [lbl4 setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lbl4 setTextColor:[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]];
    [lbl4 setTextAlignment:NSTextAlignmentCenter];
    [scrlView addSubview:lbl4];
}


#pragma mark - GET STARTED TAPPED

- (IBAction)getStartedTap
{
    if ([[txtPhoneNumber text] length] == 10)
    {
        [txtPhoneNumber resignFirstResponder];
        
        [[GlobalResourcesViewController sharedManager] setPhoneNumber:txtPhoneNumber.text];
        
        NSString *stringURL = [NSString stringWithFormat:@"%@/account/ValidateUsername",kServerUrl];
        
        NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
        [dictRequest setObject:txtPhoneNumber.text forKey:kmobileno];
        
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
                                              NSLog(@"Validate User name  Response %@", responseDict);
                                              
                                              if ([[responseDict allKeys] containsObject:@"user"])
                                              {
                                                  NSDictionary *response = [responseDict objectForKey:@"user"];
                                                  
                                                  if ([[response allKeys] count] > 0)
                                                  {
                                                      if ([[response objectForKey:@"status"] isEqualToString:@"success"])
                                                      {
//                                                          NSNumber *number = [response objectForKey:kauth_code];
                                                          [[GlobalResourcesViewController sharedManager] setAuth_code:[response objectForKey:kauth_code]];
                                                          [[GlobalResourcesViewController sharedManager] setLoginStatus:[response objectForKey:@"status"]];
                                                          
                                                          dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                              [self performSegueWithIdentifier:@"verifyPin" sender:nil];
                                                          });
                                                          
                                                      }
                                                      else if ([[response objectForKey:@"status"] isEqualToString:@"exists"])
                                                      {
                                                          [[GlobalResourcesViewController sharedManager] setLoginStatus:[response objectForKey:@"status"]];
                                                          
                                                          dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                              [self forgetPwdCall];
                                                          });
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
        [[GlobalResourcesViewController sharedManager] showMessage:@"Please enter valid phone number" withTitle:@"Invalid"];
    }
}

- (void)forgetPwdCall
{
    [[GlobalResourcesViewController sharedManager] setPhoneNumber:txtPhoneNumber.text];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@/account/ForgotPassword",kServerUrl];
    
    NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
    [dictRequest setObject:txtPhoneNumber.text forKey:kmobileno];
    
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
                                          NSLog(@"Forgot Pwd  Response %@", responseDict);
                                          
                                          if ([[responseDict allKeys] containsObject:@"user"])
                                          {
                                              NSDictionary *response = [responseDict objectForKey:@"user"];
                                              
                                              if ([[response allKeys] count] > 0)
                                              {
                                                  if ([[response objectForKey:@"status"] isEqualToString:@"success"])
                                                  {
//                                                      NSNumber *number = [response objectForKey:kauth_code];
                                                      [[GlobalResourcesViewController sharedManager] setAuth_code:[response objectForKey:kauth_code]];
                                                      
                                                      dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                          [self performSegueWithIdentifier:@"verifyPin" sender:nil];
                                                      });
                                                      
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

#pragma mark - TEXTFILED DELEGATES

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 10;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
