//
//  Constants.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/10/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const GETVERB;

/*
Enum for HTTP Verbs
*/
typedef NS_ENUM(NSInteger, HTTP_VERB) {
    GET,
    POST,
    PUT,
    DELETE,
    PATCH,
    OPTIONS,
    CONNECT,
    HEAD,
    TRACE
};


@interface SHMConstants : NSObject

/*
 Get an HTTP_VERB object from a string. Internal use only.
 */
+ (HTTP_VERB) verbFromString:(NSString *)verb;

/*
 Get a string form an HTTP_VERB object. Internal use only.
 */
+ (NSString *) verbFromEnum:(HTTP_VERB)verb;


@end
