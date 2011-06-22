//
//  Friend.m
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/24/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import "Friend.h"


@implementation Friend
@synthesize name, kills;

- (id)initWithName:(NSString *)n kills:(NSNumber *)k {
	if (self = [super init]) {
		self.name = n;
		self.kills = k;
	}
	return self;
}

@end
