//
//  GlobalResourcesViewController.m
//  WeeServ
//
//  Created by saran c on 17/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "GlobalResourcesViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define ACCEPTABLE_CHARECTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."

static GlobalResourcesViewController *sharedInstance = nil;

@implementation GlobalResourcesViewController
@synthesize defaults;


+ (GlobalResourcesViewController *)sharedManager
{
    @synchronized([GlobalResourcesViewController class])
    {
        if (!sharedInstance)
            sharedInstance = [[self alloc] initClass];
        
        return sharedInstance;
    }
    
    return nil;
}

- (id)initClass
{
    self = [super init];
    
    if (self != nil)
    {
        
    }
    return self;
}

#pragma mark - NAVIGATION METHODS

-(void)setHeader
{
    if ((floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1))
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:153.0/255.0 green:63.0/255.0 blue:233.0/255.0 alpha:1.0]];
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        shadow.shadowOffset = CGSizeMake(0, 1);
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                               shadow, NSShadowAttributeName,
                                                               [UIFont fontWithName:@"Avenir-Heavy" size:20.0], NSFontAttributeName, nil]];
    }
    else
    {
        
    }
}

- (void)setNavigationTitle:(UIViewController *)views title:(NSString *)titleText
{
    UILabel *lblTitle = [[UILabel alloc] init];
    [lblTitle setText:titleText];
    [lblTitle setBackgroundColor:[UIColor clearColor]];
    [lblTitle setShadowOffset:CGSizeMake(0,1)];
    [lblTitle setShadowColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2]];
    [lblTitle setFont:[UIFont fontWithName:@"Exo-Regular" size:20.0]];
    [lblTitle setTextColor:[UIColor whiteColor]];
    [lblTitle sizeToFit];
    views.navigationItem.titleView = lblTitle;
    
    [self setHeader];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        views.edgesForExtendedLayout = UIRectEdgeNone;
        views.extendedLayoutIncludesOpaqueBars = NO;
        views.automaticallyAdjustsScrollViewInsets=NO;
    }
}

#pragma marl - Configuration Service

- (void)ConfigurationSettings
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/Settings",kServerUrl];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:stringURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error == nil)
                {
                    NSDictionary *responseDict   =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSLog(@"Configuration Settings Services %@", responseDict);
                    
                    if ([[responseDict allKeys] count] > 0)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                            NSDictionary *settingsDict = [responseDict objectForKey:@"Settings"];
                            
                            self.default_country = [NSString stringWithFormat:@"%@",[settingsDict objectForKey:@"default_country"]];
                            self.showorhideSlider = [[settingsDict objectForKey:@"showorhideslider"] boolValue];
                            self.showorhideTrendingCategory = [[settingsDict objectForKey:@"showorhidetrendingcategory"] boolValue];
                            
//                            ViewController *vc = [[ViewController alloc] init];
//                            [vc serviceCalls];
                        });
                    }
                }
                
            }] resume];
}

#pragma mark - kInit

- (void)kInit
{
    NSDictionary *dictCategoriesDefault         = [NSDictionary dictionary];
    NSDictionary *selectedCategoryDefault       = [NSDictionary dictionary];
    NSDictionary *selectedServiceDefault        = [NSDictionary dictionary];
    NSDictionary *selectedAddressDefault        = [NSDictionary dictionary];
    
    NSString *selectedServiceIdDefault          = @"";
    NSString *selectedCategoryIdDefault         = @"";
    NSString *selectedSubCategoryIdDefault      = @"";
    NSString *selectedBrandIdDefault            = @"";
    
    NSString *selectedTechnicianIdDefault       = @"";
    
    NSString *selectedCityNameDefault           = @"Chennai";
    NSString *selectedCityIdDefault             = @"48915";
    
    NSString *pinCodeDefault                    = @"";
    
    NSString *auth_codeDefault                  = @"";
    NSString *loginStatusDefault                = @"";
    NSString *phoneNumberDefault                = @"";
    
    NSString *strNameDefault                    = @"";
    NSString *strEmailDefault                   = @"";
    
    NSString *selectedAreaNameDefault           = @"";
    NSString *selectedAreaIdDefault             = @"";
    NSString *selectedAddressIdDefault          = @"";
    
    NSString *selectedDateDefault               = @"";
    NSString *selectedTimeDefault               = @"";
    
    NSString *enteredSuggestionDefault          = @"";
    
    
    //CONFIGURATION VARIABLES
    
    NSString *default_countryDefault            = @"";
    NSNumber *showorhideSliderDefault           = [NSNumber numberWithBool:NO];
    NSNumber *showorhideTrendingCategoryDefault = [NSNumber numberWithBool:NO];
    NSNumber *isSelectedAreaDefault             = [NSNumber numberWithBool:NO];
    NSNumber *isFromMenuDefault                 = [NSNumber numberWithInt:NO];
    
    
    if (defaults == nil) {
        defaults = [NSMutableDictionary dictionary];
    }
    
    defaults = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         dictCategoriesDefault,         kDictCategories,
                                         selectedCategoryDefault,       kSelectedCategory,
                                         selectedServiceDefault,        kSelectedService,
                
                                         selectedCityNameDefault,       kSelectedCityName,
                                         selectedCityIdDefault,         kSelectedCityId,
                
                                         selectedServiceIdDefault,      kSelectedServiceId,
                                         selectedCategoryIdDefault,     kSelectedCategoryId,
                                         selectedSubCategoryIdDefault,  kSelectedSubCategoryId,
                                         selectedBrandIdDefault,        kSelectedBrandId,
                
                                         selectedTechnicianIdDefault,   kSelectedTechnicianId,
                
                                         pinCodeDefault,                kPinCode,
                
                                         default_countryDefault,        kDefault_country,
                                         showorhideSliderDefault,       kShoworhideslider,
                                         showorhideTrendingCategoryDefault, kShoworhidetrendingcategory,
                
                                         auth_codeDefault,              kauth_code,
                                         loginStatusDefault,            kloginStatus,
                                         phoneNumberDefault,            kphoneNumber,
                
                                         strNameDefault,                kstrName,
                                         strEmailDefault,               kstrEmail,
                
                                         selectedAreaIdDefault,         kSelectedAreaId,
                                         selectedAreaNameDefault,       kSelectedAreaName,
                                         selectedAddressIdDefault,      kSelectedAddressId,
                                         selectedAddressDefault,        kSelectedAddress,
                
                                         isSelectedAreaDefault,         kIsSelectedArea,
                
                                         selectedDateDefault,           kSelectedDate,
                                         selectedTimeDefault,           kSelectedTime,
                
                                         enteredSuggestionDefault,      kEnteredSuggestion,
                
                                         isFromMenuDefault,             kisFromMenu,
                                         
                                         nil];
    
    self.dictCategories          = [defaults objectForKey:kDictCategories];
    self.selectedCategory        = [defaults objectForKey:kSelectedCategory];
    self.selectedService         = [defaults objectForKey:kSelectedService];
    
    self.selectedCityName        = [defaults objectForKey:kSelectedCityName];
    self.selectedCityId          = [defaults objectForKey:kSelectedCityId];
    
    self.selectedServiceId       = [defaults objectForKey:kSelectedServiceId];
    self.selectedCategoryId      = [defaults objectForKey:kSelectedCategoryId];
    self.selectedSubCategoryId   = [defaults objectForKey:kSelectedSubCategoryId];
    self.selectedBrandId         = [defaults objectForKey:kSelectedBrandId];
    
    self.selectedTechnicianId    = [defaults objectForKey:kSelectedTechnicianId];
    
    self.pinCode                 = [defaults objectForKey:kPinCode];
    
    self.auth_code               = [defaults objectForKey:kauth_code];
    self.loginStatus             = [defaults objectForKey:kloginStatus];
    self.phoneNumber             = [defaults objectForKey:kphoneNumber];
    
    self.strName                 = [defaults objectForKey:kstrName];
    self.strEmail                = [defaults objectForKey:kstrEmail];
    
    self.selectedAreaId          = [defaults objectForKey:kSelectedAreaId];
    self.selectedAreaName        = [defaults objectForKey:kSelectedAreaName];
    self.selectedAddressId       = [defaults objectForKey:kSelectedAddressId];
    self.selectedAddress         = [defaults objectForKey:kSelectedAddress];
    
    self.isSelectedArea          = [[defaults objectForKey:kIsSelectedArea] boolValue];
    
    self.selectedDate            = [defaults objectForKey:kSelectedDate];
    self.selectedTime            = [defaults objectForKey:kSelectedTime];
    
    self.enteredSuggestion       = [defaults objectForKey:kEnteredSuggestion];
    
    self.isFromMenu              = [[defaults objectForKey:kisFromMenu] boolValue];
    
    //CONFIGURATION VARIABLES
    
    self.default_country         = [defaults objectForKey:kDefault_country];
    self.showorhideSlider        = [[defaults objectForKey:kShoworhideslider] boolValue];
    self.showorhideTrendingCategory = [[defaults objectForKey:kShoworhidetrendingcategory] boolValue];
}

#pragma mark - SHOW ALERT MESSAGE

-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:^{
        }];
    });
}

#pragma mark - SAVE LOGIN DETAILS

- (void)saveLoginDetails:(NSDictionary *)response
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[response allKeys] containsObject:kaccess_token] && [[response allKeys] containsObject:kuserid])
    {
        [userDefaults setObject:[response objectForKey:kaccess_token] forKey:kaccess_token];
        [userDefaults setObject:[response objectForKey:kuserid] forKey:kuserid];
        [userDefaults setObject:[NSNumber numberWithBool:YES] forKey:kisUserLoggedIn];
    }
}

#pragma mark - CHECK NULL CLASS

-(NSString*)checkForNull:(id)value
{
    if([value isKindOfClass:[NSNull class]] || [value length] == 0 || [value isEqualToString:@"(null)"])
    {
        return @"";
    }
    return value;
}

@end
