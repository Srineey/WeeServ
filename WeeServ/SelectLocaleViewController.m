//
//  SelectLocaleViewController.m
//  WeeServ
//
//  Created by saran c on 19/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "SelectLocaleViewController.h"
#import "GlobalResourcesViewController.h"

@interface SelectLocaleViewController ()

@end

@implementation SelectLocaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setNavigationTitle];
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    txtPinCode.inputAccessoryView = keyboardDoneButtonView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLayoutSubviews
{
    [viewSubmit setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    CGRect frame = viewSubmit.frame;
    frame.size.height = 44;
    [viewSubmit setFrame:frame];
    [viewSubmit.layer setBorderColor:[UIColor colorWithRed:153.0/255.0 green:63.0/255.0 blue:233.0/255.0 alpha:1.0].CGColor];
    
    [viewUserLocation setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    frame = viewUserLocation.frame;
    frame.size.height = 44;
    [viewUserLocation setFrame:frame];
    [viewUserLocation.layer setBorderColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0].CGColor];
    
    [imgLocation setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    frame = imgLocation.frame;
    frame.size.width  = 24;
    frame.size.height = 24;
    [imgLocation setFrame:frame];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:18]];
    [navLabel1 setText:@"Select your locale"];
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

#pragma mark - DONE/SUBMIT CLICKED

- (IBAction)doneClicked:(id)sender
{
    txtPinCode.text = @"423432";
    
    if ([txtPinCode.text length] > 4)
    {
        [[GlobalResourcesViewController sharedManager] setPinCode:txtPinCode.text];
        [txtPinCode resignFirstResponder];
        
        [self performSegueWithIdentifier:@"TechnicianList" sender:nil];
    }
    else
    {
        [[GlobalResourcesViewController sharedManager] showMessage:@"Please enter valid pin code" withTitle:@"Invalid"];
    }
}

#pragma mark - USE CURRENT LOCATION

- (IBAction)useCurrentLocation:(id)sender
{
    
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
