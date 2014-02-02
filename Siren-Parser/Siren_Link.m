//
//  Siren_Link.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "Siren_Link.h"

@implementation Siren_Link

-(id) initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        self.rel = data[@"rel"];
        self.href = data[@"href"];
    }
    return self;
}

@end
