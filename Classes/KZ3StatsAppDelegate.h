//
//  KZ3StatsAppDelegate.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/22/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "FriendsListViewController.h"
#import "StatsViewController.h"

@interface KZ3StatsAppDelegate : NSObject <UIApplicationDelegate> {
	// Database
	Database *db;
	
	// Views
    UIWindow *window;
	FriendsListViewController *friendsListViewController;
	StatsViewController *statsViewController;
	
	// Navigation
	UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;

@end

