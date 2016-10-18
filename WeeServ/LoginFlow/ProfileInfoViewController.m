//
//  ProfileInfoViewController.m
//  WeeServ
//
//  Created by saran c on 08/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "ProfileInfoViewController.h"
#import "GlobalResourcesViewController.h"

@interface ProfileInfoViewController ()

@end

@implementation ProfileInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setHidesBackButton:YES];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self setNavigationTitle];
    [self setupUI];
    
    [self getAccessToken];
    
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 250, 44)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:18]];
    [navLabel1 setText:@"Profile Info"];
    [navLabel1 setTextColor:[UIColor whiteColor]];
    [navLabel1 setTextAlignment:NSTextAlignmentLeft];
    [navLabel1 setBackgroundColor:[UIColor clearColor]];
    [viewNav addSubview:navLabel1];
    
    self.navigationItem.titleView = viewNav;
    
    /*UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back-icon.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnBackClick)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 44 ,44)];
    UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:sidebarButton];*/
}

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SETUP UI

- (void)setupUI
{
    scrlView = [[UIScrollView alloc] init];
    [scrlView setFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [self.view addSubview:scrlView];
    
    lblText = [[UILabel alloc] init];
    [lblText setFrame:CGRectMake(20, 20, viewWidth - 40, 50)];
    [lblText setText:@"Please provide your name and an optional profile photo"];
    [lblText setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblText setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    [lblText setNumberOfLines:2];
    [lblText setLineBreakMode:NSLineBreakByWordWrapping];
    [scrlView addSubview:lblText];
    
    imgProfile = [[UIImageView alloc] init];
    [imgProfile setFrame:CGRectMake(viewWidth/2 - 45, lblText.frame.origin.y + lblText.frame.size.height + 20, 90, 90)];
    [imgProfile setImage:[UIImage imageNamed:@"profile_pic_default"]];
    [imgProfile.layer setBorderColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0].CGColor];
    [imgProfile.layer setBorderWidth:1.5];
    [imgProfile.layer setCornerRadius:45.0];
    [imgProfile.layer setMasksToBounds:YES];
    [imgProfile setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]];
    [scrlView addSubview:imgProfile];
    
    UIImageView *imgUpload = [[UIImageView alloc] init];
    [imgUpload setFrame:CGRectMake(imgProfile.frame.origin.x + imgProfile.frame.size.width - 30, imgProfile.frame.origin.y + imgProfile.frame.size.height - 30, 30, 30)];
    [imgUpload setImage:[UIImage imageNamed:@"profile_upload"]];
    [imgUpload.layer setBorderColor:[UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:1.0].CGColor];
    [imgUpload.layer setBorderWidth:1.5];
    [imgUpload.layer setCornerRadius:15.0];
    [imgUpload.layer setMasksToBounds:YES];
    [imgUpload setBackgroundColor:[UIColor whiteColor]];
    [scrlView addSubview:imgUpload];
    
    uploadPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadPhoto setFrame:imgProfile.frame];
    [uploadPhoto addTarget:self action:@selector(uploadProfilePhoto) forControlEvents:UIControlEventTouchUpInside];
    [scrlView addSubview:uploadPhoto];
    
    txtName = [[UITextField alloc] init];
    [txtName setFrame:CGRectMake(20, imgProfile.frame.origin.y + imgProfile.frame.size.height + 35, viewWidth - 40, 30)];
    [txtName setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [txtName setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    [txtName setPlaceholder:@"Enter name"];
    [txtName setDelegate:self];
    [scrlView addSubview:txtName];
    
    lblLine = [[UILabel alloc] init];
    [lblLine setFrame:CGRectMake(20, txtName.frame.origin.y + txtName.frame.size.height + 5, viewWidth - 40, 2)];
    [lblLine setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [scrlView addSubview:lblLine];
    
    txtEmail = [[UITextField alloc] init];
    [txtEmail setFrame:CGRectMake(20, lblLine.frame.origin.y + lblLine.frame.size.height + 20, viewWidth - 40, 30)];
    [txtEmail setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [txtEmail setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    [txtEmail setPlaceholder:@"Enter email"];
    [txtEmail setDelegate:self];
    [scrlView addSubview:txtEmail];
    
    lblLine2 = [[UILabel alloc] init];
    [lblLine2 setFrame:CGRectMake(20, txtEmail.frame.origin.y + txtEmail.frame.size.height + 5, viewWidth - 40, 2)];
    [lblLine2 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [scrlView addSubview:lblLine2];
    
    btnUpdate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnUpdate setFrame:CGRectMake(20, txtEmail.frame.origin.y + txtEmail.frame.size.height + 35, viewWidth - 40, 44)];
    [btnUpdate setTitle:@"Update" forState:UIControlStateNormal];
    [btnUpdate.titleLabel setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [btnUpdate setTitleColor:[UIColor colorWithRed:150.0/255.0 green:56.0/255.0 blue:242.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnUpdate.layer setBorderWidth:1.0];
    [btnUpdate.layer setBorderColor:[UIColor colorWithRed:150.0/255.0 green:56.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor];
    [btnUpdate addTarget:self action:@selector(updateClick) forControlEvents:UIControlEventTouchUpInside];
    
    [scrlView addSubview:btnUpdate];
    
    txtName.text = @"Srinivas";
    txtEmail.text = @"srineey@gmail.com";
}

#pragma mark - GET ACCESS TOKEN

- (void)getAccessToken
{
    NSString *stringURL = [NSString stringWithFormat:@"http://api.weeserv.com/token"];
    
    NSString *rawPayload = [NSString stringWithFormat:@"username=%@&password=%@&grant_type=password",[[GlobalResourcesViewController sharedManager] phoneNumber], [[GlobalResourcesViewController sharedManager] auth_code]];
    
    NSData *JSONData = [rawPayload dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]];
    [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
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
                                          NSLog(@"Token Response %@", responseDict);
                                          
                                          if ([[responseDict allKeys] containsObject:@"access_token"])
                                          {
                                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                  [[GlobalResourcesViewController sharedManager] saveLoginDetails:responseDict];
                                              });
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

#pragma mark - UPDATE CLICK

- (void)updateClick
{
    if ([[txtName text] length] == 0)
    {
        [[GlobalResourcesViewController sharedManager] showMessage:@"Please enter your name" withTitle:@"Mandatory"];
    }
    else if ([[txtEmail text] length] == 0)
    {
        [[GlobalResourcesViewController sharedManager] showMessage:@"Please enter your email" withTitle:@"Mandatory"];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self updateNameService];
        });
    }
}

#pragma mark - SERVICE CALLS

- (void)updateNameService
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/manage/UpdateDisplayName",kServerUrl];
    
    NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
    [dictRequest setObject:txtName.text forKey:kname];
    
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dictRequest
                                                       options:0
                                                         error:nil];
    
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
                                          NSLog(@"Update name  Response %@", responseDict);
                                          
                                          if ([[responseDict allKeys] containsObject:@"user"])
                                          {
                                              NSDictionary *response = [responseDict objectForKey:@"user"];
                                              
                                              if ([[response allKeys] count] > 0)
                                              {
                                                  if ([[response objectForKey:@"status"] isEqualToString:@"success"])
                                                  {
                                                      [[GlobalResourcesViewController sharedManager] setStrName:txtName.text];
                                                      dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                          [self updateEmailService];
                                                      });
                                                  }
                                                  else
                                                  {
                                                      [[GlobalResourcesViewController sharedManager] showMessage:@"Profile update failed" withTitle:@"Error"];
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

- (void)updateEmailService
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/manage/UpdateEmail",kServerUrl];
    
    NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
    [dictRequest setObject:txtEmail.text forKey:kemail];
    
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dictRequest
                                                       options:0
                                                         error:nil];
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
                                          NSLog(@"Update Email Response %@", responseDict);
                                          
                                          if ([[responseDict allKeys] containsObject:@"user"])
                                          {
                                              NSDictionary *response = [responseDict objectForKey:@"user"];
                                              
                                              if ([[response allKeys] count] > 0)
                                              {
                                                  if ([[response objectForKey:@"status"] isEqualToString:@"success"])
                                                  {
                                                      [[GlobalResourcesViewController sharedManager] setStrEmail:txtEmail.text];
                                                      
                                                      dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                           [self performSegueWithIdentifier:@"goHome" sender:nil];
                                                      });

//                                                      dispatch_async(dispatch_get_main_queue(), ^(void) {
//                                                          [self updateProfilePhoto];
//                                                      });
                                                  }
                                                  else
                                                  {
                                                      [[GlobalResourcesViewController sharedManager] showMessage:@"Profile update failed" withTitle:@"Error"];
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

- (void)updateProfilePhoto
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/manage/UploadProfilePhoto",kServerUrl];
    
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@ ",[userDefaults objectForKey:kaccess_token]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]];
    [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [request addValue:accessToken forHTTPHeaderField:@"Authorization"];
    request.HTTPMethod = @"POST";
    request.HTTPBody = dataImage;
    
    // Create a task.
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data,
                                                                                     NSURLResponse *response,
                                                                                     NSError *error)
                                  {
                                      if (!error)
                                      {
                                          NSDictionary *responseDict   =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          NSLog(@"Update Photo Response %@", responseDict);
                                          
                                          if ([[responseDict allKeys] containsObject:@"user"])
                                          {
                                              NSDictionary *response = [responseDict objectForKey:@"user"];
                                              
                                              if ([[response allKeys] count] > 0)
                                              {
                                                  if ([[response objectForKey:@"status"] isEqualToString:@"success"])
                                                  {
                                                      [[GlobalResourcesViewController sharedManager] showMessage:@"Your profile updated successfully" withTitle:@"Success"];
                                                  }
                                                  else
                                                  {
                                                      [[GlobalResourcesViewController sharedManager] showMessage:@"Profile update failed" withTitle:@"Error"];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UPLOAD PHOTO

- (IBAction)uploadProfilePhoto
{
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    imgProfile.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    dataImage = UIImagePNGRepresentation(imgProfile.image);
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
