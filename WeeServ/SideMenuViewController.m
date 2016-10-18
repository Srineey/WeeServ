//
//  SideMenuViewController.m
//  WeeServ
//
//  Created by saran c on 04/06/16.
//  Copyright © 2016 WeeServ. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SWRevealViewController.h"
#import "BookingHistoryViewController.h"
#import "GlobalResourcesViewController.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    menuItems = @[@"Home", @"My Account", @"Booking History", @"Invite Friends", @"Contact Us", @"Feedback", @"Notifications", @"Rate", @"Share", @"Partner With us",@"Logout"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *userProfileHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,70)];
    [userProfileHeader setTag:section];
    [userProfileHeader setBackgroundColor:[UIColor colorWithRed:100.0/255.0 green:89.0/255.0 blue:104.0/255.0 alpha:1.0]];
    
    UILabel *userName = [[UILabel alloc] init];
    [userName setFrame:CGRectMake(20, 10, userProfileHeader.frame.size.width - 50, 20)];
    [userName setBackgroundColor:[UIColor clearColor]];
    [userName setTextColor:[UIColor whiteColor]];
    [userName setText:@"Srinivasa Reddy"];
    [userProfileHeader addSubview:userName];
    
    UILabel *userEmail = [[UILabel alloc] init];
    [userEmail setFrame:CGRectMake(20, userName.frame.origin.y + userName.frame.size.height + 5, userProfileHeader.frame.size.width - 50, 20)];
    [userEmail setBackgroundColor:[UIColor clearColor]];
    [userEmail setTextColor:[UIColor whiteColor]];
    [userEmail setText:@"srinivasa.reddy@gmail.com"];
    [userProfileHeader addSubview:userEmail];
    
    UILabel *line = [[UILabel alloc] init];
    [line setFrame:CGRectMake(0, 69, userProfileHeader.frame.size.width, 1)];
    [line setBackgroundColor:[UIColor darkGrayColor]];
    [userProfileHeader addSubview:line];
    
    return userProfileHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setAccessoryView:nil];
        [cell setBackgroundColor:[UIColor colorWithRed:100.0/255.0 green:89.0/255.0 blue:104.0/255.0 alpha:1.0]];
    }
    
    cell.textLabel.text = [menuItems objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        [[GlobalResourcesViewController sharedManager] setIsFromMenu:YES];
        BookingHistoryViewController *bhv = [[BookingHistoryViewController alloc] init];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[bhv] animated: NO ];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
