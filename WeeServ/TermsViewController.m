//
//  TermsViewController.m
//  WeeServ
//
//  Created by saran c on 30/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "TermsViewController.h"
#import "GlobalResourcesViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    [self setNavigationTitle];
    
    [self setupUI];
    
    UIButton *acceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [acceptBtn setFrame:CGRectMake(0, viewHeight - 104, viewWidth, 40)];
    [acceptBtn setTitle:@"I Accept" forState:UIControlStateNormal];
    [acceptBtn setBackgroundColor:kAppBgColor];
    [acceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [acceptBtn.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [acceptBtn addTarget:self action:@selector(acceptBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:acceptBtn];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [navLabel1 setText:@"Terms and Conditions"];
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
    NSDictionary *selectedCategory = [[GlobalResourcesViewController sharedManager] selectedCategory];
    NSString *strDescription = [NSString stringWithFormat:@"%@",[[GlobalResourcesViewController sharedManager] checkForNull:[selectedCategory objectForKey:@"description"]]];
    
    UITextView *txtView = [[UITextView alloc] init];
    [txtView setFrame:CGRectMake(0, 10, viewWidth, viewHeight - 120)];
    [txtView setBackgroundColor:[UIColor clearColor]];
    [txtView setEditable:NO];
    [txtView setText:strDescription];
    [txtView setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [self.view addSubview:txtView];
}

#pragma mark - TERMS AND CONDITIONS ACCEPT 

- (void)acceptBtnClicked
{
    [self performSegueWithIdentifier:@"AddressList" sender:nil];
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
