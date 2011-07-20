//
//  KZ3StatsAppDelegate.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/22/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Database.h"
#import "FriendsListViewController.h"
#import "StatsViewController.h"

@interface KZ3StatsAppDelegate : NSObject <UIApplicationDelegate> {
    // Core Data
    NSManagedObjectModel            * managedObjectModel;
    NSManagedObjectContext          * managedObjectContext;
    NSPersistentStoreCoordinator    * persistentStoreCoordinator;
    
	// Views
    UIWindow                        * window;
	FriendsListViewController       * friendsListViewController;
	StatsViewController             * statsViewController;
	
	// Navigation
	UINavigationController          * navigationController;
}
@property (nonatomic, retain) UIWindow                                  * window;
@property (nonatomic, retain, readonly) NSManagedObjectModel            * managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext          * managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator    * persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@end
