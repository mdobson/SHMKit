//
//  SHMRequestFactory.m
//  SHMKit
//
//  Created by Matthew Dobson on 5/11/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMRequestFactory.h"
#import "SHMUrlHelper.h"
#import "SHMActionDataHelper.h"

@implementation SHMRequestFactory

+(id) sharedFactory{
    static SHMRequestFactory *factory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        factory = [[self alloc] init];
    });
    return factory;
}

-(id) init {
    if (self = [super init]) {
    }
    return self;
}

//Never gets called.
-(void) dealloc {
    
}

-(NSMutableURLRequest *) constructRequest:(NSDictionary *)dict forAction:(SHMAction *)action{
    
    switch (action.method) {
        case GET:
            return [self constructBodylessHTTPRequestWithParams:dict forAction:action];
            break;
        case HEAD:
            return [self constructBodylessHTTPRequestWithParams:dict forAction:action];
            break;
        case POST:
            return [self constructHTTPRequestWithParams:dict forAction:action];
            break;
        case PUT:
            return [self constructHTTPRequestWithParams:dict forAction:action];
            break;
        case TRACE:
            return [self constructBodylessHTTPRequestWithParams:dict forAction:action];
            break;
        case DELETE:
            return [self constructBodylessHTTPRequestWithParams:dict forAction:action];
            break;
        case PATCH:
            return [self constructHTTPRequestWithParams:dict forAction:action];
            break;
        case OPTIONS:
            return [self constructBodylessHTTPRequestWithParams:dict forAction:action];
            break;
        case CONNECT:
            return [self constructBodylessHTTPRequestWithParams:dict forAction:action];
            break;
        default:
            break;
    }
    
}

-(NSMutableURLRequest *) constructBodylessHTTPRequestWithParams:(NSDictionary *)dict forAction:(SHMAction *)action{
    
    NSString * constructedUrl = nil;
    if ([dict count] > 0) {
        constructedUrl = [SHMUrlHelper encodeUrl:action.href withDictParams:dict];
    } else {
        constructedUrl = action.href;
    }
    
    NSURL *urlObj = [[NSURL alloc] initWithString:constructedUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlObj];
    request.HTTPMethod = [SHMConstants verbFromEnum:action.method];
    return request;
}


-(NSMutableURLRequest *) constructHTTPRequestWithParams:(NSDictionary *)dict forAction:(SHMAction *)action{
    NSString * body = nil;
    NSURL *urlObj = [[NSURL alloc] initWithString:action.href];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlObj];
    
    if ([dict count] > 0) {
        if (action.type != nil && [action.type isEqualToString:@"application/json"]) {
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
    
    request.HTTPMethod = [SHMConstants verbFromEnum:action.method];
    return request;
}


@end
