//  SideMenuViewController.m
//  MFSideMenuDemo
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "DemoViewController.h"
#import "Profile.h"
#import "SideTableViewCell.h"

#import "serviceApp-Swift.h"

@class UIApplication;
//#import "AppDelegate"

@implementation SideMenuViewController
{
    NSString *userType;
    NSMutableArray *array;

    AppDelegate *appDelegate;

}
-(void) viewWillAppear:(BOOL)animated
{
    NSLog(@"clicked");
}
- (void) viewWillLayoutSubviews
{
    

    
}
-(void) receiveTestNotification
{
    [self viewDidLoad];
    
    [self tableView:self.tableView viewForHeaderInSection:0];
    
    //  [self.tableView reloadData];
}

- (void) viewDidDisappear:(BOOL)animated
{
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    array = [[NSMutableArray alloc] init];
    
    [array addObject:_strF];

  //  appDelegate.window.backgroundColor = self.tableView.backgroundColor;
    
    self.tableView.scrollEnabled=NO;
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
    
    view.backgroundColor=[UIColor yellowColor];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.1686 green:0.1725 blue:0.1804 alpha:1.0];
    
    
    userType  = [[NSUserDefaults standardUserDefaults]objectForKey:@"type"];
    
    NSLog(@"%@---View Size:-----Frame---->",view);
    
    
    NSLog(@"%@---Table Size:-----Frame---->",self.tableView);

    
    
 //   [appDelegate.window.rootViewController.view addSubview:view];
    
//    delegate = [UIApplication sharedApplication].delegate;
    
    
}


#pragma mark - UITableViewDataSource

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    Profile *profileview = [[[NSBundle mainBundle] loadNibNamed:@"Profile" owner:self options:nil] objectAtIndex:0];
    
    [profileview setFrame:CGRectMake(0, 0, tableView.frame.size.width, 110)];

    [profileview.profileBtn addTarget:self action:@selector(goClear) forControlEvents:UIControlEventTouchUpInside];
    
    profileview.profileimage.layer.cornerRadius = profileview.profileimage.frame.size.width / 2;
    
    profileview.profileimage.clipsToBounds = YES;
    
    
    [profileview.username setText:[array objectAtIndex:0]];

    
    profileview.emailLbl.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    
    return profileview;
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
//    [label setFont:[UIFont boldSystemFontOfSize:12]];
//    NSString *string =@"Himanshu";
//    
//    /* Section header is in 0th index... */
//    [label setText:string];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return profileview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 110;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 8)
    {
        return 400;
    }
    else
    {
        return 60;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (delegate.forCheckSignUp == 0)
//    {
    
    if ([userType isEqualToString: @"3"])
    {
        return 10;
    }
    else
    {
        return 9;

    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    SideTableViewCell *cell = (SideTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SideTableViewCell" owner:self options:nil] objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([userType isEqualToString:@"3"])
    {
       NSString *bothType  = [[NSUserDefaults standardUserDefaults]objectForKey:@"bothUser"];

        switch(indexPath.row)
        {
            case 0:
                
                cell.imgName.image = [UIImage imageNamed:@"switch"];
                
                if ([bothType isEqualToString: @"Customer"])
                {
                    
                    cell.nameLbl.text = @"Switch account to Provider";
                    break;
                }
                else
                {
                    cell.nameLbl.text = @"Switch account to Customer";
                    break;
                }
                
                break;
                
            case 1:
                
                cell.imgName.image = [UIImage imageNamed:@"Home"];
                cell.nameLbl.text = @"Home";
                break;
                
            case 2:
                if ([bothType isEqualToString: @"Customer"])
                {
                    cell.imgName.image = [UIImage imageNamed:@"Servive Booking"];
                    cell.nameLbl.text = @"Service Booking";
                    break;
                }
                else
                {
                    cell.imgName.image = [UIImage imageNamed:@"Servive Booking"];
                    cell.nameLbl.text = @"Weekly Appointment";
                    break;
                }
                
            case 3:
                
                cell.imgName.image = [UIImage imageNamed:@"Active_Service"];
                cell.nameLbl.text = @"Active Services";
                break;
                
            case 4:
                
                cell.imgName.image = [UIImage imageNamed:@"Past service"];
                cell.nameLbl.text = @"Past Services";
                break;
                
                
            case 5:
                
                cell.imgName.image = [UIImage imageNamed:@"Push Provider_profile"];
                cell.nameLbl.text = @"Push Provider Services";
                break;
                
                
            case 6:
                
                cell.imgName.image = [UIImage imageNamed:@"Push customer profile"];
                cell.nameLbl.text = @"Push Customer Profile";
                break;
            case 7:
                
                cell.imgName.image = [UIImage imageNamed:@"bank"];
                cell.nameLbl.text = @"Bank Account Information";
                break;
            case 8:
                
                cell.imgName.image = [UIImage imageNamed:@"logout"];
                cell.nameLbl.text = @"Logout";
                break;
            case 9:
                
                cell.imgName.image = [UIImage imageNamed:@""];
                cell.nameLbl.text = @"";
                break;
            default:
                ;
                
        }
    }
    else
    {
        switch(indexPath.row)
        {
            case 0:
                
                cell.imgName.image = [UIImage imageNamed:@"Home"];
                cell.nameLbl.text = @"Home";
                break;
                
            case 1:
                if ([userType isEqualToString: @"1"])
                {
                    cell.imgName.image = [UIImage imageNamed:@"Servive Booking"];
                    cell.nameLbl.text = @"Service Booking";
                    break;
                }
                else
                {
                    cell.imgName.image = [UIImage imageNamed:@"Servive Booking"];
                    cell.nameLbl.text = @"Weekly Appointment";
                    break;
                }
                
            case 2:
                
                cell.imgName.image = [UIImage imageNamed:@"Active_Service"];
                cell.nameLbl.text = @"Active Services";
                break;
                
            case 3:
                
                cell.imgName.image = [UIImage imageNamed:@"Past service"];
                cell.nameLbl.text = @"Past Services";
                break;
                
                
            case 4:
                
                cell.imgName.image = [UIImage imageNamed:@"Push Provider_profile"];
                cell.nameLbl.text = @"Push Provider Services";
                break;
                
                
            case 5:
                
                cell.imgName.image = [UIImage imageNamed:@"Push customer profile"];
                cell.nameLbl.text = @"Push Customer Profile";
                break;
            case 6:
                
                cell.imgName.image = [UIImage imageNamed:@"bank"];
                cell.nameLbl.text = @"Bank Account Information";
                break;
            case 7:
                
                cell.imgName.image = [UIImage imageNamed:@"logout"];
                cell.nameLbl.text = @"Logout";
                break;
            case 8:
                
                cell.imgName.image = [UIImage imageNamed:@""];
                cell.nameLbl.text = @"";
                break;
            default:
                ;
                
        }
    }
    

    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [cell setSelectedBackgroundView:view];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([userType isEqualToString:@"3"])
    {
        NSString *bothType  = [[NSUserDefaults standardUserDefaults]objectForKey:@"bothUser"];

        {
            if (indexPath.row == 0)
            {
                
                if ([bothType isEqualToString:@"Customer"])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:@"Provider" forKey:@"bothUser"];
                    
                    {
                        UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProviderHomeViewController"];
                        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                        NSArray *controllers = [NSArray arrayWithObject:SKVC];
                        navigationController.viewControllers = controllers;
                        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                    }

                }
                else
                {
                    [[NSUserDefaults standardUserDefaults] setObject:@"Customer" forKey:@"bothUser"];

                    {
                        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isCallFromLoginAndSignUp"];
                        UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CustDashboardViewController"];
                        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                        NSArray *controllers = [NSArray arrayWithObject:SKVC];
                        navigationController.viewControllers = controllers;
                        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                    }
                    
                }
                
                [tableView reloadData];
                
            }
            
           else if (indexPath.row == 1)
            {
                
                if ([bothType isEqualToString:@"Customer"])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isCallFromLoginAndSignUp"];
                    UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CustDashboardViewController"];
                    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                    NSArray *controllers = [NSArray arrayWithObject:SKVC];
                    navigationController.viewControllers = controllers;
                    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                }
                else
                {
                    UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProviderHomeViewController"];
                    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                    NSArray *controllers = [NSArray arrayWithObject:SKVC];
                    navigationController.viewControllers = controllers;
                    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                }
                
                
            }
            else if (indexPath.row == 2)
            {
                
                if ([bothType isEqualToString:@"Customer"])
                {
                    HomeViewController *demoController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"Comparing" object:nil];
                    
                    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                    NSArray *controllers = [NSArray arrayWithObject:demoController];
                    navigationController.viewControllers = controllers;
                    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];        }
                else
                {
                    UpcomingEventsViewController *demoController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UpcomingEventsViewController"];
                    
                    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                    NSArray *controllers = [NSArray arrayWithObject:demoController];
                    navigationController.viewControllers = controllers;
                    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                }
                
                
                
            }
            else if (indexPath.row == 3)
            {
                ActiceServiceViewController *demoController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ActiceServiceViewController"];
                [[NSUserDefaults standardUserDefaults]setObject:@"Active" forKey:@"Comparing"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:demoController];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                
                
            }
            
            else if (indexPath.row == 4)
            {
                UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ActiceServiceViewController"];
                [[NSUserDefaults standardUserDefaults]setObject:@"Past" forKey:@"Comparing"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:SKVC];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                
                
            }
            
            else if (indexPath.row == 5)
            {
                UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SingleServiceViewController"];
                [[NSUserDefaults standardUserDefaults]setObject:@"provider" forKey:@"Comparing"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:SKVC];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                
                
            }
            else if (indexPath.row == 6)
            {
                UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SingleServiceViewController"];
                [[NSUserDefaults standardUserDefaults]setObject:@"customer" forKey:@"Comparing"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:SKVC];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                
                
            }
            else if (indexPath.row == 7)
            {
                if ([bothType isEqualToString:@"Customer"])
                {
                    UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BankInfoViewController"];
                    
                    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                    NSArray *controllers = [NSArray arrayWithObject:SKVC];
                    navigationController.viewControllers = controllers;
                    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

                }
                else
                {
                    UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AccountInfoViewController"];
                    
                    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                    NSArray *controllers = [NSArray arrayWithObject:SKVC];
                    navigationController.viewControllers = controllers;
                    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                    
                }
                
                
                
                
            }
            else if (indexPath.row == 8)
            {
                
                [self logoutService];
            }
            
            
        }
    }
   else
   {

        if (indexPath.row == 0)
        {
            
            NSString *userType =  [[NSUserDefaults standardUserDefaults]objectForKey:@"type"];
            
            if ([userType isEqualToString:@"1"])
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isCallFromLoginAndSignUp"];
                UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CustDashboardViewController"];
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:SKVC];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            }
            else
            {
                UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProviderHomeViewController"];
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:SKVC];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            }
            
           
        }
       else if (indexPath.row == 1)
        {
            
            
            
            
            if ([userType isEqualToString:@"1"])
            {
                HomeViewController *demoController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Comparing" object:nil];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:demoController];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];        }
            else
            {
                UpcomingEventsViewController *demoController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UpcomingEventsViewController"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:demoController];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            }
            
            
           
        }
        else if (indexPath.row == 2)
        {
            ActiceServiceViewController *demoController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ActiceServiceViewController"];
            [[NSUserDefaults standardUserDefaults]setObject:@"Active" forKey:@"Comparing"];

            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:demoController];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
            
        }
       
        else if (indexPath.row == 3)
        {
            UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ActiceServiceViewController"];
            [[NSUserDefaults standardUserDefaults]setObject:@"Past" forKey:@"Comparing"];

            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:SKVC];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
            
        }
       
        else if (indexPath.row == 4)
        {
            UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SingleServiceViewController"];
            [[NSUserDefaults standardUserDefaults]setObject:@"provider" forKey:@"Comparing"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:SKVC];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
            
        }
        else if (indexPath.row == 5)
        {
            UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SingleServiceViewController"];
            [[NSUserDefaults standardUserDefaults]setObject:@"customer" forKey:@"Comparing"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:SKVC];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            
            
        }
        else if (indexPath.row == 6)
        {
            
            if ([userType isEqualToString: @"1"])
            {
                UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BankInfoViewController"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:SKVC];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                
            }
            else
            {
                UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AccountInfoViewController"];
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                NSArray *controllers = [NSArray arrayWithObject:SKVC];
                navigationController.viewControllers = controllers;
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                
            }
          
            
        }
        else if (indexPath.row == 7)
        {

                [self logoutService];
        }
     
       
   }
}

- (void) goClear
{
    view.backgroundColor=[UIColor clearColor];

    NSString *bothType  = [[NSUserDefaults standardUserDefaults]objectForKey:@"bothUser"];

    
    if ([bothType isEqualToString:@"Customer"])
    {
        UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
        
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:SKVC];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else
    {
        if ([userType isEqualToString: @"1"])
        {
            UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:SKVC];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
        else
        {
            UIViewController  *SKVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProviderProfileViewController"];
            
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:SKVC];
            navigationController.viewControllers = controllers;
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
        
  
    }
}


- (void) logoutService
{//validate it
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"bothUser"];

//    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"User! loggedout successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    alert.tag = 1;
//    [alert show];

    
    LoginViewController *demoController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controllers = [NSArray arrayWithObject:demoController];
    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    
    NSError* error;
    
    NSString *authStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"auth_code"];
    
   NSDictionary  *params = @{@"auth_code":authStr};
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error: &error];
    
    NSURL* url = [NSURL URLWithString:@"http://recur.mobi/api/v1/logout"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"POST"];//use POST
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // [request setValue:[NSString stringWithFormat:@"%d",[jsonData length]] forHTTPHeaderField:@"Content-length"];
    
    [request setHTTPBody:jsonData];//set data
    
    __block NSError *error1 = [[NSError alloc] init];
    
    
    
    //use async way to connect network
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse* response,NSData* data,NSError* error)
     
     {
         //       [self hideLoader];
         
         if ([data length]>0 && error == nil)
         {
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"auth_code"];

             NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             
             NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
             
             NSLog(@"resultsDictionary is %@",resultsDictionary);

             
             
         }
         else if ([data length]==0 && error ==nil)
         {
             
             NSLog(@" download data is null");
             
         }
         else if( error!=nil)
         {
             NSLog(@" error is %@",error);
             
         }
         
     }];
}


@end
