//
//  ApiRequest.h
//  KZ3Stats
//
//  Created by Paul Hameteman on 4/12/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ApiRequestDelegate <NSObject>
@optional
- (void)apiDidFinishLoading:(NSString *)data;
@end

@interface ApiRequest : NSObject {
	NSString *cookieValue;
	NSString *baseURL;
	NSString *path;

	NSMutableData *responseData;
    
    id<ApiRequestDelegate> *delegate;
}
@property (retain) id delegate;

- (void)start;

@end
