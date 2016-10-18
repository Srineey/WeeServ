//
//  SelectedCategoryListViewController.m
//  WeeServ
//
//  Created by saran c on 09/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "SelectedCategoryListViewController.h"
#import "GlobalResourcesViewController.h"
#import "UIImageView+WebCache.h"

@interface SelectedCategoryListViewController ()

@end

@implementation SelectedCategoryListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dictCategory = [[GlobalResourcesViewController sharedManager] selectedService];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    [self setNavigationTitle];
    [self setNavigationBarButtons];
    
    aryCategories = [dictCategory objectForKey:@"category"];
    
    aryDisplayCategories = [aryCategories mutableCopy];
    
    aryFilteredCategories = [NSMutableArray array];
    
    if ([aryCategories count] > 0)
    {
        categoryListTable = [[UITableView alloc] init];
        [categoryListTable setFrame:CGRectMake(0, 0, viewWidth, viewHeight - 64)];
        [categoryListTable setDelegate:self];
        [categoryListTable setDataSource:self];
        [categoryListTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:categoryListTable];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    NSString *serviceName = [dictCategory objectForKey:@"name"];
    
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:18]];
    [navLabel1 setText:[serviceName uppercaseString]];
    [navLabel1 setTextColor:[UIColor whiteColor]];
    [navLabel1 setTextAlignment:NSTextAlignmentLeft];
    [navLabel1 setBackgroundColor:[UIColor clearColor]];
    [viewNav addSubview:navLabel1];
    
    self.navigationItem.titleView = viewNav;
}

- (void)setNavigationBarButtons
{
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back-icon.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnBackClick)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 44 ,44)];
    UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton *searchButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(btnSearchClick)forControlEvents:UIControlEventTouchUpInside];
    [searchButton setFrame:CGRectMake(0, 0, 44 ,44)];
    UIBarButtonItem *sidebarButtonSearch = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    [self.navigationItem setLeftBarButtonItem:sidebarButton];
    [self.navigationItem setRightBarButtonItem:sidebarButtonSearch];
}

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

- (void)btnSearchClick
{
    [self.navigationItem setLeftBarButtonItem:nil];
    [self.navigationItem setRightBarButtonItem:nil];
    [self.navigationItem setHidesBackButton:YES];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.active = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    [self.searchController.searchBar setShowsCancelButton:YES animated:YES];
    self.navigationItem.titleView = self.searchController.searchBar;
    
    // It is usually good to set the presentation context.
//    self.definesPresentationContext = YES;
    
}

// When the user types in the search bar, this method gets called.
- (void)updateSearchResultsForSearchController:(UISearchController *)aSearchController
{
    NSLog(@"updateSearchResultsForSearchController");
    
    NSString *searchString = aSearchController.searchBar.text;
    NSLog(@"searchString=%@", searchString);
    
    // Check if the user cancelled or deleted the search term so we can display the full list instead.
    if (![searchString isEqualToString:@""])
    {
        [aryFilteredCategories removeAllObjects];
        
        for (NSDictionary *dict in aryCategories)
        {
            NSString *str = [dict objectForKey:@"name"];
            
            if ([searchString isEqualToString:@""] || [str localizedCaseInsensitiveContainsString:searchString] == YES) {
                NSLog(@"str=%@", str);
                [aryFilteredCategories addObject:dict];
            }
        }
        aryDisplayCategories = aryFilteredCategories;
    }
    else
    {
        aryDisplayCategories = [aryCategories mutableCopy];
    }
    
    [categoryListTable reloadData];
}

#pragma mark - SEARCH BAR DELEGATE

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchController.searchBar removeFromSuperview];
    [self.searchController removeFromParentViewController];
    
    [self setNavigationTitle];
    [self setNavigationBarButtons];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [aryDisplayCategories count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lblCategoryName;
    UIImageView *imgCategory,*imgSeparatorLine;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *category = [aryDisplayCategories objectAtIndex:indexPath.row];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setAccessoryView:nil];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        NSString *stringUrl = [category objectForKey:@"icon"];
        
        imgCategory= [[UIImageView alloc]init];
        [imgCategory setFrame:CGRectMake(25,17,20,25)];
        [imgCategory setTag:4];
        [imgCategory sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"]];
        [cell.contentView addSubview:imgCategory];
        
        lblCategoryName = [[UILabel alloc]init];
        [lblCategoryName setFrame:CGRectMake(65, 1, viewWidth - 75,58)];
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
        imgCategory = (UIImageView *)[cell.contentView viewWithTag:4];
    }
    
    lblCategoryName.text = [category objectForKey:@"name"];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictSelectedCategory = [aryDisplayCategories objectAtIndex:indexPath.row];
    
    [[GlobalResourcesViewController sharedManager] setSelectedCategory:dictSelectedCategory];
   
    NSString *selectedCategoryId = [dictSelectedCategory objectForKey:@"id"];
    [GlobalResourcesViewController sharedManager].selectedCategoryId = selectedCategoryId;
    
    NSArray *subCategoryArray = [dictSelectedCategory objectForKey:@"subcategory"];
    NSArray *brandsArray = [dictSelectedCategory objectForKey:@"brands"];
    
    if ([subCategoryArray count] > 0)
    {
        NSLog(@"SUB CATEGORIES");
        [self performSegueWithIdentifier:@"ListToSubCategory" sender:nil];
    }
    else if ([brandsArray count] > 0)
    {
        NSLog(@"BRANDS");
        [self performSegueWithIdentifier:@"ListToBrand" sender:nil];
    }
    else
    {
        NSLog(@"BRAND TO LOCALE");
        [self performSegueWithIdentifier:@"CategoryToLocale" sender:nil];
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
