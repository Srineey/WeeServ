//
//  SuggestionViewController.m
//  WeeServ
//
//  Created by saran c on 03/09/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "SuggestionViewController.h"
#import "GlobalResourcesViewController.h"

@interface SuggestionViewController ()

@end

@implementation SuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
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
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [navLabel1 setText:@"Suggestions"];
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
    UILabel *lblSuggest = [[UILabel alloc]init];
    [lblSuggest setFrame:CGRectMake(25, 20, viewWidth - 50,20)];
    [lblSuggest setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblSuggest setBackgroundColor:[UIColor clearColor]];
    [lblSuggest setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    [lblSuggest setText:@"Tell us any other details we should know"];
    [self.view addSubview:lblSuggest];
    
    UILabel *lblLine1 = [[UILabel alloc] init];
    [lblLine1 setFrame:CGRectMake(25, 150, viewWidth - 50, 1)];
    [lblLine1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [self.view addSubview:lblLine1];
    
    txtView = [[UITextView alloc] init];
    [txtView setFrame:CGRectMake(25, lblLine1.frame.origin.y - 30, viewWidth - 50, 30)];
    [txtView setBackgroundColor:[UIColor clearColor]];
    [txtView setEditable:YES];
//    [txtView setText:strDescription];
    [txtView setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [self.view addSubview:txtView];
    
    UIButton *acceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [acceptBtn setFrame:CGRectMake(25, lblLine1.frame.origin.y + 25, viewWidth - 50, 45)];
    [acceptBtn setTitle:@"Next" forState:UIControlStateNormal];
    [acceptBtn setBackgroundColor:kAppBgColor];
    [acceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [acceptBtn.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [acceptBtn addTarget:self action:@selector(nextClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:acceptBtn];
}

#pragma mark - TERMS AND CONDITIONS ACCEPT

- (void)nextClicked
{
    if ([txtView.text length] != 0)
    {
        [[GlobalResourcesViewController sharedManager] setEnteredSuggestion:txtView.text];
    }
    else
    {
        [[GlobalResourcesViewController sharedManager] setEnteredSuggestion:@""];
    }
    
    [self performSegueWithIdentifier:@"ConfirmationVC" sender:nil];
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
