//
//  SHMHTTPHelper.m
//  SHMKit
//
//  Created by Matthew Dobson on 4/28/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMEntityFactory.h"

@implementation SHMEntityFactory

@synthesize delegate;

+(id) sharedFactory{
    static SHMEntityFactory *factory = nil;
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

-(void) sendSirenRequest:(NSURLRequest *)req withBlock:(SirenHTTPResult)block
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
                                   if (self.delegate != nil && [self.delegate conformsToProtocol:@protocol(SHMEntityFactoryDelegate)]) {
                                       if ([self.delegate didRecieveRequestHeaders:headers] == YES) {
                                           SHMEntity *entity = [self.delegate didRecieveRequestData:data];
                                           block(nil, entity);
                                       }
                                   } else {
                                       //Default fallback to old parsing
                                       NSString *contentType = [headers objectForKey:@"Content-Type"];
                                       if (contentType != nil && ([contentType isEqualToString:@"application/json"] || [contentType isEqualToString:@"application/vnd.siren+json"])) {
                                           SHMEntity * entity = [[SHMEntity alloc] initWithData:data];
                                           block(nil, entity);
                                       }
                                   }
                               }
                           }];
}

@end

