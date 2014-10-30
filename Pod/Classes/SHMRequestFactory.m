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
#import "SHMRequestFactoryDelegate.h"

@implementation SHMRequestFactory

@synthesize delegate, baseUrl;

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

-(NSURLRequest *) constructRequestForAction:(SHMAction *)action withParams:(NSDictionary *)dict{
    
    switch (action.method) {
        case GET:
            return [self constructBodylessHTTPRequestForAction:action withParams:dict];
            break;
        case HEAD:
            return [self constructBodylessHTTPRequestForAction:action withParams:dict];
            break;
        case POST:
            return [self constructHTTPRequestForAction:action withParams:dict];
            break;
        case PUT:
            return [self constructHTTPRequestForAction:action withParams:dict];
            break;
        case TRACE:
            return [self constructBodylessHTTPRequestForAction:action withParams:dict];
            break;
        case DELETE:
            return [self constructBodylessHTTPRequestForAction:action withParams:dict];
            break;
        case PATCH:
            return [self constructHTTPRequestForAction:action withParams:dict];
            break;
        case OPTIONS:
            return [self constructBodylessHTTPRequestForAction:action withParams:dict];
            break;
        case CONNECT:
            return [self constructBodylessHTTPRequestForAction:action withParams:dict];
            break;
        default:
            break;
    }
    
}

-(NSURLRequest *) constructBodylessHTTPRequestForAction:(SHMAction *)action withParams:(NSDictionary *)dict{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(buildRequestForAction:withParameters:)]) {
        return [self.delegate buildRequestForAction:action withParameters:dict];
    } else {
        NSString * constructedUrl = nil;
        if ([dict count] > 0) {
            constructedUrl = [SHMUrlHelper encodeUrl:action.href withDictParams:dict];
        } else {
            constructedUrl = action.href;
        }
        
        NSURL *urlObj = [self generateUrlForHref:constructedUrl];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlObj];
        request.HTTPMethod = [SHMConstants verbFromEnum:action.method];
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(setAuthorizationTokenHeader)]) {
            NSString *authHeader = [self.delegate setAuthorizationTokenHeader];
            [request setValue:authHeader forHTTPHeaderField:@"Authorization"];
        }
        return request;
    }
}


-(NSURLRequest *) constructHTTPRequestForAction:(SHMAction *)action withParams:(NSDictionary *)dict{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(buildBodylessRequestForAction:withParameters:)]) {
        return [self.delegate buildBodylessRequestForAction:action withParameters:dict];
    } else {
        NSString * body = nil;
        NSURL *urlObj = [self generateUrlForHref:action.href];
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
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(setAuthorizationTokenHeader)]) {
            NSString *authHeader = [self.delegate setAuthorizationTokenHeader];
            [request setValue:authHeader forHTTPHeaderField:@"Authorization"];
        }
        return request;
    }
}

-(NSURLRequest *) constructRequestForHref:(NSString *)href {
    href = [href stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [self generateUrlForHref:href];
    NSMutableURLRequest * req = [[NSMutableURLRequest alloc] initWithURL:url];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(setAuthorizationTokenHeader)]) {
        NSString *authHeader = [self.delegate setAuthorizationTokenHeader];
        [req setValue:authHeader forHTTPHeaderField:@"Authorization"];
    }
    req.HTTPMethod = @"GET";
    return req;
}

-(NSURL *) generateUrlForHref:(NSString *)href {
    NSURL *url = [NSURL URLWithString:href];
    if (url.host == nil) {
        url = [[NSURL alloc] initWithString:href relativeToURL:self.baseUrl];
    }
    return url;
}

@end
