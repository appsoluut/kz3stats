//
//  KZ3StatsAppDelegate.m
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/22/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import "KZ3StatsAppDelegate.h"

@implementation KZ3StatsAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	// Setup database
	db = [[Database alloc] init];
	
    // Override point for customization after application launch.
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self.window setBackgroundColor:[UIColor whiteColor]];
	
	//friendsListViewController = [[FriendsListViewController alloc] init];
	//[self.window addSubview:[friendsListViewController view]];
	
    // UINavigation
	statsViewController = [[StatsViewController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
	[statsViewController setDb:db];

	navigationController = [[UINavigationController alloc] initWithRootViewController:statsViewController];
	[[navigationController navigationBar] setBarStyle:UIBarStyleBlackOpaque];
	[self.window addSubview:[navigationController view]];
	
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[db release];
	[friendsListViewController release];
	[statsViewController release];
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
