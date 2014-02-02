//
//  Siren_Parser.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "Siren_Parser.h"

@interface Siren_Parser()

@end

@implementation Siren_Parser

-(id) initWithSirenRoot:(NSString *)endpoint {
    if (self = [super init]) {
        self.endpoint = endpoint;
    }
    return self;
}

-(void) retrieveRoot:(void (^)(NSError *, Siren_Entity *))block {
    NSString *method = @"GET";
    NSURL * url = [[NSURL alloc] initWithString:self.endpoint];
    NSMutableURLRequest * req = [[NSMutableURLRequest alloc] initWithURL:url];
    req.HTTPMethod = method;
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
                               if (res.statusCode != 200) {
                                   NSError *err = [[NSError alloc] initWithDomain:@"siren" code:res.statusCode userInfo:@{NSLocalizedDescriptionKey: @"Request error. Code is HTTP Status Code."}];
                                   block(err, nil);
                               } else {
                                   Siren_Entity *entity = [[Siren_Entity alloc] initWithData:data];
                                   block(nil, entity);
                               }
                           }];
}

@end
