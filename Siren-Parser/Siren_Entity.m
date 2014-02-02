//
//  Siren_Entity.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "Siren_Entity.h"
#import "Siren_Link.h"
#import "Siren_Action.h"

@implementation Siren_Entity

-(id) initWithData:(NSData *)data {
    if (self = [super init]) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        self.class = json[@"class"];
        self.properties = json[@"properties"];
        self.title = json[@"title"];
        
        NSMutableArray *links = [[NSMutableArray alloc] init];
        for (NSDictionary *link in json[@"links"]) {
            Siren_Link *parsedLink = [[Siren_Link alloc] initWithDictionary:link];
            [links addObject:parsedLink];
        }
        self.links = links;
        
        
        NSMutableArray *actions = [[NSMutableArray alloc] init];
        for (NSDictionary *action in json[@"actions"]) {
            Siren_Action *a = [[Siren_Action alloc] initWithDictionary:action];
            [actions addObject:a];
        }
        self.actions = actions;
    
        if ([json objectForKey:@"title"] != nil) {
            self.title = json[@"title"];
        }
        
        if ([json objectForKey:@"entities"] != nil) {
            NSMutableArray *entities = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in json[@"entities"]) {
                Siren_Entity *entity = [[Siren_Entity alloc] initWithDictionary:dict];
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
            Siren_Link *parsedLink = [[Siren_Link alloc] initWithDictionary:link];
            [links addObject:parsedLink];
        }
        self.links = links;
        
        
        NSMutableArray *actions = [[NSMutableArray alloc] init];
        for (NSDictionary *action in json[@"actions"]) {
            Siren_Action *a = [[Siren_Action alloc] initWithDictionary:action];
            [actions addObject:a];
        }
        self.actions = actions;
        
        if ([json objectForKey:@"title"] != nil) {
            self.title = json[@"title"];
        }
    }
    
    return self;
}

-(void) stepToLinkRel:(NSString *)linkRel withCompletion:(void (^)(NSError *, Siren_Entity *))block {
    NSString * method = @"GET";
    NSString * href = nil;
    for (Siren_Link *link in self.links) {
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
        NSURL *url = [[NSURL alloc] initWithString:href];
        NSMutableURLRequest * req = [[NSMutableURLRequest alloc] initWithURL:url];
        req.HTTPMethod = method;
        [NSURLConnection sendAsynchronousRequest:req
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *err){
                                   NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
                                   if (res.statusCode != 200) {
                                       NSError *err = [[NSError alloc] initWithDomain:@"siren" code:res.statusCode userInfo:@{NSLocalizedDescriptionKey: @"Request error. Code is HTTP Status Code."}];
                                       block(err, nil);
                                   } else {
                                       Siren_Entity *entity = [[Siren_Entity alloc] initWithData:data];
                                       block(nil, entity);
                                   }
                               }];
    } else {
        NSError *err = [[NSError alloc] initWithDomain:@"siren" code:1 userInfo:@{NSLocalizedDescriptionKey: @"No href to step to."}];
        block(err, nil);
    }

}


@end
