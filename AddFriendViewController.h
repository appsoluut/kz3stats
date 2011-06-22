//
//  AddFriendViewController.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/28/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Database.h"


@interface AddFriendViewController : UIViewController {
	// Database
	Database *db;
	
	// View elements
	UILabel *labelName;
	UITextView *inputName;
}
@property (nonatomic, retain) Database *db;

@end
