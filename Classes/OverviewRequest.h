//
//  OverviewRequest.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 4/12/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friends.h"
#import "ApiRequest.h"

@interface OverviewRequest : ApiRequest <ApiRequestDelegate> {
	NSString                * username;
    Friends                 * friends;
}
@property (nonatomic, retain) Friends                   * friends;

//- (void)setUsername:(NSString *)uname;

@end
