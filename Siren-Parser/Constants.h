//
//  Constants.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/10/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const GETVERB;

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


@interface Constants : NSObject

@end
