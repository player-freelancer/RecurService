//
//  SideMenuViewController.h
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import <UIKit/UIKit.h>
//#import "Fuel_Table.h"
@interface SideMenuViewController : UITableViewController<NSURLConnectionDelegate>
{
    UIView *view;
    NSMutableData *_responseData;

    
//    AppDelegate *delegate;
}
@property (strong, nonatomic) NSString *strF;

-(void) receiveTestNotification;
@end
