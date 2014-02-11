//
//  Siren_Action.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "Siren_Action.h"
#import "Siren_Action_Field.h"
#import "URL_Helper.h"
#import "Siren_Action_Data_Helper.h"
#import "Constants.h"

@interface Siren_Action()

-(NSMutableURLRequest *) constructRequest:(NSDictionary *)dict;
-(NSMutableURLRequest *) constructHTTPRequestWithParams:(NSDictionary *)dict;
-(NSMutableURLRequest *) constructBodylessHTTPRequestWithParams:(NSDictionary *)dict;
+ (HTTP_VERB) verbFromString:(NSString *)verb;
+ (NSString *) verbFromEnum:(HTTP_VERB)verb;

@end

@implementation Siren_Action

-(id) initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        self.name = data[@"name"];
        self.class = data[@"class"];
        self.href = data[@"href"];
        self.type = data[@"type"];
        
        if ([data objectForKey:@"title"] != nil) {
            self.title = data[@"title"];
        }
        
        if ([data objectForKey:@"method"] != nil) {
            self.method = [Siren_Action verbFromString:data[@"method"]];
        } else {
            self.method = [Siren_Action verbFromString:GETVERB];
        }
        
        NSMutableArray *actionFields = [[NSMutableArray alloc] init];
        for (NSDictionary *f in data[@"properties"]) {
            Siren_Action_Field *field = [[Siren_Action_Field alloc] initWithDictionary:f];
            [actionFields addObject:field];
        }
        self.fields = actionFields;
        
    }
    
    return self;
}

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

//I want to split this method up into two distinct methods. One for constructing bodyless verb requests and one for constructing requests with bodies.
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
        constructedUrl = [URL_Helper encodeUrl:self.href withDictParams:dict];
    } else {
        constructedUrl = self.href;
    }
    
    NSURL *urlObj = [[NSURL alloc] initWithString:constructedUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlObj];
    request.HTTPMethod = [Siren_Action verbFromEnum:self.method];
    return request;
}

-(NSMutableURLRequest *) constructHTTPRequestWithParams:(NSDictionary *)dict {
    NSString * body = nil;
    if ([dict count] > 0) {
        if ([self.type isEqualToString:@"application/json"]) {
            body = [Siren_Action_Data_Helper encodeJSONData:dict withError:nil];
        } else {
            body = [Siren_Action_Data_Helper encodeUrlData:dict];
        }
    }
    
    NSURL *urlObj = [[NSURL alloc] initWithString:self.href];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlObj];
    
    if (body != nil) {
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    request.HTTPMethod = [Siren_Action verbFromEnum:self.method];
    return request;
}

-(void)performActionWithFields:(NSDictionary *)fields andCompletion:(void (^)(NSError *, NSHTTPURLResponse*, NSData *))block {
    
    NSMutableURLRequest *request = [self constructRequest:fields];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *err){
                               NSHTTPURLResponse * res = (NSHTTPURLResponse *)response;
                               if (res.statusCode < 200 || res.statusCode > 299) {
                                   NSError *err = [[NSError alloc] initWithDomain:@"siren" code:res.statusCode userInfo:@{NSLocalizedDescriptionKey: @"Request error. Code is HTTP Status Code."}];
                                   block(err, nil, nil);
                               } else {
                                   block(nil, res, data);
                               }
                           }];
}

@end
