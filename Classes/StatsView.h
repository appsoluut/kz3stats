//
//  StatsView.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/27/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface StatsView : UIView {
	// Fields
	NSString *name;
    int kills;
	
	// UI Elements
	UIScrollView *scrollView;
	UILabel *labelName;
    UILabel *labelKills;
	
	// Icons
	UIImageView *imageKills;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int kills;

- (void)fillFields;

@end
