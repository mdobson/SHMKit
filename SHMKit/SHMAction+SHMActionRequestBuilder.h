//
//  Siren_Action+Siren_Action_Request_Builder.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/11/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMAction.h"

@interface SHMAction (SHMActionRequestBuilder)

/*
 Construct an HTTP request with a body or with URL parameters depending on the request verb itself.
 */
-(NSMutableURLRequest *) constructRequest:(NSDictionary *)dict;

/*
 Create an HTTP request with a body instead of URL parameters. POST, PUT, PATCH.
 */
-(NSMutableURLRequest *) constructHTTPRequestWithParams:(NSDictionary *)dict;

/*
 Create an http request that has URL parameters instead of parameters in the body. GET, DELETE, TRACE, HEAD, OPTIONS, CONNECT
 */
-(NSMutableURLRequest *) constructBodylessHTTPRequestWithParams:(NSDictionary *)dict;

/*
 Get an HTTP_VERB object from a string. Internal use only.
 */
+ (HTTP_VERB) verbFromString:(NSString *)verb;

/*
 Get a string form an HTTP_VERB object. Internal use only.
 */
+ (NSString *) verbFromEnum:(HTTP_VERB)verb;

@end
