//
//  ApiRequest.m
//  KZ3Stats
//
//  Created by Paul Hameteman on 4/12/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import "ApiRequest.h"


@implementation ApiRequest
@synthesize delegate = mDelegate;

- (id)init {
    self = [super init];
	if (self) {
		cookieValue = @"NDswOzE5NDY7ZW5fR0I=";
		baseURL = @"http://www.killzone.com/kz3/en_GB/mykillzone/";
		path = nil;		
	}
	return self;
}

- (void)start {
	NSString *url = [NSString stringWithFormat:@"%@%@", baseURL, path];
    
    DLog(@"URL: %@", url);
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	
	NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:
								@"www.killzone.com", NSHTTPCookieDomain,
								@"\\", NSHTTPCookiePath,
								@"kz_settings", NSHTTPCookieName,
								cookieValue, NSHTTPCookieValue,
								nil];
	
	NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:properties];
	
	NSArray *cookies = [NSArray arrayWithObject:cookie];
	
	NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
	[request setAllHTTPHeaderFields:headers];
	[[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [request release], request = nil;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [responseData release];
    // Show error message

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *str = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    if (mDelegate && [mDelegate respondsToSelector:@selector(apiDidFinishLoading:)]) {
        [mDelegate apiDidFinishLoading:str];
    }
    
//    NSLog(@"Data: %@", str);

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [str release];
    [responseData release];
}


@end
