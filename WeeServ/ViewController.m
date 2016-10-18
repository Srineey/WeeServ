//
//  ViewController.m
//  WeeServ
//
//  Created by saran c on 03/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "GlobalResourcesViewController.h"
#import "GMDCircleLoader.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mainScrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController setNavigationBarHidden:NO];
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(seletedCityDelegate)
                                                 name:@"CitySelected"
                                               object:nil];
    
    [self setNavigationTitle];
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 44 ,44)];
    _sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.navigationItem setLeftBarButtonItem:_sidebarButton];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    mainScrl = [[UIScrollView alloc] init];
    [mainScrl setFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [mainScrl setBackgroundColor:kMainScrlBgColor];
    [self.view addSubview:mainScrl];
    
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
    
    [self serviceCalls];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)serviceCalls
{
    if ([[GlobalResourcesViewController sharedManager] showorhideSlider])
    {
        homeCarouselView = [[HomeCarouselView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 120)];
        [self homeSliderRequest];
    }
    
    if ([[GlobalResourcesViewController sharedManager] showorhideTrendingCategory])
    {
        trendingServicesView = [[TrendingServicesView alloc] initWithFrame:CGRectMake(0, homeCarouselView.frame.origin.y + homeCarouselView.frame.size.height, viewWidth, 130)];
        [self trendingServicesRequest];
    }
    
    [self homeServicesRequest];
}

#pragma mark - SET NAVIGATION TITLE

- (void)setNavigationTitle
{
    UIView *viewNav = [[UIView alloc]init];
    [viewNav setFrame:self.navigationController.navigationBar.frame];
    [viewNav setBackgroundColor:[UIColor clearColor]];
    
    UILabel *navLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    [navLabel1 setFont:[UIFont fontWithName:@"Exo-Regular" size:20.0]];
    [navLabel1 setText:@"WeeServ"];
    [navLabel1 setTextColor:[UIColor whiteColor]];
    [navLabel1 setTextAlignment:NSTextAlignmentLeft];
    [navLabel1 setBackgroundColor:[UIColor clearColor]];
    [viewNav addSubview:navLabel1];
    
    lblCityName = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth/2 + 30, 0, viewWidth/2  - 110, 44)];
    [lblCityName setFont:[UIFont fontWithName:kRobotoRegular size:14.0]];
    [lblCityName setText:[[GlobalResourcesViewController sharedManager] selectedCityName]];
    [lblCityName setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8]];
    [lblCityName setTextAlignment:NSTextAlignmentRight];
    [lblCityName setBackgroundColor:[UIColor clearColor]];
    [viewNav addSubview:lblCityName];
    
    UIButton *btnSearchCity = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSearchCity setFrame:lblCityName.frame];
    [btnSearchCity setBackgroundColor:[UIColor clearColor]];
    [btnSearchCity addTarget:self action:@selector(btnSearchCityTapped) forControlEvents:UIControlEventTouchUpInside];
    [viewNav addSubview:btnSearchCity];
    
    UIButton *btnSearchCategory = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSearchCategory setFrame:CGRectMake(viewWidth/2 - 10, 0, 44, 44)];
    [btnSearchCategory setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [btnSearchCategory setBackgroundColor:[UIColor clearColor]];
    [btnSearchCategory addTarget:self action:@selector(btnSearchCategoryTapped) forControlEvents:UIControlEventTouchUpInside];
    [viewNav addSubview:btnSearchCategory];
    
    self.navigationItem.titleView = viewNav;
}

- (float)sizeWithFont:(UILabel *)label cityName:(NSString *)string
{
    NSAttributedString *attributedText =
    [[NSAttributedString alloc] initWithString:string
                                    attributes:@{NSFontAttributeName: label.font}];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){150, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size.width;
}

- (void)homeSliderRequest
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/HomeSlider",kServerUrl];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:stringURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error == nil)
                {
                    NSDictionary *responseDict   =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSLog(@"Home Slider %@", responseDict);
                    
                    if ([[responseDict allKeys] count] > 0)
                    {
                        NSArray *aryHomeSliderImgs = [responseDict objectForKey:@"slider"];
                        
                        if ([aryHomeSliderImgs count] > 0)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^(void) {
                                [homeCarouselView homeSliderView:aryHomeSliderImgs];
                                [mainScrl addSubview:homeCarouselView];
                            });
                            
                        }
                    }
                }
                
            }] resume];
}

- (void)trendingServicesRequest
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/services/trending/%@",kServerUrl,[[GlobalResourcesViewController sharedManager] default_country]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:stringURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error == nil)
                {
                    NSDictionary *responseDict   =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSLog(@"Trending Services %@", responseDict);
                    
                    if ([[responseDict allKeys] count] > 0)
                    {
                            dispatch_async(dispatch_get_main_queue(), ^(void) {
                                [trendingServicesView categoryListView:responseDict];
                                [mainScrl addSubview:trendingServicesView];
                            });
                    }
                }
                
            }] resume];
}

- (void)homeServicesRequest
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/services/%@",kServerUrl,[GlobalResourcesViewController sharedManager].selectedCityId];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:stringURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error == nil)
                {
                    NSDictionary *responseDict   =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSLog(@"Home Services List %@", responseDict);
                    
                    [[GlobalResourcesViewController sharedManager] setDictCategories:responseDict];
                    
                    NSLog(@"DictCategories %@",[[GlobalResourcesViewController sharedManager] dictCategories]);
                    
                    if ([[responseDict allKeys] count] > 0)
                    {
                        NSArray *aryServicesList = [responseDict objectForKey:@"services"];
                        
                        if ([aryServicesList count] > 0)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^(void) {
                                
                                [GMDCircleLoader hideFromView:self.view animated:YES];
                                
                                int yPos = trendingServicesView.frame.origin.y + trendingServicesView.frame.size.height;
                                
                                for (int i=0; i < [aryServicesList count]; i++)
                                {
                                    NSArray *categoryAry = [[aryServicesList objectAtIndex:i] objectForKey:@"category"];
                                    
                                    if ([categoryAry count]>0)
                                    {
                                        servicesListView = [[ServicesListView alloc] initWithFrame:CGRectMake(0, yPos, viewWidth, 180)];
                                        [servicesListView categoryListView:[aryServicesList objectAtIndex:i]];
                                        [mainScrl addSubview:servicesListView];
                                        servicesListView.delegate = self;
                                        
                                        yPos += 190;
                                    }
                                }
                                
                                [mainScrl setContentSize:CGSizeMake(viewWidth, yPos + 60)];
                                
                            });
                            
                        }
                    }
                }
                
            }] resume];
}

#pragma mark - SERVICE LIST DELEGATE

- (void)selectedServiceDelegate
{
    [self performSegueWithIdentifier:@"SelectedCategoryList" sender:nil];
}

- (void)seletedCategoryDelegate
{
    NSLog(@"Selected Category %@",[[GlobalResourcesViewController sharedManager] selectedCategory]);
    
    NSDictionary *dictCategory = [[GlobalResourcesViewController sharedManager] selectedCategory];
    NSString *selectedCategoryId = [dictCategory objectForKey:@"id"];
    [GlobalResourcesViewController sharedManager].selectedCategoryId = selectedCategoryId;
    
        NSArray *subCategoryArray = [dictCategory objectForKey:@"subcategory"];
        NSArray *brandsArray = [dictCategory objectForKey:@"brands"];
        
        if ([subCategoryArray count] > 0)
        {
            NSLog(@"SUB CATEGORIES");
            [self performSegueWithIdentifier:@"HomeToSubCategory" sender:nil];
        }
        else if ([brandsArray count] > 0)
        {
            NSLog(@"BRANDS");
            [self performSegueWithIdentifier:@"HomeToBrand" sender:nil];
        }
        else
        {
            NSLog(@"HOME TO LOCALE");
            
            [self performSegueWithIdentifier:@"HomeToLocale" sender:nil];
        }
}

#pragma mark - SIDE MENU CLICK

- (void)btnMenuClick
{
    // Change button color
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

#pragma mark - SEARCH CATEGORY CLICK

- (void)btnSearchCategoryTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"SearchCityViewController"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ivc];
    
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

#pragma mark - CITY SELECTED DELEGATE

- (void)seletedCityDelegate
{
    if (![lblCityName.text isEqualToString:[GlobalResourcesViewController sharedManager].selectedCityName])
    {
        [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
        
        [lblCityName setText:[[GlobalResourcesViewController sharedManager] selectedCityName]];
        
        for (UIView *v in mainScrl.subviews) {
            if (![v isKindOfClass:[UIImageView class]]) {
                [v removeFromSuperview];
            }
        }
        
        if ([[GlobalResourcesViewController sharedManager] showorhideSlider])
        {
            homeCarouselView = [[HomeCarouselView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 120)];
            [self homeSliderRequest];
        }
        
        if ([[GlobalResourcesViewController sharedManager] showorhideTrendingCategory])
        {
            trendingServicesView = [[TrendingServicesView alloc] initWithFrame:CGRectMake(0, homeCarouselView.frame.origin.y + homeCarouselView.frame.size.height, viewWidth, 130)];
            [self trendingServicesRequest];
        }
        
        [self homeServicesRequest];
    }
}

#pragma mark - SEARCH CITY CLICK

- (void)btnSearchCityTapped
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
