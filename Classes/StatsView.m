//
//  StatsView.m
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/27/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import "StatsView.h"


@implementation StatsView
@synthesize name;
@synthesize kills;
@synthesize xp;
@synthesize headshots;
@synthesize ribbons;
@synthesize kd;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
		
		// Place UI Elements
		scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(3, 3, self.frame.size.width - 6, self.frame.size.height - 6)];
		[scrollView setAlwaysBounceVertical:YES];
		[self addSubview:scrollView];
		
		labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, scrollView.frame.size.width, 32)];
		[labelName setBackgroundColor:[UIColor clearColor]];
		[labelName setTextColor:[UIColor colorWithRed:235/255.0f green:135/255.0f blue:0.0f alpha:1.0f]];
		[labelName setTextAlignment:UITextAlignmentCenter];
		[labelName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:28]];
		[scrollView addSubview:labelName];

		// Load images
		imageKills = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kills.png"]];
		[imageKills setFrame:CGRectMake(0, 60, imageKills.frame.size.width, imageKills.frame.size.height)];
		[scrollView addSubview:imageKills];

		imageXP = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xp.png"]];
		[imageXP setFrame:CGRectMake(0, imageKills.frame.origin.y + imageKills.frame.size.height + 5, imageXP.frame.size.width, imageXP.frame.size.height)];
		[scrollView addSubview:imageXP];

		imageHeadshots = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headshots.png"]];
		[imageHeadshots setFrame:CGRectMake(0, imageXP.frame.origin.y + imageXP.frame.size.height + 5, imageHeadshots.frame.size.width, imageHeadshots.frame.size.height)];
		[scrollView addSubview:imageHeadshots];

		imageKd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kd.png"]];
		[imageKd setFrame:CGRectMake(0, imageHeadshots.frame.origin.y + imageHeadshots.frame.size.height + 5, imageKd.frame.size.width, imageKd.frame.size.height)];
		[scrollView addSubview:imageKd];

		imageRibbons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ribbons.png"]];
		[imageRibbons setFrame:CGRectMake(0, imageKd.frame.origin.y + imageKd.frame.size.height + 5, imageRibbons.frame.size.width, imageRibbons.frame.size.height)];
		[scrollView addSubview:imageRibbons];
        
        // Labels
        labelKills = [[UILabel alloc] initWithFrame:CGRectMake(imageKills.frame.origin.x + imageKills.frame.size.width + 10, imageKills.frame.origin.y, self.frame.size.width - imageKills.frame.origin.x - imageKills.frame.size.width - 20, imageKills.frame.size.height)];
        [labelKills setBackgroundColor:[UIColor clearColor]];
        [labelKills setTextColor:[UIColor lightGrayColor]];
		[labelKills setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [scrollView addSubview:labelKills];
        
        labelXP = [[UILabel alloc] initWithFrame:CGRectMake(labelKills.frame.origin.x, labelKills.frame.origin.y + labelKills.frame.size.height + 5, self.frame.size.width - imageKills.frame.origin.x - imageKills.frame.size.width - 20, imageKills.frame.size.height)];
        [labelXP setBackgroundColor:[UIColor clearColor]];
        [labelXP setTextColor:[UIColor lightGrayColor]];
		[labelXP setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [scrollView addSubview:labelXP];

        labelHeadshots = [[UILabel alloc] initWithFrame:CGRectMake(labelXP.frame.origin.x, labelXP.frame.origin.y + labelXP.frame.size.height + 5, self.frame.size.width - imageKills.frame.origin.x - imageKills.frame.size.width - 20, imageKills.frame.size.height)];
        [labelHeadshots setBackgroundColor:[UIColor clearColor]];
        [labelHeadshots setTextColor:[UIColor lightGrayColor]];
		[labelHeadshots setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [scrollView addSubview:labelHeadshots];

        labelKd = [[UILabel alloc] initWithFrame:CGRectMake(labelHeadshots.frame.origin.x, labelHeadshots.frame.origin.y + labelHeadshots.frame.size.height + 5, self.frame.size.width - imageKills.frame.origin.x - imageKills.frame.size.width - 20, imageKills.frame.size.height)];
        [labelKd setBackgroundColor:[UIColor clearColor]];
        [labelKd setTextColor:[UIColor lightGrayColor]];
		[labelKd setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [scrollView addSubview:labelKd];

        labelRibbons = [[UILabel alloc] initWithFrame:CGRectMake(labelKd.frame.origin.x, labelKd.frame.origin.y + labelKd.frame.size.height + 5, self.frame.size.width - imageKills.frame.origin.x - imageKills.frame.size.width - 20, imageKills.frame.size.height)];
        [labelRibbons setBackgroundColor:[UIColor clearColor]];
        [labelRibbons setTextColor:[UIColor lightGrayColor]];
		[labelRibbons setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [scrollView addSubview:labelRibbons];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code.
    float radius = 7;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    CGPathCloseSubpath(path);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	CGContextSaveGState(context);
	CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawImage(context, rect, [UIImage imageNamed:@"bg_tabcontainer.jpg"].CGImage);
	CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 6.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25].CGColor);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);    
    
    
    CFRelease(path);
}

- (void)fillFields {
	[labelName      setText:name];
    [labelKills     setText:[NSString stringWithFormat:@"%d kills",         kills]];
    [labelXP        setText:[NSString stringWithFormat:@"%d XP",            xp]];
    [labelHeadshots setText:[NSString stringWithFormat:@"%d headshots",     headshots]];
    [labelRibbons   setText:[NSString stringWithFormat:@"%d ribbons",       ribbons]];
    [labelKd        setText:[NSString stringWithFormat:@"%.2f K/D",         kd]];
}

- (void)dealloc {
	[imageKills release],       imageKills = nil;
    [imageHeadshots release],   imageHeadshots = nil;
    [imageKd release],          imageKd = nil;
    [imageRibbons release],     imageRibbons = nil;
    [imageXP release],          imageXP = nil;
	
	[labelName release],        labelName = nil;
    [labelKills release],       labelKills = nil;
    [labelHeadshots release],   labelHeadshots = nil;
    [labelKd release],          labelKd = nil;
    [labelRibbons release],     labelRibbons = nil;
    
	[scrollView release],       scrollView = nil;
	
    [super dealloc];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [scrollView setFrame:CGRectMake(3, 3, self.frame.size.width - 6, self.frame.size.height - 6)];
}


@end
