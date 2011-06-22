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
        
        labelKills = [[UILabel alloc] initWithFrame:CGRectMake(imageKills.frame.origin.x + imageKills.frame.size.width + 10, imageKills.frame.origin.y, self.frame.size.width - imageKills.frame.origin.x - imageKills.frame.size.width - 20, imageKills.frame.size.height)];
        [labelKills setBackgroundColor:[UIColor clearColor]];
        [labelKills setTextColor:[UIColor lightGrayColor]];
		[labelKills setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [scrollView addSubview:labelKills];
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
	[labelName setText:name];
    [labelKills setText:[NSString stringWithFormat:@"%d kills", kills]];
}

- (void)dealloc {
	[imageKills release];
	imageKills = nil;
	
	[labelName release];
	labelName = nil;
    
    [labelKills release];
    labelKills = nil;
	
	[scrollView release];
	scrollView = nil;
	
    [super dealloc];
}


@end
