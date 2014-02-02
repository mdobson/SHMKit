//
//  Siren_Parser.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "Siren_Parser.h"

@interface Siren_Parser()

@property (nonatomic, retain) NSString *endpoint;

@end

@implementation Siren_Parser

-(id) initWithSirenRoot:(NSString *)endpoint {
    if (self = [super init]) {
        self.endpoint = endpoint;
    }
    return self;
}

@end
