//
//  StatsViewController.m
//  KZ3Stats
//
//  Created by Paul ; on 3/27/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import "StatsViewController.h"


@implementation StatsViewController
@synthesize db;

#pragma mark -
#pragma mark Setup Views
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[self setTitle:@"KZ3 Stats"];
		
		UIBarButtonItem *friendsButton = [[UIBarButtonItem alloc] initWithTitle:@"Friends" style:UIBarButtonItemStyleBordered target:self action:@selector(friendsButtonClicked:)];
		self.navigationItem.rightBarButtonItem = friendsButton;
		[friendsButton release];
		
		UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonClicked:)];
		self.navigationItem.leftBarButtonItem = reloadButton;
		[reloadButton release];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
	[[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]]];
    
    isShowingAd = NO;
    
    bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    [bannerView setAdUnitID:@"a14e01ce52c65fc"];
    [bannerView setRootViewController:self];
    [bannerView setDelegate:self];
    [[self view] addSubview:bannerView];
    
    GADRequest *adRequest = [[GADRequest alloc] init];
    [adRequest setTestDevices:[NSArray arrayWithObjects:GAD_SIMULATOR_ID, @"a9e83bc49292868ebfc3b3906f8bd94050524535", nil]];
    [adRequest setKeywords:[NSArray arrayWithObjects:@"Killzone", @"gaming", @"statistics", @"achievement", @"games", nil]];
    
    [bannerView loadRequest:adRequest];
    [adRequest release], adRequest = nil;
	
	friends = [[NSArray alloc] initWithArray:[self.db readFriendsFromDatabase]];
	
	NSUInteger capacity = 3;
	if ([friends count] < capacity) {
		capacity = [friends count];
	}
	
	statsViews = [[NSMutableArray alloc] initWithCapacity:capacity];
	
	scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
	[scrollView setAlwaysBounceHorizontal:YES];
	[scrollView setContentSize:CGSizeMake(320 * [friends count], scrollView.frame.size.height)];
	[scrollView setPagingEnabled:YES];
	[scrollView setDelegate:self];
	[[self view] addSubview:scrollView];
	
	// Setup initial statistic views
	for (int index = 0; index < capacity; index++) {
		Friend *friend = [friends objectAtIndex:index];
		
		StatsView *statsView = [[StatsView alloc] initWithFrame:CGRectMake(20 + (index * self.view.bounds.size.width), 20, self.view.bounds.size.width - 40, 376)];
		[statsView setName:[friend name]];
		[statsView fillFields];
		
		[statsViews insertObject:statsView atIndex:index];
		[scrollView addSubview:statsView];
        [statsView release], statsView = nil;
	}
	
	currentPage = 0;
}

#pragma mark -
#pragma mark scrollView Delegates
- (void)scrollViewDidScroll:(UIScrollView *)sv {
	// Calculate the new page index
	NSUInteger newPage = sv.contentOffset.x / sv.frame.size.width;
	
	// Do nothing if the page stays the same (occurs when bouncing)
	if (newPage == currentPage) {
		return;
	}

	// Determine the index of the first page
	NSInteger indexOffset = 0;
	NSInteger pageSelect = currentPage;
	if (newPage < currentPage) {
		indexOffset = -1;
		pageSelect = currentPage - 1;
	}
		
	int objIndex = 0;
	for (int index = 0 + indexOffset; index < (int)([statsViews count] + indexOffset); index++) {
		// If the page index is lower than 0 or higher than the item count of friends break out of this loop
		if (pageSelect + index < 0 || pageSelect + index > [friends count] - 1) {
			break;
		}
		
		// Get friend data for current view
		Friend *friend = [friends objectAtIndex:pageSelect + index];
		StatsView *statView = [statsViews objectAtIndex:objIndex];
		
		// Calculate the new horizontal position of the view
		CGRect statRect = [statView frame];
		statRect.origin.x = 20 + ((pageSelect + index) * self.view.bounds.size.width);
		
		// Set data
		[statView setFrame:statRect];
		[statView setName:[friend name]];
		[statView fillFields];
		
		objIndex++;
	}
	
	// Update the current page index
	currentPage = newPage;
}

#pragma mark -
#pragma mark Memory
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [bannerView release];
    bannerView = nil;
	
	[scrollView release];
	scrollView = nil;
	
	[statsViews release];
	statsViews = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark - Banner View Delegate
- (void)adViewDidReceiveAd:(GADBannerView *)view {
    // Only perform this action when there is no ad currently showing
    if( !isShowingAd ) {
        // Resize the scrollview to make room for the banner view
        // Slide in the banner view with an animation
        [UIView animateWithDuration:0.2
                         animations:^{
                             CGRect scrollViewRect = [scrollView frame];
                             scrollViewRect.size.height -= GAD_SIZE_320x50.height;
                             [scrollView setFrame:scrollViewRect];
                             [scrollView setContentSize:CGSizeMake([friends count] * scrollViewRect.size.width, scrollViewRect.size.height)];
                             
                             CGRect adViewRect = [view frame];
                             adViewRect.origin.y = scrollViewRect.origin.y + scrollViewRect.size.height;
                             [view setFrame:adViewRect];
                             
                             // Resize statistic views (subviews)
                             for (StatsView *statsView in statsViews) {
                                 CGRect statsViewRect = [statsView frame];
                                 statsViewRect.size.height -= GAD_SIZE_320x50.height;
                                 [statsView setFrame:statsViewRect];
                             }
                         }];
        isShowingAd = YES;
    }
}


#pragma mark -
#pragma mark Buttons
- (void)friendsButtonClicked:(id)sender {
	FriendsListViewController *friendsListViewController = [[FriendsListViewController alloc] init];
	[friendsListViewController setDb:self.db];
	[self.navigationController pushViewController:friendsListViewController animated:YES];
	[friendsListViewController release];
}

- (void)refreshButtonClicked:(id)sender {
	for (Friend *friend in friends) {
		OverviewRequest *request = [[OverviewRequest alloc] init];
		[request setUsername:[friend name]];
		[request start];
		[request release];
	}
}

@end
