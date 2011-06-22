//
//  StatsViewController.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/27/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "FriendsListViewController.h"
#import "Friend.h"
#import "StatsView.h"
#import "OverviewRequest.h"
#import "GADBannerView.h"


@interface StatsViewController : UIViewController <UIScrollViewDelegate, GADBannerViewDelegate> {
	// Database
	Database        * db;
	
	// Data
	NSArray         * friends;
	NSUInteger        currentPage;
	
	// Views
	UIScrollView    * scrollView;
	NSMutableArray  * statsViews;
    
    // Ads
    GADBannerView   * bannerView;
    BOOL              isShowingAd;
}
@property (nonatomic, retain) Database *db;

@end
