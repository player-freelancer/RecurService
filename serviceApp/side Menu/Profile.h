//
//  Profile.h
//  Laundry
//
//  Created by Gourav sharma on 1/29/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Profile : UIView
@property (strong, nonatomic) IBOutlet UIImageView *profileimage;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIButton *profileBtn;
@property (strong, nonatomic) IBOutlet UILabel *emailLbl;

@end
