//
//  Friend.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/24/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Friend : NSObject {
	NSString *name;
	NSNumber *kills;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *kills;

- (id)initWithName:(NSString *)n kills:(NSNumber *)k;

@end
