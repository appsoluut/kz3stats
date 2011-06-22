//
//  OverviewRequest.m
//  KZ3Stats
//
//  Created by Paul Hameteman on 4/12/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import "OverviewRequest.h"


@implementation OverviewRequest

- (id)init {
    self = [super init];
	if (self) {
		path = @"overview.html?name=%@";
        [self setDelegate:self];
	}
	return self;
}

- (void)setUsername:(NSString *)uname {
	if (username) {
		[username release], username = nil;
	}
	
	username = [NSString stringWithString:uname];
	[username retain];
	
	path = [NSString stringWithFormat:path, username];
}

- (void)dealloc {
	[super dealloc];
    
	[username release], username = nil;
}

- (void)apiDidFinishLoading:(NSString *)data {
    NSError * error = nil;
    
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setLocale:locale];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSLog(@"Statistics for: %@", username);

    // Kills
    NSRegularExpression * regex     = [NSRegularExpression regularExpressionWithPattern:@"<b>([0-9,]+)</b><br/>\\s+kills" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:&error];
    NSArray             * matches   = [regex matchesInString:data options:0 range:NSMakeRange(0, [data length])];
    
    if ([matches count] > 0) {
        NSNumber *kills = [formatter numberFromString:[data substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:1]]];
        NSLog(@"Kills    : %d", [kills intValue]);
    }
    
    // Headshots
    regex       = [NSRegularExpression regularExpressionWithPattern:@"<b>([0-9,]+)</b><br/>\\s+headshots" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:&error];
    matches     = [regex matchesInString:data options:0 range:NSMakeRange(0, [data length])];
    
    if ([matches count] > 0) {
        NSNumber *headshots = [formatter numberFromString:[data substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:1]]];
        NSLog(@"Headshots: %d", [headshots intValue]);
    }

    // Total ribbons
    regex       = [NSRegularExpression regularExpressionWithPattern:@"<b>([0-9,]+)</b><br/>\\s+Total ribbons" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:&error];
    matches     = [regex matchesInString:data options:0 range:NSMakeRange(0, [data length])];
    
    if ([matches count] > 0) {
        NSNumber *ribbons = [formatter numberFromString:[data substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:1]]];
        NSLog(@"Ribbons  : %d", [ribbons intValue]);
    }
    
    // K/D
    regex       = [NSRegularExpression regularExpressionWithPattern:@"<b>([0-9\\.]+)</b><br/>\\s+k/d ratio" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:&error];
    matches     = [regex matchesInString:data options:0 range:NSMakeRange(0, [data length])];
    
    if ([matches count] > 0) {
        NSNumber *kdRatio = [NSNumber numberWithFloat:[[data substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:1]] floatValue]];
        NSLog(@"K/D ratio: %.2f", [kdRatio floatValue]);
    }
    
    // Current user
    regex       = [NSRegularExpression regularExpressionWithPattern:@"<div class=\"wherenext_profile_txt\">\\s+<b>(.*)</b><br />" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:&error];
    matches     = [regex matchesInString:data options:0 range:NSMakeRange(0, [data length])];
    
    if ([matches count] > 0) {
        NSString *user = [data substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:1]];
        NSLog(@"Username : %@", user);
    }
    
    // Experience points
    regex       = [NSRegularExpression regularExpressionWithPattern:@"<b>([0-9,]+)</b><br/>\\s+Total Points" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:&error];
    matches     = [regex matchesInString:data options:0 range:NSMakeRange(0, [data length])];
    
    if ([matches count] > 0) {
        NSNumber *experience = [formatter numberFromString:[data substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:1]]];
        NSLog(@"XP       : %d", [experience intValue]);
    }

    // Current rank
    regex       = [NSRegularExpression regularExpressionWithPattern:@"<div class=\"left rankprocess_actual\">\\s+<img src=\"(.*?)\" alt=\".*?\" title=\"(.*?)\"/>" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:&error];
    matches     = [regex matchesInString:data options:0 range:NSMakeRange(0, [data length])];

    if ([matches count] > 0) {
        NSString *imageUrl = [data substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:1]];
        NSLog(@"Image    : %@", imageUrl);
        
        NSString *rank = [data substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:2]];
        NSLog(@"Rank     : %@", rank);
    }
    
    
    NSLog(@"---------------------------------------------------------------");
    [formatter release],    formatter   = nil;
    [locale release],       locale      = nil;
}

@end
