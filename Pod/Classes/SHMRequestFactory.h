//
//  SHMRequestFactory.h
//  SHMKit
//
//  Created by Matthew Dobson on 5/11/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMAction.h"
#import "SHMRequestFactoryDelegate.h"

@interface SHMRequestFactory : NSObject

@property (nonatomic, retain) id<SHMRequestFactoryDelegate> delegate;
@property (nonatomic, retain) NSURL *baseUrl;


+ (id)sharedFactory;

/*
 Construct an HTTP request with a body or with URL parameters depending on the request verb itself.
 */
-(NSURLRequest *) constructRequestForAction:(SHMAction *)action withParams:(NSDictionary *)dict;

/*
 Create an HTTP request with a body instead of URL parameters. POST, PUT, PATCH.
 */
-(NSURLRequest *) constructHTTPRequestForAction:(SHMAction *)action withParams:(NSDictionary *)dict;

/*
 Create an http request that has URL parameters instead of parameters in the body. GET, DELETE, TRACE, HEAD, OPTIONS, CONNECT
 */
-(NSURLRequest *) constructBodylessHTTPRequestForAction:(SHMAction *)action withParams:(NSDictionary *)dict;

-(NSURLRequest *) constructRequestForHref:(NSString *)href;

/*
 Generate the URL for the outgoing API request. If the provided href is a fragment generate a full URL.
*/
-(NSURL *)generateUrlForHref:(NSString *)href;

@end
