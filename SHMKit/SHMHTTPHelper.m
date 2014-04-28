//
//  SHMHTTPHelper.m
//  SHMKit
//
//  Created by Matthew Dobson on 4/28/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMHTTPHelper.h"

@implementation SHMHTTPHelper

+(void) sendSirenRequest:(NSMutableURLRequest *)req withBlock:(void (^)(NSError *error, SHMEntity *entity))block
{
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *err){
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

