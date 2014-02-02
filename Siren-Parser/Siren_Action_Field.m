//
//  Siren_Action_Field.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "Siren_Action_Field.h"

@implementation Siren_Action_Field

-(id) initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        self.name = data[@"name"];
        self.type = data[@"type"];
        if ([data objectForKey:@"value"] != nil) {
            self.value = data[@"value"];
        }
    }
    
    return self;
}

@end
