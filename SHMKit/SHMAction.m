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
#import "SHMEntity.h"
#import "SHMHTTPHelper.h"

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
        
        self.methodString = [data objectForKey:@"method"];
        if (self.methodString != nil) {
            self.method = [SHMAction verbFromString:self.methodString];
        } else {
            self.method = [SHMAction verbFromString:GETVERB];
        }
        
        NSMutableArray *actionFields = [[NSMutableArray alloc] init];
        for (NSDictionary *f in data[@"fields"]) {
            SHMActionField *field = [[SHMActionField alloc] initWithDictionary:f];
            [actionFields addObject:field];
        }
        self.fields = actionFields;
        
    }
    
    return self;
}

-(void)performActionWithFields:(NSDictionary *)fields andCompletion:(void (^)(NSError *, SHMEntity *))block {
    
    NSMutableURLRequest *request = [self constructRequest:fields];
    [SHMHTTPHelper sendSirenRequest:request withBlock:block];
}

-(void)performActionWithCompletion:(void (^)(NSError *, SHMEntity *))block {
    
    NSMutableURLRequest *request = [self constructRequest:nil];
    [SHMHTTPHelper sendSirenRequest:request withBlock:block];
}
@end
