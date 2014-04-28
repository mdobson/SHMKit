//
//  Siren_Parser.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMParser.h"

@interface SHMParser()

@end

@implementation SHMParser

-(id) initWithSirenRoot:(NSString *)endpoint {
    if (self = [super init]) {
        self.endpoint = endpoint;
    }
    return self;
}

-(void) retrieveRoot:(void (^)(NSError *, SHMEntity *))block {
    NSString *method = @"GET";
    NSURL * url = [[NSURL alloc] initWithString:self.endpoint];
    NSMutableURLRequest * req = [[NSMutableURLRequest alloc] initWithURL:url];
    req.HTTPMethod = method;
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
                               NSDictionary *headers = [res allHeaderFields];
                               if (res.statusCode != 200) {
                                   NSError *err = [[NSError alloc] initWithDomain:@"siren" code:res.statusCode userInfo:@{NSLocalizedDescriptionKey: @"Request error. Code is HTTP Status Code."}];
                                   block(err, nil);
                               } else {
                                   NSString *contentType = [headers objectForKey:@"Content-Type"];
                                   if (contentType != nil && ([contentType isEqualToString:@"application/json"] || [contentType isEqualToString:@"application/vnd.siren+json"])) {
                                       SHMEntity * entity = [[SHMEntity alloc] initWithData:data];
                                       block(nil, entity);
                                   }
                               }
                           }];
}

@end
