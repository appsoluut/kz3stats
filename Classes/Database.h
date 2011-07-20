//
//  Database.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/27/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
//#import "Friend.h"

@interface Database : NSObject {
	// Settings
	NSString *databaseName;
	NSString *databasePath;
	
	sqlite3 *database;
}

- (void)checkAndCreateDatabase;
- (NSArray *)readFriendsFromDatabase;
- (void)addFriend:(NSString *)name;
- (void)deleteFriend:(NSString *)name;

@end