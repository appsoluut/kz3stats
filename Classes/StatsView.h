//
//  StatsView.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/27/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsView : UIView {
	// Fields
	NSString        * name;
    int               kills;
    int               xp;
    int               headshots;
    int               ribbons;
    float             kd;
	
	// UI Elements
	UIScrollView    * scrollView;
	UILabel         * labelName;
    UILabel         * labelKills;
    UILabel         * labelXP;
    UILabel         * labelHeadshots;
    UILabel         * labelRibbons;
    UILabel         * labelKd;
	
	// Icons
	UIImageView     * imageKills;
    UIImageView     * imageXP;
    UIImageView     * imageHeadshots;
    UIImageView     * imageRibbons;
    UIImageView     * imageKd;
}
@property (nonatomic, retain) NSString      * name;
@property (nonatomic, assign) int             kills;
@property (nonatomic, assign) int             xp;
@property (nonatomic, assign) int             headshots;
@property (nonatomic, assign) int             ribbons;
@property (nonatomic, assign) float           kd;

- (void)fillFields;

@end
