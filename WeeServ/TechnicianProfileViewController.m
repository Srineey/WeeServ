//
//  TechnicianProfileViewController.m
//  WeeServ
//
//  Created by saran c on 28/07/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "TechnicianProfileViewController.h"
#import "UIImageView+WebCache.h"
#import "GMDCircleLoader.h"

@interface TechnicianProfileViewController ()

@end

@implementation TechnicianProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor colorWithRed:153.0/255.0 green:63.0/255.0 blue:233.0/255.0 alpha:1.0];
    }
    
    [self.navigationController setNavigationBarHidden:YES];
    
    showMoreComments = NO;
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    mainScrlView = [[UIScrollView alloc] init];
    [mainScrlView setFrame:CGRectMake(0, 0, viewWidth, viewHeight - 40)];
    [mainScrlView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:mainScrlView];
    
    [mainScrlView setContentSize:CGSizeMake(viewWidth, 1000)];
    
    btnBook = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBook setFrame:CGRectMake(0, viewHeight - 40, viewWidth, 40)];
    [btnBook.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [btnBook setTitle:@"BOOK" forState:UIControlStateNormal];
    [btnBook setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnBook setBackgroundColor:kAppBgColor];
    [btnBook addTarget:self action:@selector(bookClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBook];
    
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
    
    [self technicianProfileRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - TECHNICIAN PROFILE REQUEST

- (void)technicianProfileRequest
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/Technician/%@",kServerUrl,[GlobalResourcesViewController sharedManager].selectedTechnicianId];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:stringURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error == nil)
                {
                    NSDictionary *responseDict   =   [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    NSLog(@"Technician Profile %@", responseDict);
                    
                    if ([[responseDict allKeys] count] > 0)
                    {
                        NSDictionary *dictProfile = [responseDict objectForKey:@"technician"];
                        
                        if ([[dictProfile allKeys] count] > 0)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^(void)
                            {
                                [GMDCircleLoader hideFromView:self.view animated:YES];
                                
                                NSDictionary *technicalSummary = [dictProfile objectForKey:@"user_professioanl"];
                                NSArray *recentWorkPhotsAry = [dictProfile objectForKey:@"recentWorkphoto"];
                                
                                yPos = 240;
                                
                                [self setCoverView:dictProfile];
                                
                                NSString * expertiseStr = [[dictProfile valueForKey:@"category"] componentsJoinedByString:@","];
//                                NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
//                                expertiseStr = [expertiseStr stringByTrimmingCharactersInSet:charSet];
                                
//                                NSMutableString * expertiseStr = [[NSMutableString alloc] init];
//                                
//                                for (NSObject * obj in [dictProfile valueForKey:@"category"])
//                                {
//                                    [expertiseStr appendString:[obj description]];
//                                }
                                
                                NSLog(@"The concatenated string is %@", expertiseStr);

                                [self technicianSummary:@"MEMBER SINCE" withDescription:[dictProfile objectForKey:@"member_since"]];
                                [self technicianSummary:@"EXPERTISE IN" withDescription:expertiseStr];
                                [self technicianSummary:@"WORK LEVEL" withDescription:[technicalSummary objectForKey:@"job_level"]];
                                [self technicianSummary:@"PROFESSIONAL" withDescription:[technicalSummary objectForKey:@"functional_area"]];
                                [self technicianSummary:@"TOTAL NO OF VIEWERS" withDescription:[dictProfile objectForKey:@"viewers"]];
                                [self technicianSummary:@"TOTAL NO OF JOBS COMPLETED" withDescription:[dictProfile objectForKey:@"totaljobcompleted"]];
                                
                                [self recentWorksView:recentWorkPhotsAry];
                                
                                [self aboutView:[technicalSummary objectForKey:@"comments"]];
                                
                                [self commentsView:[dictProfile objectForKey:@"comments"]];
                                
                            });
                            
                        }
                    }
                }
                
            }] resume];
}

#pragma mark - COVER PHOTO VIEW

- (void)setCoverView:(NSDictionary *)dictProfile
{
    coverImg = [[UIImageView alloc] init];
    [coverImg setFrame:CGRectMake(0, 0, viewWidth, 180)];
    [mainScrlView addSubview:coverImg];
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
//    visualEffectView.alpha = 0.95;
    
    visualEffectView.frame = coverImg.bounds;
    [coverImg addSubview:visualEffectView];
    
    profileImg = [[UIImageView alloc] init];
    [profileImg setFrame:CGRectMake(viewWidth/2 - 45, 25, 90, 90)];
    [profileImg.layer setCornerRadius:45];
    [profileImg.layer setMasksToBounds:YES];
    [mainScrlView addSubview:profileImg];
    
    UIButton *buttonBack =  [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBack setImage:[UIImage imageNamed:@"back-icon.png"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(btnBackClick)forControlEvents:UIControlEventTouchUpInside];
    [buttonBack setFrame:CGRectMake(10, 16, 44 ,44)];
    [mainScrlView addSubview:buttonBack];
    
    UIButton *buttonShare =  [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonShare setImage:[UIImage imageNamed:@"share_selected.png"] forState:UIControlStateNormal];
    [buttonShare addTarget:self action:@selector(btnShareClick)forControlEvents:UIControlEventTouchUpInside];
    [buttonShare setFrame:CGRectMake(viewWidth - 52, 16, 24 ,24)];
    [mainScrlView addSubview:buttonShare];
    
    UIButton *buttonCall =  [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonCall setImage:[UIImage imageNamed:@"phone_technician.png"] forState:UIControlStateNormal];
    [buttonCall addTarget:self action:@selector(btnCallClick)forControlEvents:UIControlEventTouchUpInside];
    [buttonCall setFrame:CGRectMake(profileImg.frame.origin.x - 53, 55, 13 ,13)];
    [mainScrlView addSubview:buttonCall];
    
    UIButton *buttonMsg =  [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonMsg setImage:[UIImage imageNamed:@"chat_technician.png"] forState:UIControlStateNormal];
    [buttonMsg addTarget:self action:@selector(btnMsgClick)forControlEvents:UIControlEventTouchUpInside];
    [buttonMsg setFrame:CGRectMake(profileImg.frame.origin.x + profileImg.frame.size.width + 20, 55, 13 ,13)];
    [mainScrlView addSubview:buttonMsg];
    
    if ([[dictProfile objectForKey:@"goldpartner"] boolValue])
    {
        UIImageView *crownImg = [[UIImageView alloc] init];
        [crownImg setFrame:CGRectMake(viewWidth/2 + 20, 85, 25, 25)];
        [crownImg setImage:[UIImage imageNamed:@"crown"]];
        [mainScrlView addSubview:crownImg];
    }
    
    lblTechnicianName = [[UILabel alloc]init];
    [lblTechnicianName setFrame:CGRectMake(0, profileImg.frame.origin.y + profileImg.frame.size.height + 10, viewWidth,20)];
    [lblTechnicianName setFont:[UIFont fontWithName:kRobotoMedium size:14]];
    [lblTechnicianName setBackgroundColor:[UIColor clearColor]];
    [lblTechnicianName setTextAlignment:NSTextAlignmentCenter];
    [lblTechnicianName setTextColor:[UIColor whiteColor]];
    [mainScrlView addSubview:lblTechnicianName];
    
    UIView *starsView = [[UIView alloc] init];
    starsView = [self starsRatingView:[dictProfile objectForKey:@"ratings"]];
    [mainScrlView addSubview:starsView];
    
    briefCaseImg = [[UIImageView alloc] init];
    [briefCaseImg setFrame:CGRectMake(viewWidth/2 - 7, profileImg.frame.origin.y + profileImg.frame.size.height + 40, 13, 12)];
    [briefCaseImg setImage:[UIImage imageNamed:@"briefcase"]];
    [mainScrlView addSubview:briefCaseImg];
    
    lblTechnicianExp = [[UILabel alloc]init];
    [lblTechnicianExp setFrame:CGRectMake(viewWidth/2 + 15, profileImg.frame.origin.y + profileImg.frame.size.height + 38, 120,16)];
    [lblTechnicianExp setFont:[UIFont fontWithName:kRobotoRegular size:10]];
    [lblTechnicianExp setBackgroundColor:[UIColor clearColor]];
    [lblTechnicianExp setTextAlignment:NSTextAlignmentLeft];
    [lblTechnicianExp setTextColor:[UIColor whiteColor]];
    [mainScrlView addSubview:lblTechnicianExp];
    
    //CHARGES AND DISTANCE VIEW
    
    UIView *chargesView = [[UIView alloc] init];
    [chargesView setFrame:CGRectMake(0, 180, viewWidth, 50)];
    [chargesView setBackgroundColor:[UIColor whiteColor]];
    [mainScrlView addSubview:chargesView];
    
    UIImageView *locationImg = [[UIImageView alloc] init];
    [locationImg setFrame:CGRectMake(25, 19, 11, 14)];
    [locationImg setImage:[UIImage imageNamed:@"locationAway"]];
    [chargesView addSubview:locationImg];
    
    UILabel *lblDistance = [[UILabel alloc]init];
    [lblDistance setFrame:CGRectMake(45, 0, viewWidth/2 - 50, 50)];
    [lblDistance setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblDistance setBackgroundColor:[UIColor clearColor]];
    [lblDistance setTextAlignment:NSTextAlignmentLeft];
    [lblDistance setTextColor:[UIColor blackColor]];
    [lblDistance setText:[NSString stringWithFormat:@"%@km from you",[dictProfile objectForKey:@"kilometer"]]];
    [chargesView addSubview:lblDistance];
    
    UILabel *lblDivide = [[UILabel alloc]init];
    [lblDivide setFrame:CGRectMake(lblDistance.frame.origin.x + lblDistance.frame.size.width, 20, 1,14)];
    [lblDivide setBackgroundColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    [chargesView addSubview:lblDivide];
    
    UILabel *lblTechnicianCharge = [[UILabel alloc]init];
    [lblTechnicianCharge setFrame:CGRectMake(lblDivide.frame.origin.x + lblDivide.frame.size.width + 15, 0, 120,50)];
    [lblTechnicianCharge setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [lblTechnicianCharge setBackgroundColor:[UIColor clearColor]];
    [lblTechnicianCharge setTextColor:[UIColor blackColor]];
    [lblTechnicianCharge setText:[NSString stringWithFormat:@"Rs.%@ min charges",[dictProfile objectForKey:@"min_rate"]]];
    [chargesView addSubview:lblTechnicianCharge];
    
    [coverImg setBackgroundColor:[UIColor clearColor]];
    [profileImg setBackgroundColor:[UIColor clearColor]];
    
    NSString *stringCoverImg = [NSString stringWithFormat:@"%@",[dictProfile objectForKey:@"coverphoto"]];
    NSString *stringProfileImg = [NSString stringWithFormat:@"%@",[dictProfile objectForKey:@"photo"]];
    
    [coverImg sd_setImageWithURL:[NSURL URLWithString:stringCoverImg] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"]];
    [profileImg sd_setImageWithURL:[NSURL URLWithString:stringProfileImg] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"] ];
    
    [lblTechnicianName setText:[NSString stringWithFormat:@"%@",[dictProfile objectForKey:@"name"]]];
    
    NSDictionary *dictProfessional = [dictProfile objectForKey:@"user_professioanl"];
    [lblTechnicianExp setText:[NSString stringWithFormat:@"%@ yr experience",[dictProfessional objectForKey:@"experience_year"]]];
}

#pragma mark - TECHNICAL SUMMARY

- (void)technicianSummary:(NSString *)title withDescription:(NSString *)description
{
    
    UIView *summaryView = [[UIView alloc] init];
    [summaryView setFrame:CGRectMake(0, yPos, viewWidth, 62)];
    [summaryView setBackgroundColor:[UIColor whiteColor]];
    [mainScrlView addSubview:summaryView];
    
    UILabel *lblHeader = [[UILabel alloc]init];
    [lblHeader setFrame:CGRectMake(20, 5, 250, 25)];
    [lblHeader setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblHeader setBackgroundColor:[UIColor clearColor]];
    [lblHeader setTextColor:kHeadingTextColor];
    [lblHeader setText:title];
    [summaryView addSubview:lblHeader];
    
    if ([title isEqualToString:@"EXPERTISE IN"])
    {
        UITextView *textView = [[UITextView alloc] init];
        [textView setFrame:CGRectMake(20, 30, viewWidth - 25, 100)];
        [textView setText:description];
        [textView setFont:[UIFont fontWithName:kRobotoRegular size:14]];
        [textView setTextAlignment:NSTextAlignmentJustified];
        [textView setTextColor:[UIColor blackColor]];
        [textView setBackgroundColor:[UIColor clearColor]];
        [textView setEditable:NO];
        [summaryView addSubview:textView];
        
        CGRect frame = textView.frame;
        frame.size.height = textView.contentSize.height;
        textView.frame = frame;
        
        CGRect viewFrame = summaryView.frame;
        viewFrame.size.height = textView.contentSize.height + 35;
        summaryView.frame = viewFrame;
        
        yPos += summaryView.frame.size.height + 1;
    }
    else
    {
        UILabel *lblDescription = [[UILabel alloc]init];
        [lblDescription setFrame:CGRectMake(20, 30, viewWidth - 25,25)];
        [lblDescription setFont:[UIFont fontWithName:kRobotoRegular size:14]];
        [lblDescription setBackgroundColor:[UIColor clearColor]];
        [lblDescription setTextColor:[UIColor blackColor]];
        [lblDescription setText:[NSString stringWithFormat:@"%@",description]];
        [summaryView addSubview:lblDescription];
        
        yPos += 63;
    }
}

#pragma mark - RECENT WORK PHOTOS VIEW

- (void)recentWorksView:(NSArray *)aryRecentWorks
{
    UIView *recentWorksView = [[UIView alloc] init];
    [recentWorksView setFrame:CGRectMake(0, yPos + 10, viewWidth, 128)];
    [recentWorksView setBackgroundColor:[UIColor whiteColor]];
    [mainScrlView addSubview:recentWorksView];
    
    UILabel *lblHeader = [[UILabel alloc]init];
    [lblHeader setFrame:CGRectMake(20, 5, 250, 25)];
    [lblHeader setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblHeader setBackgroundColor:[UIColor clearColor]];
    [lblHeader setTextColor:kHeadingTextColor];
    [lblHeader setText:@"RECENT WORK PHOTOS"];
    [recentWorksView addSubview:lblHeader];
    
    int xPos = 20;
    
    UIScrollView *imgScrlView = [[UIScrollView alloc] init];
    [imgScrlView setFrame:CGRectMake(20, 35, viewWidth - 20, 75)];
    [imgScrlView setShowsVerticalScrollIndicator:NO];
    [imgScrlView setShowsHorizontalScrollIndicator:NO];
    [imgScrlView setBackgroundColor:[UIColor clearColor]];
    [recentWorksView addSubview:imgScrlView];
    
    for (int i = 0; i<aryRecentWorks.count; i++)
    {
        NSString *stringUrl = [[aryRecentWorks objectAtIndex:i] objectForKey:@"image"];
        UIImageView *recentImg = [[UIImageView alloc] init];
        [recentImg setFrame:CGRectMake(xPos, 0, 72, 72)];
        [recentImg.layer setMasksToBounds:YES];
        [recentImg.layer setBorderWidth:1.5];
        [recentImg.layer setBorderColor:kHeadingTextColor.CGColor];
        [recentImg sd_setImageWithURL:[NSURL URLWithString:stringUrl] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"]];
        [imgScrlView addSubview:recentImg];
        
        xPos += 80;
        
        [imgScrlView setContentSize:CGSizeMake(xPos, 75)];
    }
    
}

#pragma mark - ABOUT TECHNICIAN VIEW

- (void)aboutView:(NSString *)description
{
    aboutView = [[UIView alloc] init];
    [aboutView setFrame:CGRectMake(0, yPos + 148, viewWidth, 140)];
    [aboutView setBackgroundColor:[UIColor whiteColor]];
    [mainScrlView addSubview:aboutView];
    
    UILabel *lblHeader = [[UILabel alloc]init];
    [lblHeader setFrame:CGRectMake(20, 5, 250, 25)];
    [lblHeader setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblHeader setBackgroundColor:[UIColor clearColor]];
    [lblHeader setTextColor:kHeadingTextColor];
    [lblHeader setText:@"ABOUT US"];
    [aboutView addSubview:lblHeader];
    
    UITextView *textView = [[UITextView alloc] init];
    [textView setFrame:CGRectMake(20, 30, viewWidth - 25, 100)];
    [textView setText:description];
    [textView setFont:[UIFont fontWithName:kRobotoRegular size:14]];
    [textView setTextAlignment:NSTextAlignmentJustified];
    [textView setTextColor:[UIColor blackColor]];
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setEditable:NO];
    [aboutView addSubview:textView];
    
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    textView.frame = frame;
    
    CGRect viewFrame = aboutView.frame;
    viewFrame.size.height = textView.contentSize.height + 35;
    aboutView.frame = viewFrame;
    
    [mainScrlView setContentSize:CGSizeMake(viewWidth, 1500)];
}

#pragma mark - COMMENTS VIEW

- (void)commentsView:(NSArray *)aryComments
{
    NSLog(@"commentsView VIEW %f",aboutView.frame.origin.y + aboutView.frame.size.height);
    
    aryComents = [NSArray arrayWithArray:aryComments];
    
    UIView *commentsView = [[UIView alloc] init];
    [commentsView setFrame:CGRectMake(0, aboutView.frame.origin.y + aboutView.frame.size.height + 10, viewWidth, 140)];
    [commentsView setBackgroundColor:[UIColor whiteColor]];
    [mainScrlView addSubview:commentsView];
    
    UILabel *lblHeader = [[UILabel alloc]init];
    [lblHeader setFrame:CGRectMake(20, 5, 250, 25)];
    [lblHeader setFont:[UIFont fontWithName:kRobotoRegular size:12]];
    [lblHeader setBackgroundColor:[UIColor clearColor]];
    [lblHeader setTextColor:kHeadingTextColor];
    [lblHeader setText:@"COMMENTS"];
    [commentsView addSubview:lblHeader];
    
    int yPosV = 35;
    int aryCount = 2;
    
    if (showMoreComments)
    {
        aryCount = (int)[aryComments count];
    }
    
    for (int i = 0; i < aryCount; i++)
    {
        
        NSDictionary *dict = [aryComments objectAtIndex:i];
        
        NSString *strUrl = [dict objectForKey:@"photo"];
        
        NSLog(@"Strurl %@",strUrl);
        
        if (strUrl == [NSNull null])
        {
            strUrl = @"";
        }
        
        UIImageView *profilePic = [[UIImageView alloc] init];
        [profilePic setFrame:CGRectMake(20, yPosV, 45, 45)];
        [profilePic.layer setCornerRadius:22.5];
        [profilePic.layer setMasksToBounds:YES];
        [commentsView addSubview:profilePic];
        
        if (![strUrl isEqualToString:@""] || ![strUrl isEqualToString:@"null"] || ![strUrl isEqualToString:@"(null)"] || strUrl != nil || strUrl != [NSNull null]) {
            
            [profilePic sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"]];
        }
        else
        {
            [profilePic setImage:[UIImage imageNamed:@"noimagePlaceholder.jpg"]];
        }
        
        UILabel *userName = [[UILabel alloc] init];
        [userName setFrame:CGRectMake(75, yPosV + 5, 200, 20)];
        [userName setTextColor:[UIColor blackColor]];
        [userName setTextAlignment:NSTextAlignmentLeft];
        [userName setFont:[UIFont fontWithName:kRobotoRegular size:14]];
        [userName setText:[NSString stringWithFormat:@"User %d",i]];
        [commentsView addSubview:userName];
        
        UIView *starView = [[UIView alloc] init];
        starView = [self starsRatingView:[dict objectForKey:@"rating"]];
        [starView setFrame:CGRectMake(75, yPosV + 30, 50, 10)];
        [commentsView addSubview:starView];

        UITextView *textView = [[UITextView alloc] init];
        [textView setFrame:CGRectMake(20, yPosV + 45, viewWidth - 25, 200)];
        [textView setText:[dict objectForKey:@"comment"]];
        [textView setFont:[UIFont fontWithName:kRobotoRegular size:14]];
        [textView setTextAlignment:NSTextAlignmentJustified];
        [textView setTextColor:[UIColor blackColor]];
        [textView setBackgroundColor:[UIColor clearColor]];
        [textView setEditable:NO];
        [commentsView addSubview:textView];
        
        CGRect frame = textView.frame;
        frame.size.height = textView.contentSize.height;
        textView.frame = frame;
        
        UILabel *line = [[UILabel alloc] init];
        [line setFrame:CGRectMake(0, frame.origin.y + frame.size.height + 10, viewWidth, 1)];
        [line setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
        [commentsView addSubview:line];
        
        yPosV += 60 + textView.frame.size.height;
        
        if (i == 1 && !showMoreComments)
        {
            UIView *showMoreView = [[UIView alloc] init];
            [showMoreView setFrame:CGRectMake(0, yPosV, viewWidth, 44)];
            [showMoreView setBackgroundColor:[UIColor clearColor]];
            [commentsView addSubview:showMoreView];
            
            UIButton *btnShowMore = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnShowMore setFrame:CGRectMake(0, 0, 200, 44)];
            [btnShowMore setTitle:@"See more comments" forState:UIControlStateNormal];
            [btnShowMore setTitleColor:[UIColor colorWithRed:153.0/255.0 green:63.0/255.0 blue:233.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [btnShowMore.titleLabel setFont:[UIFont fontWithName:kRobotoRegular size:14]];
            [btnShowMore addTarget:self action:@selector(btnShowMoreComments) forControlEvents:UIControlEventTouchUpInside];
            [showMoreView addSubview:btnShowMore];
            
            yPosV += 50;
        }
    }
    
    CGRect viewFrame = commentsView.frame;
    viewFrame.size.height = yPosV;
    commentsView.frame = viewFrame;
    
    [mainScrlView setContentSize:CGSizeMake(viewWidth, commentsView.frame.origin.y + commentsView.frame.size.height)];
}

#pragma mark - RATINGS VIEW

- (UIView *)starsRatingView:(NSString *)rating
{
    int ratingNum = [rating intValue];
    
    UIView *ratingView = [[UIView alloc] init];
    [ratingView setFrame:CGRectMake(viewWidth/2 - 75, profileImg.frame.origin.y + profileImg.frame.size.height + 40, 55, 11)];
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

#pragma mark - BUTTON CLICKS

- (void)btnShowMoreComments
{
    showMoreComments = YES;
    
    [self commentsView:aryComents];
}

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnShareClick
{
    NSLog(@"SHARE");
}

- (void)btnCallClick
{
    NSLog(@"CALL");
}

- (void)btnMsgClick
{
    NSLog(@"MSG");
}

#pragma mark - BOOK CLICKED

- (void)bookClicked
{
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
