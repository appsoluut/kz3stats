//
//  StatsViewController.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/27/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FriendsListViewController.h"
#import "Friends.h"
#import "StatsView.h"
#import "OverviewRequest.h"
#import "GADBannerView.h"


@interface StatsViewController : UIViewController <UIScrollViewDelegate, GADBannerViewDelegate> {
    NSFetchedResultsController  * fetchedResultsController;
    NSManagedObjectContext      * managedObjectContext;

	// Data
	NSArray                     * friends;
	NSUInteger                    currentPage;
	
	// Views
	UIScrollView                * scrollView;
	NSMutableArray              * statsViews;
    UILabel                     * labelNoFriendsTitle;
    UILabel                     * labelNoFriendsDescription;
    
    // Threads
    NSOperationQueue            * operationQueue;
    
    // Ads
    GADBannerView               * bannerView;
    BOOL                          isShowingAd;
}
@property (nonatomic, retain) NSFetchedResultsController    * fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext        * managedObjectContext;

@end
