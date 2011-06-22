//
//  FriendsListViewController.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/24/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "Friend.h"
//#import "AddFriendViewController.h"

@interface FriendsListViewController : UITableViewController <UIAlertViewDelegate, UITextFieldDelegate> {
	Database *db;
	
	NSMutableArray *friends;
	UITextField *username;
}
@property (nonatomic, retain) Database *db;

@end
