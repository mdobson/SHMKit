//
//  Siren_Action.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMAction.h"
#import "SHMActionField.h"
#import "SHMUrlHelper.h"
#import "SHMActionDataHelper.h"
#import "SHMConstants.h"
#import "SHMAction+SHMActionRequestBuilder.h"

@interface SHMAction()

@end

@implementation SHMAction

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
            self.method = [SHMAction verbFromString:data[@"method"]];
        } else {
            self.method = [SHMAction verbFromString:GETVERB];
        }
        
        NSMutableArray *actionFields = [[NSMutableArray alloc] init];
        for (NSDictionary *f in data[@"properties"]) {
            SHMActionField *field = [[SHMActionField alloc] initWithDictionary:f];
            [actionFields addObject:field];
        }
        self.fields = actionFields;
        
    }
    
    return self;
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
