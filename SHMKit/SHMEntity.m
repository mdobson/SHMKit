//
//  Siren_Entity.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMEntity.h"
#import "SHMLink.h"
#import "SHMAction.h"
#import "SHMEntityFactory.h"

@implementation SHMEntity

-(id) initWithData:(NSData *)data {
    if (self = [super init]) {
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions error:nil];
        [self loadDictionary:json];
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *)json {
    if (self = [super init]) {
        [self loadDictionary:json];
    }
    
    return self;
}

-(void) loadDictionary:(NSDictionary *)json {
    self.class = json[@"class"];
    self.properties = json[@"properties"];
    self.title = json[@"title"];
    
    NSMutableArray *links = [[NSMutableArray alloc] init];
    for (NSDictionary *link in json[@"links"]) {
        SHMLink *parsedLink = [[SHMLink alloc] initWithDictionary:link];
        [links addObject:parsedLink];
    }
    self.links = links;
    
    NSMutableArray *subEntityRels = [[NSMutableArray alloc] init];
    for (NSString *rel in json[@"rel"]) {
        [subEntityRels addObject:rel];
    }
    self.subEntityRels = subEntityRels;
    
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    for (NSDictionary *action in json[@"actions"]) {
        SHMAction *a = [[SHMAction alloc] initWithDictionary:action];
        [actions addObject:a];
    }
    self.actions = actions;
    
    if ([json objectForKey:@"title"] != nil) {
        self.title = json[@"title"];
    }
    
    if ([json objectForKey:@"entities"] != nil) {
        NSMutableArray *entities = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in json[@"entities"]) {
            SHMEntity *entity = [[SHMEntity alloc] initWithDictionary:dict];
            [entities addObject:entity];
        }
        self.entities = entities;
    }
}

-(SHMEntity *) embeddedEntityForRel:(NSString *)linkRel {
    for (SHMEntity *entity in self.entities) {
        for (NSString* rel in entity.subEntityRels) {
            if ([rel isEqualToString:linkRel]) {
                return entity;
            }
        }
    }
    return nil;
}

-(NSString *) linkForRel:(NSString *)linkRel {
    for (SHMLink *link in self.links) {
        for (NSString *rel in link.rel) {
            if ([rel isEqualToString:linkRel]) {
                return link.href;
            }
        }
    }
    return nil;
}

-(BOOL) hasLinkRel:(NSString *)linkRel {
    if ([self linkForRel:linkRel] != nil)
        return YES;

    // Step into embedded entities
    return [self embeddedEntityForRel:linkRel] != nil;
}

-(void) stepToLinkRel:(NSString *)linkRel withCompletion:(void (^)(NSError *, SHMEntity *))block {

    // Use embedded entity if available
    SHMEntity* emebeddedEntity = [self embeddedEntityForRel:linkRel];
    if (emebeddedEntity) {
        block(nil, emebeddedEntity);
        return;
    }
    
    NSString * method = @"GET";
    NSString * href = [self linkForRel:linkRel];
    if (href != nil) {
        href = [href stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [[NSURL alloc] initWithString:href];
        NSMutableURLRequest * req = [[NSMutableURLRequest alloc] initWithURL:url];
        req.HTTPMethod = method;
        [[SHMEntityFactory sharedFactory] sendSirenRequest:req withBlock:block];
    } else {
        NSError *err = [[NSError alloc] initWithDomain:@"siren" code:1 userInfo:@{NSLocalizedDescriptionKey: @"No href to step to."}];
        block(err, nil);
    }

}

-(SHMAction *) getSirenAction:(NSString *)name {
    for (SHMAction *action in self.actions) {
        if ([action.name isEqualToString:name]) {
            return action;
        }
    }
    return nil;
}

@end
