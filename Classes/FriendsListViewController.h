//
//  FriendsListViewController.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/24/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Friends.h"

@interface FriendsListViewController : UITableViewController <UIAlertViewDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController  * fetchedResultsController;
    NSManagedObjectContext      * managedObjectContext;
    NSMutableArray              * friendsObjects;

	NSMutableArray *friends;
	UITextField *username;
}
@property (nonatomic, retain) NSFetchedResultsController    * fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext        * managedObjectContext;

@end
