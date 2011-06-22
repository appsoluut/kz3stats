//
//  Database.m
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/27/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import "Database.h"


@implementation Database

- (id)init {
    self = [super init];
	if (self) {
		databaseName = @"KZ3StatsDatabase.sql";

		// Get the path to the documents directory and append the databaseName
		NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDir = [documentPaths objectAtIndex:0];
		databasePath = [[documentsDir stringByAppendingPathComponent:databaseName] retain];
		
		[self checkAndCreateDatabase];
	}
	return self;
}

- (void)checkAndCreateDatabase {
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	
	// If the database already exists then return without doing anything
	if(success) return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
	[fileManager release];
}

- (NSArray *)readFriendsFromDatabase {
	// Init the friends array
	NSMutableArray *friends = [[NSMutableArray alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT * FROM friends";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSNumber *aKills = [NSNumber numberWithInt:(int)sqlite3_column_int(compiledStatement, 2)];
				
				// Create a new animal object with the data from the database
				Friend *friend = [[Friend alloc] initWithName:aName kills:aKills];
				
				// Add the animal object to the animals Array
				[friends addObject:friend];
				
				[friend release];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	
	sqlite3_close(database);
	
	return [NSArray arrayWithArray:friends];
}

- (void)addFriend:(NSString *)name {
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		sqlite3_stmt *compiledStatement;
		const char *sqlStatement = "INSERT INTO friends (name) VALUES(?)";
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			sqlite3_bind_text(compiledStatement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_step(compiledStatement);
		}
		
		sqlite3_finalize(compiledStatement);
	}
	
	sqlite3_close(database);
}

- (void)deleteFriend:(NSString *)name {
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		sqlite3_stmt *compiledStatement;
		const char *sqlStatement = "DELETE FROM friends WHERE name=?";
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			sqlite3_bind_text(compiledStatement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_step(compiledStatement);
		}
		
		sqlite3_finalize(compiledStatement);
	}
	
	sqlite3_close(database);
}

- (void)dealloc {
	[databasePath release];
	
	[super dealloc];
}

@end
