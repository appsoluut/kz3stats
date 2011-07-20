//
//  Friends.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 6/23/11.
//  Copyright (c) 2011 AppSoluut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friends : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * kills;
@property (nonatomic, retain) NSNumber * xp;
@property (nonatomic, retain) NSNumber * kd;
@property (nonatomic, retain) NSNumber * ribbons;
@property (nonatomic, retain) NSNumber * headshots;

@end
