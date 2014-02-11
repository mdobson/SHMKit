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
#import "Siren_Action+Siren_Action_Request_Builder.h"

@interface Siren_Action()

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
