//
//  VerifyCodeViewController.m
//  WeeServ
//
//  Created by saran c on 10/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "VerifyCodeViewController.h"
#import "GlobalResourcesViewController.h"

@interface VerifyCodeViewController ()

@end

@implementation VerifyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    [self setNavigationTitle];
    
    [self setupUI];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:18]];
    [navLabel1 setText:@"Verify number"];
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
    lblTextTop1 = [[UILabel alloc] init];
    [lblTextTop1 setFrame:CGRectMake(0, 40, viewWidth, 20)];
    [lblTextTop1 setText:@"We sent you text!"];
    [lblTextTop1 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [lblTextTop1 setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    [lblTextTop1 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTextTop1];
    
    lblTextTop2 = [[UILabel alloc] init];
    [lblTextTop2 setFrame:CGRectMake(0, 60, viewWidth, 20)];
    [lblTextTop2 setText:@"Enter the 4 digit code below"];
    [lblTextTop2 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [lblTextTop2 setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    [lblTextTop2 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTextTop2];
    
    lblLineTop = [[UILabel alloc] init];
    [lblLineTop setFrame:CGRectMake(0, lblTextTop2.frame.origin.y + lblTextTop2.frame.size.height + 40, viewWidth, 1)];
    [lblLineTop setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [self.view addSubview:lblLineTop];
    
    lblLineBottom = [[UILabel alloc] init];
    [lblLineBottom setFrame:CGRectMake(0, lblLineTop.frame.origin.y + lblLineTop.frame.size.height + 85, viewWidth, 1)];
    [lblLineBottom setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [self.view addSubview:lblLineBottom];
    
    int xPos = viewWidth/2 - 110;
    
    lblOne = [[UILabel alloc] init];
    [lblOne setFrame:CGRectMake(xPos, lblLineTop.frame.origin.y + lblLineTop.frame.size.height + 20, 42, 42)];
    [lblOne setText:@"-"];
    [lblOne setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblOne setTextColor:[UIColor blackColor]];
    [lblOne setTextAlignment:NSTextAlignmentCenter];
    [lblOne.layer setBorderWidth:1.0];
    [lblOne.layer setBorderColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0].CGColor];
    [lblOne.layer setCornerRadius:21];
    [lblOne.layer setMasksToBounds:YES];
    [self.view addSubview:lblOne];
    
    lblTwo = [[UILabel alloc] init];
    [lblTwo setFrame:CGRectMake(lblOne.frame.origin.x + lblOne.frame.size.width + 12, lblLineTop.frame.origin.y + lblLineTop.frame.size.height + 20, 42, 42)];
    [lblTwo setText:@"-"];
    [lblTwo setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblTwo setTextColor:[UIColor blackColor]];
    [lblTwo setTextAlignment:NSTextAlignmentCenter];
    [lblTwo.layer setBorderWidth:1.0];
    [lblTwo.layer setBorderColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0].CGColor];
    [lblTwo.layer setCornerRadius:21];
    [lblTwo.layer setMasksToBounds:YES];
    [self.view addSubview:lblTwo];
    
    lblThree = [[UILabel alloc] init];
    [lblThree setFrame:CGRectMake(lblTwo.frame.origin.x + lblTwo.frame.size.width + 12, lblLineTop.frame.origin.y + lblLineTop.frame.size.height + 20, 42, 42)];
    [lblThree setText:@"-"];
    [lblThree setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblThree setTextColor:[UIColor blackColor]];
    [lblThree setTextAlignment:NSTextAlignmentCenter];
    [lblThree.layer setBorderWidth:1.0];
    [lblThree.layer setBorderColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0].CGColor];
    [lblThree.layer setCornerRadius:21];
    [lblThree.layer setMasksToBounds:YES];
    [self.view addSubview:lblThree];
    
    lblFour = [[UILabel alloc] init];
    [lblFour setFrame:CGRectMake(lblThree.frame.origin.x + lblThree.frame.size.width + 12, lblLineTop.frame.origin.y + lblLineTop.frame.size.height + 20, 42, 42)];
    [lblFour setText:@"-"];
    [lblFour setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblFour setTextColor:[UIColor blackColor]];
    [lblFour setTextAlignment:NSTextAlignmentCenter];
    [lblFour.layer setBorderWidth:1.0];
    [lblFour.layer setBorderColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0].CGColor];
    [lblFour.layer setCornerRadius:21];
    [lblFour.layer setMasksToBounds:YES];
    [self.view addSubview:lblFour];
    
    lblTextBelow = [[UILabel alloc] init];
    [lblTextBelow setFrame:CGRectMake(0, lblLineBottom.frame.origin.y + lblLineBottom.frame.size.height + 25, viewWidth, 20)];
    [lblTextBelow setText:@"Please wait at least 1 minute for your code"];
    [lblTextBelow setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblTextBelow setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    [lblTextBelow setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblTextBelow];
    
    lblText = [[UILabel alloc] init];
    [lblText setFrame:CGRectMake(viewWidth/2 - 140, lblTextBelow.frame.origin.y + lblTextBelow.frame.size.height + 40, 140, 25)];
    [lblText setText:@"Didn't get a code?"];
    [lblText setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [lblText setTextColor:[UIColor blackColor]];
    [lblText setTextAlignment:NSTextAlignmentCenter];
    [lblText setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lblText];
    
    btnResend = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnResend setFrame:CGRectMake(viewWidth/2 - 5, lblTextBelow.frame.origin.y + lblTextBelow.frame.size.height + 40, 150, 25)];
    [btnResend setTitle:@"Click here to resend" forState:UIControlStateNormal];
    [btnResend.titleLabel setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [btnResend setBackgroundColor:[UIColor clearColor]];
    [btnResend setTitleColor:[UIColor colorWithRed:150.0/255.0 green:56.0/255.0 blue:242.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnResend addTarget:self action:@selector(btnResend) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnResend];
    
    txtCode = [[UITextField alloc] init];
    [txtCode setFrame:CGRectMake(0, self.view.frame.size.height - 40, 100, 35)];
    [txtCode setHidden:YES];
    [txtCode setDelegate:self];
    [txtCode becomeFirstResponder];
    [self.view addSubview:txtCode];
}

#pragma mark - TEXTFILED DELEGATES

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    
    NSString *str = [textField.text stringByReplacingCharactersInRange:range
                                                             withString:string];
    
    if (str.length == 4)
    {
        NSString *theCharacter1 = [NSString stringWithFormat:@"%c", [str characterAtIndex:0]];
        NSString *theCharacter2 = [NSString stringWithFormat:@"%c", [str characterAtIndex:1]];
        NSString *theCharacter3 = [NSString stringWithFormat:@"%c", [str characterAtIndex:2]];
        NSString *theCharacter4 = [NSString stringWithFormat:@"%c", [str characterAtIndex:3]];
        
        [lblOne     setText:theCharacter1];
        [lblTwo     setText:theCharacter2];
        [lblThree   setText:theCharacter3];
        [lblFour    setText:theCharacter4];
    }
    else if (str.length == 3)
    {
        NSString *theCharacter1 = [NSString stringWithFormat:@"%c", [str characterAtIndex:0]];
        NSString *theCharacter2 = [NSString stringWithFormat:@"%c", [str characterAtIndex:1]];
        NSString *theCharacter3 = [NSString stringWithFormat:@"%c", [str characterAtIndex:2]];
        
        [lblOne     setText:theCharacter1];
        [lblTwo     setText:theCharacter2];
        [lblThree   setText:theCharacter3];
        [lblFour    setText:@"-"];
      }
    else if (str.length == 2)
    {
        NSString *theCharacter1 = [NSString stringWithFormat:@"%c", [str characterAtIndex:0]];
        NSString *theCharacter2 = [NSString stringWithFormat:@"%c", [str characterAtIndex:1]];
        
        [lblOne     setText:theCharacter1];
        [lblTwo     setText:theCharacter2];
        [lblThree   setText:@"-"];
        [lblFour    setText:@"-"];
    }
    else if (str.length == 1)
    {
        NSString *theCharacter1 = [NSString stringWithFormat:@"%c", [str characterAtIndex:0]];
        
        [lblOne     setText:theCharacter1];
        [lblTwo     setText:@"-"];
        [lblThree   setText:@"-"];
        [lblFour    setText:@"-"];
    }
    else if (str.length == 0)
    {
        [lblOne     setText:@"-"];
        [lblTwo     setText:@"-"];
        [lblThree   setText:@"-"];
        [lblFour    setText:@"-"];
    }
    
    
    
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSString *auth_code = [[GlobalResourcesViewController sharedManager] auth_code];
    
    if ([str length] == 4)
    {
        if ([str isEqualToString:auth_code])
        {
            NSString *loginStatus = [[GlobalResourcesViewController sharedManager] loginStatus];
            
            if ([loginStatus isEqualToString:@"success"])
            {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    [self registerService];
                });
            }
            else if ([loginStatus isEqualToString:@"exists"])
            {
                [self performSegueWithIdentifier:@"profileInfo" sender:nil];
            }
        }
        else
        {
            [[GlobalResourcesViewController sharedManager] showMessage:@"Invaid code" withTitle:nil];
        }
    }
    
    
    return newLength <= 4;
}

#pragma mark - REGISTER SERVICE

- (void)registerService
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/account/Register",kServerUrl];
    
    NSString *phoneNumber = [NSString stringWithFormat:@"%@",[[GlobalResourcesViewController sharedManager] phoneNumber]];
    NSString *passCode = [[GlobalResourcesViewController sharedManager] auth_code];
    
//    NSNumber *authCode = @([passCode intValue]);;
    NSNumber *roleId = [NSNumber numberWithInteger:4];
    NSNumber *countryId = [NSNumber numberWithInteger:104];
    
    NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
    [dictRequest setObject:phoneNumber forKey:kname];
    [dictRequest setObject:phoneNumber forKey:kmobileno];
    [dictRequest setObject:@"" forKey:kemail];
    [dictRequest setObject:passCode forKey:kpassword];
    [dictRequest setObject:roleId forKey:krole];
    [dictRequest setObject:countryId forKey:kcountry_id];
    
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
                                          NSLog(@"Register  Response %@", responseDict);
                                          
                                          if ([[responseDict allKeys] containsObject:@"user"])
                                          {
                                              NSDictionary *response = [responseDict objectForKey:@"user"];
                                              
                                              if ([[response allKeys] count] > 0)
                                              {
                                                  if ([[response objectForKey:@"status"] isEqualToString:@"success"])
                                                  {
                                                      [self performSegueWithIdentifier:@"profileInfo" sender:nil];
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

#pragma mark - RESEND

- (IBAction)btnResend
{
    NSString *loginStatus = [[GlobalResourcesViewController sharedManager] loginStatus];
    
    NSString *phoneNumber = [[GlobalResourcesViewController sharedManager] phoneNumber];
    
    if ([loginStatus isEqualToString:@"success"])
    {
        NSString *stringURL = [NSString stringWithFormat:@"%@/account/ValidateUsername",kServerUrl];
        
        NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
        [dictRequest setObject:phoneNumber forKey:kmobileno];
        
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
                                                          
                                                      }
                                                      else if ([[response objectForKey:@"status"] isEqualToString:@"exists"])
                                                      {
                                                          [[GlobalResourcesViewController sharedManager] setLoginStatus:[response objectForKey:@"status"]];
                                                          [self forgetPwdCall];
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
    else if ([loginStatus isEqualToString:@"exists"])
    {
        [self forgetPwdCall];
    }
}

- (void)forgetPwdCall
{
    NSString *phoneNumber = [[GlobalResourcesViewController sharedManager] phoneNumber];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@/account/ForgotPassword",kServerUrl];
    
    NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
    [dictRequest setObject:phoneNumber forKey:kmobileno];
    
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
                                                      [[GlobalResourcesViewController sharedManager] setAuth_code:[response objectForKey:kauth_code]];
                                                      [[GlobalResourcesViewController sharedManager] setLoginStatus:[response objectForKey:@"status"]];
                                                      
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
