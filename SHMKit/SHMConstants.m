//
//  Constants.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/10/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMConstants.h"

NSString *const GETVERB = @"GET";

@implementation SHMConstants

+ (HTTP_VERB) verbFromString:(NSString *)verb {
    NSDictionary *lookup = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [NSNumber numberWithInt:GET],@"GET",
                            [NSNumber numberWithInt:POST],@"POST",
                            [NSNumber numberWithInt:PUT],@"PUT",
                            [NSNumber numberWithInt:DELETE],@"DELETE",
                            [NSNumber numberWithInt:TRACE],@"TRACE",
                            [NSNumber numberWithInt:OPTIONS],@"OPTIONS",
                            [NSNumber numberWithInt:PATCH],@"PATCH",
                            [NSNumber numberWithInt:HEAD],@"HEAD", nil];
    
    return (HTTP_VERB)[[lookup objectForKey:verb] integerValue];
}

+ (NSString *) verbFromEnum:(HTTP_VERB)verb {
    NSDictionary *lookup = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"GET", [NSNumber numberWithInt:GET],
                            @"POST", [NSNumber numberWithInt:POST],
                            @"PUT", [NSNumber numberWithInt:PUT],
                            @"DELETE", [NSNumber numberWithInt:DELETE],
                            @"TRACE", [NSNumber numberWithInt:TRACE],
                            @"OPTIONS", [NSNumber numberWithInt:OPTIONS],
                            @"PATCH", [NSNumber numberWithInt:PATCH],
                            @"HEAD", [NSNumber numberWithInt:HEAD], nil];
    return [lookup objectForKey:[NSNumber numberWithInt:verb]];
}

@end
