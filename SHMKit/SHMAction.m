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
#import "SHMRequestFactory.h"
#import "SHMEntity.h"
#import "SHMEntityFactory.h"

@interface SHMAction()

@end

NSString * const urlEncoded = @"application/x-www-form-urlencoded";

@implementation SHMAction

-(id) initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        self.name = data[@"name"];
        self.class = data[@"class"];
        self.href = data[@"href"];
        
        if (data[@"type"] == nil) {
            self.type = urlEncoded;
        } else {
            self.type = data[@"type"];
        }
        
        if ([data objectForKey:@"title"] != nil) {
            self.title = data[@"title"];
        }
        
        self.methodString = [data objectForKey:@"method"];
        if (self.methodString != nil) {
            self.method = [SHMConstants verbFromString:self.methodString];
        } else {
            self.method = [SHMConstants verbFromString:GETVERB];
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
    
    NSURLRequest *request = [[SHMRequestFactory sharedFactory] constructRequestForAction:self withParams:fields];
    [[SHMEntityFactory sharedFactory] sendSirenRequest:request withBlock:block];
}

-(void)performActionWithCompletion:(void (^)(NSError *, SHMEntity *))block {
    
    NSURLRequest *request = [[SHMRequestFactory sharedFactory] constructRequestForAction:self withParams:nil];
    [[SHMEntityFactory sharedFactory] sendSirenRequest:request withBlock:block];
}
@end
