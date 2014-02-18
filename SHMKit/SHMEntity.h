//
//  Siren_Entity.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMAction.h"

@interface SHMEntity : NSObject

@property NSArray *class;
@property NSDictionary *properties;
@property NSArray *entities;
@property NSArray *links;
@property NSArray *actions;
@property NSString *title;

-(id) initWithData:(NSData *)data;
-(id) initWithDictionary:(NSDictionary *)json;
-(void) stepToLinkRel:(NSString *)linkRel withCompletion:(void (^)(NSError *error, SHMEntity *entity))block;
-(SHMAction *) getSirenAction:(NSString *)name;

@end
