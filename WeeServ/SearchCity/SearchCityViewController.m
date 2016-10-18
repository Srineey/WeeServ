//
//  SearchCityViewController.m
//  WeeServ
//
//  Created by saran c on 17/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "SearchCityViewController.h"
#import "GlobalResourcesViewController.h"
#import "GMDCircleLoader.h"

@interface SearchCityViewController ()
{
    PopularCitiesView *populatCitiesView;
}
@end

@implementation SearchCityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    [self setNavigationTitle];
    
    scrlView = [[UIScrollView alloc] init];
    [scrlView setFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [scrlView setBackgroundColor:[UIColor clearColor]];
    [scrlView setShowsHorizontalScrollIndicator:NO];
    [scrlView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:scrlView];
    
    [self setUserCurrentCityView];
    
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
    
    [self locationsServiceRequest];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:20.0]];
    [navLabel1 setText:@"Select a city"];
    [navLabel1 setTextColor:[UIColor whiteColor]];
    [navLabel1 setTextAlignment:NSTextAlignmentLeft];
    [navLabel1 setBackgroundColor:[UIColor clearColor]];
    [viewNav addSubview:navLabel1];
    
    self.navigationItem.titleView = viewNav;
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnCancelClick)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 44 ,44)];
    UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.navigationItem setLeftBarButtonItem:sidebarButton];
}

#pragma mark - USE CURRENT CITY VIEW

- (void)setUserCurrentCityView
{
    UIView *currentCityView = [[UIView alloc] init];
    [currentCityView setFrame:CGRectMake(0, 0, viewWidth, 50)];
    [currentCityView setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:56.0/255.0 blue:242.0/255.0 alpha:0.8]];
    [scrlView addSubview:currentCityView];
    
    UIImageView *location_indicator = [[UIImageView alloc] init];
    [location_indicator setFrame:CGRectMake(18, 11, 28, 28)];
    [location_indicator setBackgroundColor:[UIColor clearColor]];
    [location_indicator setImage:[UIImage imageNamed:@"current_location_white"]];
    [currentCityView addSubview:location_indicator];
    
    UILabel *lblCurrentLocation = [[UILabel alloc] init];
    [lblCurrentLocation setFrame:CGRectMake(65, 0, 200, 50)];
    [lblCurrentLocation setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.7]];
    [lblCurrentLocation setTextAlignment:NSTextAlignmentLeft];
    [lblCurrentLocation setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblCurrentLocation setText:@"Use my current city"];
    [currentCityView addSubview:lblCurrentLocation];
    
    UIImageView *arrowIndicatorImg = [[UIImageView alloc] init];
    [arrowIndicatorImg setFrame:CGRectMake(viewWidth - 35, 14, 24, 24)];
    [arrowIndicatorImg setImage:[UIImage imageNamed:@"arrow_right"]];
    [currentCityView addSubview:arrowIndicatorImg];
}

#pragma mark - GET LOCATIONS SERVICE

- (void)locationsServiceRequest
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/services/Location/%@",kServerUrl,[[GlobalResourcesViewController sharedManager] default_country]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:stringURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error == nil)
                {
                    NSDictionary *responseDict   =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSLog(@"Location Service List %@", responseDict);
                    
//                    [[GlobalResourcesViewController sharedManager] setDictCategories:responseDict];
                    
//                    NSLog(@"DictCategories %@",[[GlobalResourcesViewController sharedManager] dictCategories]);
                    
                    if ([[responseDict allKeys] count] > 0)
                    {
                        aryLocationsList = [responseDict objectForKey:@"locations"];
                        NSMutableArray *popularCitiesAry = [NSMutableArray array];
                        
                        if ([aryLocationsList count] > 0)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^(void) {
                                
                                [GMDCircleLoader hideFromView:self.view animated:YES];
                                
                                for (int i=0; i < [aryLocationsList count]; i++)
                                {
                                    NSDictionary *locationDict = [aryLocationsList objectAtIndex:i];
                                    
                                    if ([[locationDict allKeys] containsObject:@"popularcities"])
                                    {
                                        if ([[locationDict objectForKey:@"popularcities"] boolValue])
                                        {
                                            [popularCitiesAry addObject:locationDict];
                                        }
                                    }
                                }
                                
                                if ([popularCitiesAry count] > 4)
                                {
                                    populatCitiesView = [[PopularCitiesView alloc] initWithFrame:CGRectMake(0, 50, viewWidth, 275)];
                                }
                                else
                                {
                                    populatCitiesView = [[PopularCitiesView alloc] initWithFrame:CGRectMake(0, 50, viewWidth, 160)];
                                }
                                
                                [populatCitiesView popularCitiesList:popularCitiesAry];
                                populatCitiesView.delegate = self;
                               
                                [scrlView addSubview:populatCitiesView];
                                
                                int yPos = populatCitiesView.frame.origin.y + populatCitiesView.frame.size.height;
                                
                                [self createCitiesTable:yPos];

                            });
                            
                        }
                    }
                }
                
            }] resume];
}

#pragma mark - CANCEL CLICK

- (void)btnCancelClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CREATE TABLEVIEW

- (void)createCitiesTable:(int)yPos
{
    tblViewCities = [[UITableView alloc]initWithFrame:CGRectMake(0, yPos , viewWidth, viewHeight - yPos - 64) style:UITableViewStylePlain];
    [tblViewCities setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:56.0/255.0 blue:242.0/255.0 alpha:0.8]];
    [tblViewCities setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tblViewCities setShowsVerticalScrollIndicator:NO];
    [scrlView addSubview:tblViewCities];
    
    [tblViewCities setDelegate:self];
    [tblViewCities setDataSource:self];
}

#pragma mark - tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 40)];
    [view setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:56.0/255.0 blue:242.0/255.0 alpha:0.5]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, viewWidth - 80, 40)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    [label setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.7]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [label setText:@"ALL CITIES"];
   
    UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSearch setFrame:CGRectMake(viewWidth - 50, 0, 40, 40)];
    [btnSearch setBackgroundColor:[UIColor clearColor]];
    [btnSearch setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    //        [btnCity addTarget:self action:@selector(seeAllCategories:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btnSearch];
    [view addSubview:label];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aryLocationsList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *cityName;
    
    NSDictionary *dictCitiesList = [aryLocationsList objectAtIndex:indexPath.row];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setAccessoryView:nil];
        
        cityName = [[UILabel alloc] init];
        [cityName setFrame:CGRectMake(18, 0, viewWidth - 20, 44)];
        [cityName setTag:1];
        [cityName setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.7]];
        [cityName setBackgroundColor:[UIColor clearColor]];
        [cityName setFont:[UIFont fontWithName:kRobotoRegular size:14]];
        [cell.contentView addSubview:cityName];
    }
    else
    {
        cityName = (UILabel *)[cell.contentView viewWithTag:1];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cityName setText:[dictCitiesList objectForKey:@"name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictCities = [aryLocationsList objectAtIndex:indexPath.row];
    
    [[GlobalResourcesViewController sharedManager] setSelectedCityName:[dictCities objectForKey:@"name"]];
    [[GlobalResourcesViewController sharedManager] setSelectedCityId:[dictCities objectForKey:@"id"]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CitySelected" object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - POPULAR CITY SELECTED DELEGATE

- (void)seletedPopularCityDelegate
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CitySelected" object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
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
