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
#import "SHMHTTPHelper.h"

@implementation SHMEntity

-(id) initWithData:(NSData *)data {
    if (self = [super init]) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        self.class = json[@"class"];
        self.properties = json[@"properties"];
        self.title = json[@"title"];
        
        NSMutableArray *links = [[NSMutableArray alloc] init];
        for (NSDictionary *link in json[@"links"]) {
            SHMLink *parsedLink = [[SHMLink alloc] initWithDictionary:link];
            [links addObject:parsedLink];
        }
        self.links = links;
        
        
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
    return self;
}

-(id) initWithDictionary:(NSDictionary *)json {
    if (self = [super init]) {
        self.class = json[@"class"];
        self.properties = json[@"properties"];
        self.title = json[@"title"];
        
        NSMutableArray *links = [[NSMutableArray alloc] init];
        for (NSDictionary *link in json[@"links"]) {
            SHMLink *parsedLink = [[SHMLink alloc] initWithDictionary:link];
            [links addObject:parsedLink];
        }
        self.links = links;
        
        
        NSMutableArray *actions = [[NSMutableArray alloc] init];
        for (NSDictionary *action in json[@"actions"]) {
            SHMAction *a = [[SHMAction alloc] initWithDictionary:action];
            [actions addObject:a];
        }
        self.actions = actions;
        
        if ([json objectForKey:@"title"] != nil) {
            self.title = json[@"title"];
        }
    }
    
    return self;
}

-(void) stepToLinkRel:(NSString *)linkRel withCompletion:(void (^)(NSError *, SHMEntity *))block {
    NSString * method = @"GET";
    NSString * href = nil;
    for (SHMLink *link in self.links) {
        for (NSString *rel in link.rel) {
            if ([linkRel isEqualToString:rel]) {
                href = link.href;
                break;
            }
        }
        if (href != nil) {
            break;
        }
    }
    
    if (href != nil) {
        href = [href stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [[NSURL alloc] initWithString:href];
        NSMutableURLRequest * req = [[NSMutableURLRequest alloc] initWithURL:url];
        req.HTTPMethod = method;
        [SHMHTTPHelper sendSirenRequest:req withBlock:block];
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
