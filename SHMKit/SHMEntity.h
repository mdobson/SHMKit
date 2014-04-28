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

/*
 Initialize a new Siren Entity with an NSData class. This is ideal for when you're making HTTP requests straight to the API.
 */
-(id) initWithData:(NSData *)data;

/*
 Init a siren entity with a dictionary. If you want to do parsing yourself, or are constructing siren entities in a NSDictionary on your end use this method.
 */
-(id) initWithDictionary:(NSDictionary *)json;

/*
 Async step to link relation in current entity. If relation isn't present then return error as first parameter to the block.
 */
-(void) stepToLinkRel:(NSString *)linkRel withCompletion:(void (^)(NSError *error, SHMEntity *entity))block;

/*
 Get a specific siren action from the entity. If no action with that particular name is present return nil.
 */
-(SHMAction *) getSirenAction:(NSString *)name;

@end
