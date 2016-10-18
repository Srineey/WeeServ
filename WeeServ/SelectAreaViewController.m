//
//  SelectAreaViewController.m
//  WeeServ
//
//  Created by saran c on 26/08/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "SelectAreaViewController.h"
#import "GlobalResourcesViewController.h"
#import "GMDCircleLoader.h"

@interface SelectAreaViewController ()

@end

@implementation SelectAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    aryFilteredAreaList = [NSMutableArray array];
    
    [self setNavigationTitle];
    [self setNavigationBarButtons];
    
    [self getAreaList];
    
    tblView = [[UITableView alloc] init];
    [tblView setFrame:CGRectMake(0, 0, viewWidth, viewHeight - 64)];
    [tblView setDelegate:self];
    [tblView setDataSource:self];
    [tblView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tblView];
    
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
    
    [[GlobalResourcesViewController sharedManager] setIsSelectedArea:NO];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:18]];
    [navLabel1 setText:@"Select area"];
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

#pragma mark - GET AREA LIST

- (void)getAreaList
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/localarea/%@",kServerUrl,[GlobalResourcesViewController sharedManager].selectedCityId];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:stringURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error == nil)
                {
                    NSDictionary *responseDict   =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSLog(@"Local Area List %@", responseDict);
                    
                    if ([[responseDict allKeys] count] > 0)
                    {
                        aryAreaList = [responseDict objectForKey:@"areas"];
                        
                        if ([aryAreaList count] > 0)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^(void) {
                                [GMDCircleLoader hideFromView:self.view animated:YES];
                                
                                [[GlobalResourcesViewController sharedManager] setIsSelectedArea:YES];
                                aryDisplayAreaList = [aryAreaList mutableCopy];
                                
                                [tblView reloadData];
                            });
                            
                        }
                    }
                }
                
            }] resume];
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
}


#pragma mark - SEARCH BAR DELEGATE

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchController.searchBar removeFromSuperview];
    [self.searchController removeFromParentViewController];
    
    [self setNavigationTitle];
    [self setNavigationBarButtons];
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
        [aryFilteredAreaList removeAllObjects];
        
        for (NSDictionary *dict in aryAreaList)
        {
            NSString *str = [dict objectForKey:@"name"];
            
            if ([searchString isEqualToString:@""] || [str localizedCaseInsensitiveContainsString:searchString] == YES) {
                [aryFilteredAreaList addObject:dict];
            }
        }
        aryDisplayAreaList = aryFilteredAreaList;
    }
    else
    {
        aryDisplayAreaList = [aryAreaList mutableCopy];
    }
    
    [tblView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [aryDisplayAreaList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lblCategoryName;
    UIImageView *imgSeparatorLine;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *category = [aryDisplayAreaList objectAtIndex:indexPath.row];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setAccessoryView:nil];
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        lblCategoryName = [[UILabel alloc]init];
        [lblCategoryName setFrame:CGRectMake(30, 1, viewWidth - 75,48)];
        [lblCategoryName setTag:1];
        [lblCategoryName setFont:[UIFont fontWithName:kRobotoRegular size:16]];
        [lblCategoryName setBackgroundColor:[UIColor clearColor]];
        [lblCategoryName setTextColor:[UIColor blackColor]];
        [cell.contentView addSubview:lblCategoryName];
        
        imgSeparatorLine= [[UIImageView alloc]init];
        [imgSeparatorLine setFrame:CGRectMake(0,48,viewWidth,3)];
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
    NSDictionary *dictDisplayAreaList = [aryDisplayAreaList objectAtIndex:indexPath.row];
    
    NSString *selectedAreaId = [dictDisplayAreaList objectForKey:@"id"];
    NSString *selectedAreaName = [dictDisplayAreaList objectForKey:@"name"];
    
    [GlobalResourcesViewController sharedManager].selectedAreaId = selectedAreaId;
    [GlobalResourcesViewController sharedManager].selectedAreaName = selectedAreaName;
    
    [self.navigationController popViewControllerAnimated:YES];
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
