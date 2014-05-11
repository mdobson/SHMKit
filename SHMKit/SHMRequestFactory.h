//
//  SHMRequestFactory.h
//  SHMKit
//
//  Created by Matthew Dobson on 5/11/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMAction.h"

@interface SHMRequestFactory : NSObject

+ (id)sharedFactory;

/*
 Construct an HTTP request with a body or with URL parameters depending on the request verb itself.
 */
-(NSMutableURLRequest *) constructRequest:(NSDictionary *)dict forAction:(SHMAction *)action;

/*
 Create an HTTP request with a body instead of URL parameters. POST, PUT, PATCH.
 */
-(NSMutableURLRequest *) constructHTTPRequestWithParams:(NSDictionary *)dict forAction:(SHMAction *)action;

/*
 Create an http request that has URL parameters instead of parameters in the body. GET, DELETE, TRACE, HEAD, OPTIONS, CONNECT
 */
-(NSMutableURLRequest *) constructBodylessHTTPRequestWithParams:(NSDictionary *)dict forAction:(SHMAction *)action;

@end
