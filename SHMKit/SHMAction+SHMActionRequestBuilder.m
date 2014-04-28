//
//  Siren_Action+Siren_Action_Request_Builder.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/11/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMAction+SHMActionRequestBuilder.h"
#import "SHMConstants.h"
#import "SHMUrlHelper.h"
#import "SHMActionDataHelper.h"

@implementation SHMAction (SHMActionRequestBuilder)

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

-(NSMutableURLRequest *) constructRequest:(NSDictionary *)dict {
    
    switch (self.method) {
        case GET:
            return [self constructBodylessHTTPRequestWithParams:dict];
            break;
        case HEAD:
            return [self constructBodylessHTTPRequestWithParams:dict];
            break;
        case POST:
            return [self constructHTTPRequestWithParams:dict];
            break;
        case PUT:
            return [self constructHTTPRequestWithParams:dict];
            break;
        case TRACE:
            return [self constructBodylessHTTPRequestWithParams:dict];
            break;
        case DELETE:
            return [self constructBodylessHTTPRequestWithParams:dict];
            break;
        case PATCH:
            return [self constructHTTPRequestWithParams:dict];
            break;
        case OPTIONS:
            return [self constructBodylessHTTPRequestWithParams:dict];
            break;
        case CONNECT:
            return [self constructBodylessHTTPRequestWithParams:dict];
            break;
        default:
            break;
    }
    
}

-(NSMutableURLRequest *) constructBodylessHTTPRequestWithParams:(NSDictionary *)dict {
    
    NSString * constructedUrl = nil;
    if ([dict count] > 0) {
        constructedUrl = [SHMUrlHelper encodeUrl:self.href withDictParams:dict];
    } else {
        constructedUrl = self.href;
    }
    
    NSURL *urlObj = [[NSURL alloc] initWithString:constructedUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlObj];
    request.HTTPMethod = [SHMAction verbFromEnum:self.method];
    return request;
}


-(NSMutableURLRequest *) constructHTTPRequestWithParams:(NSDictionary *)dict {
    NSString * body = nil;
    NSURL *urlObj = [[NSURL alloc] initWithString:self.href];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlObj];
    
    if ([dict count] > 0) {
        if ([self.type isEqualToString:@"application/json"]) {
            body = [SHMActionDataHelper encodeJSONData:dict withError:nil];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        } else {
            body = [SHMActionDataHelper encodeUrlData:dict];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        }
    }
    
    if (body != nil) {
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    request.HTTPMethod = [SHMAction verbFromEnum:self.method];
    return request;
}


@end
