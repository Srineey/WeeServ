//
//  SelectBrandViewController.m
//  WeeServ
//
//  Created by saran c on 13/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "SelectBrandViewController.h"
#import "GlobalResourcesViewController.h"

@interface SelectBrandViewController ()

@end

@implementation SelectBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dictCategoryBrand = [[GlobalResourcesViewController sharedManager] selectedCategory];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    [self setNavigationTitle];
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back-icon.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnBackClick)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 44 ,44)];
    UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.navigationItem setLeftBarButtonItem:sidebarButton];
    
    aryBrandCategories = [dictCategoryBrand objectForKey:@"brands"];
    
    if ([aryBrandCategories count] > 0)
    {
        categoryBrandTable = [[UITableView alloc] init];
        [categoryBrandTable setFrame:CGRectMake(0, 0, viewWidth, viewHeight - 64)];
        [categoryBrandTable setDelegate:self];
        [categoryBrandTable setDataSource:self];
        [categoryBrandTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:categoryBrandTable];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
//    NSString *serviceName = [dictCategoryBrand objectForKey:@"name"];
    
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [navLabel1 setText:@"SELECT BRAND"];
    [navLabel1 setTextColor:[UIColor whiteColor]];
    [navLabel1 setTextAlignment:NSTextAlignmentLeft];
    [navLabel1 setBackgroundColor:[UIColor clearColor]];
    [viewNav addSubview:navLabel1];
    
//    UILabel *navLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 18)];
//    [navLabel2 setFont:[UIFont fontWithName:kRobotoRegular size:14]];
//    [navLabel2 setText:@"Brands"];
//    [navLabel2 setTextColor:[UIColor whiteColor]];
//    [navLabel2 setTextAlignment:NSTextAlignmentLeft];
//    [navLabel2 setBackgroundColor:[UIColor clearColor]];
//    [viewNav addSubview:navLabel2];
    
    self.navigationItem.titleView = viewNav;
}

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [aryBrandCategories count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lblCategoryName;
    UIImageView *imgSeparatorLine;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *category = [aryBrandCategories objectAtIndex:indexPath.row];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setAccessoryView:nil];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        lblCategoryName = [[UILabel alloc]init];
        [lblCategoryName setFrame:CGRectMake(25, 1, viewWidth - 50,58)];
        [lblCategoryName setTag:1];
        [lblCategoryName setFont:[UIFont fontWithName:kRobotoRegular size:16]];
        [lblCategoryName setBackgroundColor:[UIColor clearColor]];
        [lblCategoryName setTextColor:[UIColor blackColor]];
        [cell.contentView addSubview:lblCategoryName];
        
        imgSeparatorLine= [[UIImageView alloc]init];
        [imgSeparatorLine setFrame:CGRectMake(0,58,viewWidth,3)];
        [imgSeparatorLine setTag:3];
        [imgSeparatorLine setImage:[UIImage imageNamed:@"searchSepratorLine.png"]];
        [cell.contentView addSubview:imgSeparatorLine];
    }
    else
    {
        lblCategoryName = (UILabel *)[cell.contentView viewWithTag:1];
        imgSeparatorLine = (UIImageView *)[cell.contentView viewWithTag:3];
    }
    
    lblCategoryName.text = [category objectForKey:@"name"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"BRAND TO LOCALE");
    
    NSDictionary *category = [aryBrandCategories objectAtIndex:indexPath.row];
    NSString *selectedBrandId = [NSString stringWithFormat:@"%@",[category objectForKey:@"id"]];
    [[GlobalResourcesViewController sharedManager] setSelectedBrandId:selectedBrandId];
    
    [self performSegueWithIdentifier:@"BrandToLocale" sender:nil];
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
