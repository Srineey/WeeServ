//
//  GlobalResourcesViewController.h
//  WeeServ
//
//  Created by saran c on 17/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#define kServerUrl                          @"http://api.weeserv.com/v1"
#define kDictCategories                     @"dictCategories"
#define kSelectedService                    @"selectedService"
#define kSelectedCategory                   @"selectedCategory"
#define kSelectedCityName                   @"selectedCityName"
#define kSelectedCityId                     @"selectedCityId"
#define kSelectedTechnicianId               @"selectedTechnicianId"

#define kSelectedServiceId                  @"selectedServiceId"
#define kSelectedCategoryId                 @"selectedCategoryId"
#define kSelectedSubCategoryId              @"selectedSubCategoryId"
#define kSelectedBrandId                    @"selectedBrandId"

#define kPinCode                            @"pinCode"

#define kSelectedAreaId                     @"selectedAreaId"
#define kSelectedAreaName                   @"selectedAreaName"
#define kIsSelectedArea                     @"isSelectedArea"
#define kSelectedAddress                    @"selectedAddress"
#define kSelectedAddressId                  @"selectedAddressId"

#define kSelectedDate                       @"selectedDate"
#define kSelectedTime                       @"selectedTime"

#define kEnteredSuggestion                  @"enteredSuggestion"

#define kAppBgColor                         [UIColor colorWithRed:153.0/255.0 green:63.0/255.0 blue:233.0/255.0 alpha:1.0]

//CONFIGURARION VARIABLES

#define kShoworhideslider                   @"showorhideslider"
#define kShoworhidetrendingcategory         @"showorhidetrendingcategory"
#define kDefault_country                    @"default_country"

//COMMAN

#define kRobotoMedium                       @"Roboto-Medium"
#define kRobotoRegular                      @"Roboto-Regular"

//SERVICE KEYS

#define kcategory_id                        @"category_id"
#define kpincode_key                        @"pincode"
#define kcity_id                            @"city_id"
#define klocal_area_id                      @"local_area_id"
#define klatitude                           @"latitude"
#define klongtitude                         @"longtitude"
#define kpagesize                           @"pagesize"
#define krecent_id                          @"recent_id"

//LOGIN RELATED

#define kmobileno                           @"mobileno"
#define kname                               @"name"
#define kemail                              @"email"
#define kpassword                           @"password"
#define krole                               @"role"
#define kcountry_id                         @"country_id"

#define khouse_number                       @"house_number"
#define kstreet_name                        @"street_name"
#define klocality                           @"locality"
#define klandmark                           @"landmark"
#define kcity                               @"city"
#define klatitude                           @"latitude"
#define klongtitude                         @"longtitude"

#define kaccess_token                       @"access_token"
#define kuserid                             @"userid"
#define kisUserLoggedIn                     @"isUserLoggedIn"

#define kauth_code                          @"auth_code"
#define kloginStatus                        @"loginStatus"
#define kphoneNumber                        @"phoneNumber"

#define kstrName                            @"strName"
#define kstrEmail                           @"strEmail"

#define kisFromMenu                         @"isFromMenu"


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalResourcesViewController : NSObject
{
}

@property (nonatomic, strong) NSMutableDictionary *defaults;
@property (nonatomic, strong) NSDictionary *dictCategories, *selectedCategory, *selectedService, *selectedAddress;
@property (nonatomic, strong) NSString *selectedServiceId, *selectedCategoryId, *selectedSubCategoryId, *selectedBrandId, *selectedAddressId;
@property (nonatomic, strong) NSString *selectedCityName, *selectedCityId, *pinCode, *selectedTechnicianId;
@property (nonatomic, strong) NSString *auth_code, *loginStatus, *phoneNumber, *strName, *strEmail;
@property (nonatomic, strong) NSString *selectedAreaId, *selectedAreaName, *selectedDate, *selectedTime, *enteredSuggestion;
@property (nonatomic, assign) bool isSelectedArea, isFromMenu;

//CONFIGURARION VARIABLES
@property (nonatomic, strong) NSString *default_country;
@property (nonatomic, assign) bool showorhideSlider, showorhideTrendingCategory;

+ (GlobalResourcesViewController *)sharedManager;
- (id)initClass;
- (void)setHeader;
- (void)setNavigationTitle:(UIViewController *)views title:(NSString *)titleText;
- (void)kInit;
- (void)ConfigurationSettings;
- (void)saveLoginDetails:(NSDictionary *)response;

- (void)showMessage:(NSString*)message withTitle:(NSString *)title;

- (NSString*)checkForNull:(id)value;

@end
