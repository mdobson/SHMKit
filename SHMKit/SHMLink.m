//
//  Siren_Link.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMLink.h"

@implementation SHMLink


-(id) initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        self.rel = data[@"rel"];
        self.href = data[@"href"];
        self.title = data[@"title"];
    }
    return self;
}

@end
