//
//  TechnicianListViewController.m
//  WeeServ
//
//  Created by saran c on 19/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "TechnicianListViewController.h"
#import "GlobalResourcesViewController.h"
#import "UIImageView+WebCache.h"
#import "GMDCircleLoader.h"

@interface TechnicianListViewController ()

@end

@implementation TechnicianListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    technicianAry = [NSArray array];
    
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
    
    [self setNavigationTitle];
    
    [self createSortView];
    
    [self createTechniciansTable];
    
    [self techniciansListRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    NSString *cityName = [NSString stringWithFormat:@"%@",[GlobalResourcesViewController sharedManager].pinCode];
//
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    [navLabel1 setFont:[UIFont fontWithName:kRobotoMedium size:16]];
    [navLabel1 setText:cityName];
    [navLabel1 setTextColor:[UIColor whiteColor]];
    [navLabel1 setTextAlignment:NSTextAlignmentLeft];
    [navLabel1 setBackgroundColor:[UIColor clearColor]];
    [viewNav addSubview:navLabel1];
//
//    UILabel *navLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 18)];
//    [navLabel2 setFont:[UIFont fontWithName:kRobotoRegular size:14]];
//    [navLabel2 setText:@"Sub Categories"];
//    [navLabel2 setTextColor:[UIColor whiteColor]];
//    [navLabel2 setTextAlignment:NSTextAlignmentLeft];
//    [navLabel2 setBackgroundColor:[UIColor clearColor]];
//    [viewNav addSubview:navLabel2];
//    
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

#pragma mark - SORT VIEW

- (void)createSortView
{
    sortView = [[UIView alloc] init];
    [sortView setFrame:CGRectMake(0, 0, viewWidth, 44)];
    [sortView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:sortView];
    
    int subViewWidth = viewWidth/3;
    
    priceSortView = [[UIView alloc] init];
    [priceSortView setFrame:CGRectMake(0, 0, subViewWidth, 44)];
    [priceSortView setBackgroundColor:[UIColor clearColor]];
    [sortView addSubview:priceSortView];
    
    //PRICE
    
    lblPrice = [[UILabel alloc] init];
    [lblPrice setFrame:priceSortView.frame];
    [lblPrice setText:@"    Price"];
    [lblPrice setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblPrice setTextAlignment:NSTextAlignmentLeft];
    [lblPrice setTextColor:kSelectedFontColor];
    [lblPrice setBackgroundColor:[UIColor clearColor]];
    [sortView addSubview:lblPrice];
    
    imgArwPrice = [[UIImageView alloc] init];
    [imgArwPrice setFrame:CGRectMake(priceSortView.frame.size.width - 35, 11, 16, 22)];
    [imgArwPrice setImage:[UIImage imageNamed:@"sort-uparrow"]];
    [sortView addSubview:imgArwPrice];
    [imgArwPrice setHidden:NO];
    
    btnPriceSort = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPriceSort setFrame:priceSortView.frame];
    [btnPriceSort addTarget:self action:@selector(PriceSortTapped) forControlEvents:UIControlEventTouchUpInside];
    [sortView addSubview:btnPriceSort];
    
    UILabel *divideLine1 = [[UILabel alloc] init];
    [divideLine1 setFrame:CGRectMake(priceSortView.frame.size.width, 0, 2, 44)];
    [divideLine1 setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0]];
    [sortView addSubview:divideLine1];
    
    //RATE
    
    rateSortView = [[UIView alloc] init];
    [rateSortView setFrame:CGRectMake(divideLine1.frame.origin.x + divideLine1.frame.size.width, 0, subViewWidth, 44)];
    [rateSortView setBackgroundColor:[UIColor clearColor]];
    [sortView addSubview:rateSortView];
    
    lblRate = [[UILabel alloc] init];
    [lblRate setFrame:rateSortView.frame];
    [lblRate setText:@"    Rate"];
    [lblRate setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblRate setTextAlignment:NSTextAlignmentLeft];
    [lblRate setTextColor:[UIColor blackColor]];
    [lblRate setBackgroundColor:[UIColor clearColor]];
    [sortView addSubview:lblRate];
    
    imgArwRate = [[UIImageView alloc] init];
    [imgArwRate setFrame:CGRectMake(rateSortView.frame.size.width + rateSortView.frame.origin.x - 35, 11, 16, 22)];
    [imgArwRate setImage:[UIImage imageNamed:@"sort-uparrow"]];
    [sortView addSubview:imgArwRate];
    [imgArwRate setHidden:YES];
    
    btnRateSort = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRateSort setFrame:rateSortView.frame];
    [btnRateSort addTarget:self action:@selector(RateSortTapped) forControlEvents:UIControlEventTouchUpInside];
    [sortView addSubview:btnRateSort];
    
    UILabel *divideLine2 = [[UILabel alloc] init];
    [divideLine2 setFrame:CGRectMake(rateSortView.frame.size.width + rateSortView.frame.origin.x, 0, 2, 44)];
    [divideLine2 setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0]];
    [sortView addSubview:divideLine2];
    
    //DISTANCE
    
    distanceSortView = [[UIView alloc] init];
    [distanceSortView setFrame:CGRectMake(divideLine2.frame.origin.x + divideLine2.frame.size.width, 0, subViewWidth, 44)];
    [distanceSortView setBackgroundColor:[UIColor clearColor]];
    [sortView addSubview:distanceSortView];
    
    lblDistance = [[UILabel alloc] init];
    [lblDistance setFrame:distanceSortView.frame];
    [lblDistance setText:@"    KM"];
    [lblDistance setFont:[UIFont fontWithName:kRobotoRegular size:16]];
    [lblDistance setTextAlignment:NSTextAlignmentLeft];
    [lblDistance setTextColor:[UIColor blackColor]];
    [lblDistance setBackgroundColor:[UIColor clearColor]];
    [sortView addSubview:lblDistance];
    
    imgArwDistance = [[UIImageView alloc] init];
    [imgArwDistance setFrame:CGRectMake(distanceSortView.frame.size.width + distanceSortView.frame.origin.x - 35, 11, 16, 22)];
    [imgArwDistance setImage:[UIImage imageNamed:@"sort-uparrow"]];
    [sortView addSubview:imgArwDistance];
    [imgArwDistance setHidden:YES];
    
    btnDistanceSort = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDistanceSort setFrame:distanceSortView.frame];
    [btnDistanceSort addTarget:self action:@selector(DistanceSortTapped) forControlEvents:UIControlEventTouchUpInside];
    [sortView addSubview:btnDistanceSort];
}

- (IBAction)PriceSortTapped
{
    [lblPrice setTextColor:kSelectedFontColor];
    [imgArwPrice setHidden:NO];
    
    [lblRate setTextColor:[UIColor blackColor]];
    [imgArwRate setHidden:YES];
    
    [lblDistance setTextColor:[UIColor blackColor]];
    [imgArwDistance setHidden:YES];
}

- (IBAction)RateSortTapped
{
    [lblPrice setTextColor:[UIColor blackColor]];
    [imgArwPrice setHidden:YES];
    
    [lblRate setTextColor:kSelectedFontColor];
    [imgArwRate setHidden:NO];
    
    [lblDistance setTextColor:[UIColor blackColor]];
    [imgArwDistance setHidden:YES];
}

- (IBAction)DistanceSortTapped
{
    [lblPrice setTextColor:[UIColor blackColor]];
    [imgArwPrice setHidden:YES];
    
    [lblRate setTextColor:[UIColor blackColor]];
    [imgArwRate setHidden:YES];
    
    [lblDistance setTextColor:kSelectedFontColor];
    [imgArwDistance setHidden:NO];
}

#pragma mark - TECHNICIANS SERVICE REQUEST

- (void)techniciansListRequest
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/Technician/List",kServerUrl];
    
    NSString *categoryId = [GlobalResourcesViewController sharedManager].selectedCategoryId;
    NSString *cityId = [GlobalResourcesViewController sharedManager].selectedCityId;

    NSMutableDictionary *dictRequest = [NSMutableDictionary dictionary];
    [dictRequest setObject:categoryId forKey:kcategory_id];
    [dictRequest setObject:@"0" forKey:kpincode_key];
    [dictRequest setObject:cityId forKey:kcity_id];
    [dictRequest setObject:@"0" forKey:klocal_area_id];
    [dictRequest setObject:@"5" forKey:kpagesize];
    [dictRequest setObject:@"" forKey:klatitude];
    [dictRequest setObject:@"" forKey:klongtitude];
    [dictRequest setObject:@"" forKey:krecent_id];
    
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
                                          NSLog(@"Technician List %@", responseDict);
                                          
                                          if ([[responseDict allKeys] count] > 0)
                                          {
                                              if ([[responseDict allKeys] containsObject:@"technicians"])
                                              {
                                                  technicianAry = [responseDict objectForKey:@"technicians"];
                                              }
                                              
                                              if ([technicianAry count] > 0)
                                              {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [GMDCircleLoader hideFromView:self.view animated:YES];
                                                      [techniciansTblView reloadData];
                                                  });
                                              }
                                              
                                          }
                                          
                                      }
                                      else
                                      {
                                        [GMDCircleLoader hideFromView:self.view animated:YES];
                                          NSLog(@"Error: %@", error.localizedDescription);
                                      }
                                  }];
    
    // Start the task.
    [task resume];
    
}

#pragma mark - TECHNICIANS TABLE

- (void)createTechniciansTable
{
    techniciansTblView = [[UITableView alloc] init];
    [techniciansTblView setFrame:CGRectMake(0, 54, viewWidth, viewHeight - 64 - 54)];
    [techniciansTblView setDelegate:self];
    [techniciansTblView setDataSource:self];
    [techniciansTblView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [techniciansTblView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:techniciansTblView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [technicianAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *technicianView, *ratingView, *availabilityView, *offersView;
    UIImageView *technicianImgView, *briefCaseImg, *locationAwayImg, *crownImg;
    UILabel *lblTechnicianName, *lblTechnicianDistance, *lblTechnicianExp, *lblTechnicianCharge, *lblTechnicianReviews;
    UIButton *btnBook;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *technicianDict = [technicianAry objectAtIndex:indexPath.row];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setAccessoryView:nil];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        technicianView = [[UIView alloc] init];
        [technicianView setFrame:CGRectMake(10, 0, viewWidth - 20, 125)];
        [technicianView setTag:1];
        [technicianView setBackgroundColor:[UIColor whiteColor]];
        [technicianView.layer setBorderWidth:1.0];
        [technicianView.layer setBorderColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0].CGColor];
        [cell.contentView addSubview:technicianView];
        
        technicianImgView = [[UIImageView alloc] init];
        [technicianImgView setFrame:CGRectMake(15, 15, 50, 50)];
        [technicianImgView setTag:2];
        [technicianImgView setBackgroundColor:[UIColor clearColor]];
        [technicianImgView.layer setCornerRadius:25];
        [technicianImgView.layer setMasksToBounds:YES];
        [technicianImgView.layer setBorderWidth:0.5];
        [technicianImgView.layer setBorderColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0].CGColor];
        [technicianView addSubview:technicianImgView];
        
        crownImg = [[UIImageView alloc] init];
        [crownImg setFrame:CGRectMake(50, 45, 25, 25)];
        [crownImg setImage:[UIImage imageNamed:@"crown"]];
        [crownImg setTag:15];
        [technicianView addSubview:crownImg];
        
        ratingView = [[UIView alloc] init];
        [ratingView setTag:11];
        [ratingView setBackgroundColor:[UIColor clearColor]];
        ratingView = [self starsRatingView:[technicianDict objectForKey:@"rating"]];
        [technicianView addSubview:ratingView];
        
        lblTechnicianName = [[UILabel alloc]init];
        [lblTechnicianName setFrame:CGRectMake(100, 15, 200,20)];
        [lblTechnicianName setTag:3];
        [lblTechnicianName setFont:[UIFont fontWithName:kRobotoRegular size:16]];
        [lblTechnicianName setBackgroundColor:[UIColor clearColor]];
        [lblTechnicianName setTextColor:[UIColor blackColor]];
        [technicianView addSubview:lblTechnicianName];

        briefCaseImg = [[UIImageView alloc] init];
        [briefCaseImg setFrame:CGRectMake(100, lblTechnicianName.frame.origin.y + lblTechnicianName.frame.size.height + 10, 13, 12)];
        [briefCaseImg setTag:4];
        [briefCaseImg setImage:[UIImage imageNamed:@"briefcase"]];
        [technicianView addSubview:briefCaseImg];
        
        lblTechnicianExp = [[UILabel alloc]init];
        [lblTechnicianExp setFrame:CGRectMake(briefCaseImg.frame.origin.x + briefCaseImg.frame.size.width + 5, briefCaseImg.frame.origin.y - 2, 150,16)];
        [lblTechnicianExp setTag:5];
        [lblTechnicianExp setFont:[UIFont fontWithName:kRobotoRegular size:12]];
        [lblTechnicianExp setBackgroundColor:[UIColor clearColor]];
        [lblTechnicianExp setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        [technicianView addSubview:lblTechnicianExp];
        
        locationAwayImg = [[UIImageView alloc] init];
        [locationAwayImg setFrame:CGRectMake(100 + 2, lblTechnicianExp.frame.origin.y + lblTechnicianExp.frame.size.height + 10, 9, 12)];
        [locationAwayImg setTag:6];
        [locationAwayImg setImage:[UIImage imageNamed:@"locationAway"]];
        [technicianView addSubview:locationAwayImg];
        
        lblTechnicianDistance = [[UILabel alloc]init];
        [lblTechnicianDistance setFrame:CGRectMake(briefCaseImg.frame.origin.x + briefCaseImg.frame.size.width + 5, locationAwayImg.frame.origin.y - 2, 90,16)];
        [lblTechnicianDistance setTag:7];
        [lblTechnicianDistance setFont:[UIFont fontWithName:kRobotoRegular size:12]];
        [lblTechnicianDistance setBackgroundColor:[UIColor clearColor]];
        [lblTechnicianDistance setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        [technicianView addSubview:lblTechnicianDistance];
        
        UILabel *lblDivide = [[UILabel alloc]init];
        [lblDivide setFrame:CGRectMake(lblTechnicianDistance.frame.origin.x + lblTechnicianDistance.frame.size.width + 5, locationAwayImg.frame.origin.y + 2, 1,12)];
        [lblDivide setTag:8];
        [lblDivide setBackgroundColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        [technicianView addSubview:lblDivide];
        
        lblTechnicianCharge = [[UILabel alloc]init];
        [lblTechnicianCharge setFrame:CGRectMake(lblDivide.frame.origin.x + lblDivide.frame.size.width + 5, locationAwayImg.frame.origin.y - 2, 120,16)];
        [lblTechnicianCharge setTag:9];
        [lblTechnicianCharge setFont:[UIFont fontWithName:kRobotoRegular size:12]];
        [lblTechnicianCharge setBackgroundColor:[UIColor clearColor]];
        [lblTechnicianCharge setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        [technicianView addSubview:lblTechnicianCharge];
        
        lblTechnicianReviews = [[UILabel alloc]init];
        [lblTechnicianReviews setFrame:CGRectMake(15, technicianImgView.frame.origin.y + technicianImgView.frame.size.height + 25, 50,16)];
        [lblTechnicianReviews setTag:10];
        [lblTechnicianReviews setFont:[UIFont fontWithName:kRobotoRegular size:10]];
        [lblTechnicianReviews setBackgroundColor:[UIColor clearColor]];
        [lblTechnicianReviews setTextAlignment:NSTextAlignmentCenter];
        [lblTechnicianReviews setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        [technicianView addSubview:lblTechnicianReviews];
        
        btnBook = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnBook setFrame:CGRectMake(110, lblTechnicianCharge.frame.origin.y + lblTechnicianCharge.frame.size.height + 10, 70, 24)];
        [btnBook setTag:12];
        [btnBook.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:12]];
        [btnBook setTitle:@"BOOK" forState:UIControlStateNormal];
        [btnBook setTitleColor:[UIColor colorWithRed:155.0/255.0 green:210.0/255.0 blue:93.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btnBook.layer setBorderWidth:0.5];
        [btnBook.layer setBorderColor:[UIColor colorWithRed:155.0/255.0 green:210.0/255.0 blue:93.0/255.0 alpha:1.0].CGColor];
        [btnBook addTarget:self action:@selector(bookClicked:) forControlEvents:UIControlEventTouchUpInside];
        [technicianView addSubview:btnBook];
        
        availabilityView = [[UIView alloc] init];
        [availabilityView setTag:13];
        [availabilityView setBackgroundColor:[UIColor clearColor]];
        availabilityView = [self availabiityView:[technicianDict objectForKey:@"available_status"]];
        [technicianView addSubview:availabilityView];
        
        offersView = [[UIView alloc] init];
        [offersView setTag:14];
        offersView = [self offersView:[technicianDict objectForKey:@"offer"]];
        [technicianView addSubview:offersView];
        
    }
    else
    {
        technicianView = (UIView *)[cell.contentView viewWithTag:1];
        technicianImgView = (UIImageView *)[cell.contentView viewWithTag:2];
        lblTechnicianName = (UILabel *)[cell.contentView viewWithTag:3];
        briefCaseImg = (UIImageView *)[cell.contentView viewWithTag:4];
        lblTechnicianExp = (UILabel *)[cell.contentView viewWithTag:5];
        locationAwayImg = (UIImageView *)[cell.contentView viewWithTag:6];
        lblTechnicianDistance = (UILabel *)[cell.contentView viewWithTag:7];
        lblTechnicianCharge = (UILabel *)[cell.contentView viewWithTag:9];
        lblTechnicianReviews = (UILabel *)[cell.contentView viewWithTag:10];
        ratingView = (UIView *)[cell.contentView viewWithTag:11];
        btnBook = (UIButton *)[cell.contentView viewWithTag:12];
        availabilityView = (UIView *)[cell.contentView viewWithTag:13];
        offersView = (UIView *)[cell.contentView viewWithTag:14];
        crownImg = (UIImageView *)[cell.contentView viewWithTag:15];
    }
    
    NSString *stringUrl = [NSString stringWithFormat:@"%@",[technicianDict objectForKey:@"photo"]];
    [technicianImgView sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"] ];
    
    [lblTechnicianName setText:[NSString stringWithFormat:@"%@",[technicianDict objectForKey:@"name"]]];
    [lblTechnicianExp setText:[NSString stringWithFormat:@"%@ yr experience",[technicianDict objectForKey:@"experience"]]];
    [lblTechnicianDistance setText:[NSString stringWithFormat:@"%@km from you",[technicianDict objectForKey:@"kilometer"]]];
    [lblTechnicianCharge setText:[NSString stringWithFormat:@"Rs.%@",[technicianDict objectForKey:@"min_rate"]]];
    [lblTechnicianReviews setText:[NSString stringWithFormat:@"%@ Reviews",[technicianDict objectForKey:@"reviewscount"]]];
    
    if ([[technicianDict objectForKey:@"goldpartner"] boolValue])
    {
        [crownImg setHidden:NO];
    }
    else
    {
        [crownImg setHidden:YES];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [GlobalResourcesViewController sharedManager].selectedTechnicianId = [NSString stringWithFormat:@"%@",[[technicianAry objectAtIndex:indexPath.row] objectForKey:@"id"]];
    
    [self performSegueWithIdentifier:@"TechnicianProfile" sender:nil];
}

#pragma mark - STAR RATINGS VIEW

- (UIView *)starsRatingView:(NSString *)rating
{
    int ratingNum = [rating intValue];

    UIView *ratingView = [[UIView alloc] init];
    [ratingView setFrame:CGRectMake(15, 80, 50, 10)];
    [ratingView setBackgroundColor:[UIColor clearColor]];
    
    int xPos = 0;
    
    for (int i=0; i<ratingNum; i++)
    {
        UIImageView *starImgs = [[UIImageView alloc] init];
        [starImgs setFrame:CGRectMake(xPos, 0, 11, 11)];
        [starImgs setImage:[UIImage imageNamed:@"fullstar"]];
        [ratingView addSubview:starImgs];
        
        xPos += 11;
    }
    
    int remainNum = 5 - [rating intValue];
    
    for (int i=0; i<remainNum; i++)
    {
        UIImageView *starImgs = [[UIImageView alloc] init];
        [starImgs setFrame:CGRectMake(xPos, 0, 11, 11)];
        [starImgs setImage:[UIImage imageNamed:@"emptystar"]];
        [ratingView addSubview:starImgs];
        
        xPos += 11;
    }
    
    return ratingView;
}

#pragma mark - OFFERS VIEW

- (UIView *)offersView:(NSString *)offerStr
{
    bool offer = [offerStr boolValue];
    
    if (offer)
    {
        UIView *offersView = [[UIView alloc] init];
        [offersView setFrame:CGRectMake(15, 80, 0, 0)];
        
        UIBezierPath* trianglePath = [UIBezierPath bezierPath];
        [trianglePath moveToPoint:CGPointMake   (100, offersView.frame.size.height-50)];
        [trianglePath addLineToPoint:CGPointMake(offersView.frame.size.width/2,50)];
        [trianglePath addLineToPoint:CGPointMake(offersView.frame.size.width, offersView.frame.size.height)];
        [trianglePath closePath];
        
        CAShapeLayer *triangleMaskLayer = [CAShapeLayer layer];
        [triangleMaskLayer setPath:trianglePath.CGPath];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewWidth - 70, 75, 50, 50)];
        [view setBackgroundColor:[UIColor colorWithRed:155.0/255.0 green:210.0/255.0 blue:93.0/255.0 alpha:1.0]];
        view.layer.mask = triangleMaskLayer;
        view.transform = CGAffineTransformMakeRotation(M_PI/1);
        
        UILabel *lblOffers = [[UILabel alloc]init];
        [lblOffers setFrame:CGRectMake(0, 10, 40,12)];
        [lblOffers setFont:[UIFont fontWithName:kRobotoRegular size:10]];
        [lblOffers setBackgroundColor:[UIColor clearColor]];
        [lblOffers setTextAlignment:NSTextAlignmentCenter];
        [lblOffers setTextColor:[UIColor whiteColor]];
        [lblOffers setText:@"Offers"];
        lblOffers.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(130));
        [view addSubview:lblOffers];
        
        return view;
    }
    else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        return view;
    }
    
}

#pragma mark - AVAILABITY VIEW

- (UIView *)availabiityView:(NSString *)status
{
    UIView *statusView = [[UIView alloc] init];
    [statusView setFrame:CGRectMake(viewWidth - 70, 0, 50, 12)];
    [statusView setBackgroundColor:[UIColor clearColor]];
    [statusView.layer setBorderWidth:1.0];
    [statusView.layer setBorderColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0].CGColor];
    
    UIImageView *dotImg = [[UIImageView alloc] init];
    [dotImg setFrame:CGRectMake(5, 3.5, 5, 5)];
    [statusView addSubview:dotImg];
    
    UILabel *lblStatus = [[UILabel alloc]init];
    [lblStatus setFrame:CGRectMake(13, 0, 35,12)];
    [lblStatus setFont:[UIFont fontWithName:kRobotoRegular size:7]];
    [lblStatus setBackgroundColor:[UIColor clearColor]];
    [lblStatus setTextAlignment:NSTextAlignmentLeft];
    [lblStatus setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    [statusView addSubview:lblStatus];
    
    if ([status isEqualToString:@"Offline"])
    {
        [dotImg setImage:[UIImage imageNamed:@"dot_offline"]];
        [lblStatus setText:@"OFFLINE"];
    }
    else if ([status isEqualToString:@"Online"])
    {
        [dotImg setImage:[UIImage imageNamed:@"dot_online"]];
        [lblStatus setText:@"ONLINE"];
    }
    else
    {
        [dotImg setImage:[UIImage imageNamed:@"dot_disable"]];
        [lblStatus setText:@"DISABLE"];
    }
    
    return statusView;
}

#pragma mark - BOOK CLICKED

- (void)bookClicked:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:techniciansTblView];
    NSIndexPath *indexPath = [techniciansTblView indexPathForRowAtPoint:buttonPosition];
    
    [GlobalResourcesViewController sharedManager].selectedTechnicianId = [NSString stringWithFormat:@"%@",[[technicianAry objectAtIndex:indexPath.row] objectForKey:@"id"]];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self performSegueWithIdentifier:@"termsVC" sender:nil];
    });
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
