//
//  Siren_Parser.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMParser.h"
#import "SHMEntityFactory.h"
#import "SHMRequestFactory.h"

@interface SHMParser()

@end

@implementation SHMParser

-(id) initWithSirenRoot:(NSString *)endpoint {
    if (self = [super init]) {
        self.endpoint = endpoint;
        [[SHMRequestFactory sharedFactory] setBaseUrl:[NSURL URLWithString:endpoint]];
    }
    return self;
}

-(void) retrieveRoot:(void (^)(NSError *, SHMEntity *))block {
    NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForHref:self.endpoint];
    [[SHMEntityFactory sharedFactory] sendSirenRequest:req withBlock:block];
}

@end
