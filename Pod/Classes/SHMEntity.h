//
//  Siren_Entity.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMAction.h"
#import "SHMLink.h"

@interface SHMEntity : NSObject

@property (nonatomic, retain) NSArray *class;
@property (nonatomic, retain) NSDictionary *properties;
@property (nonatomic, retain) NSArray *entities;
@property (nonatomic, retain) NSArray *links;
@property (nonatomic, retain) NSArray *actions;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSArray *subEntityRels;
@property (nonatomic, retain) NSString *href;

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
 Async step to link in current entity. If relation isn't present then return error as first parameter to the block.
 */
-(void) stepToLink:(SHMLink *)link withCompletion:(void (^)(NSError *error, SHMEntity *entity))block;
/*
 Async step to href property on entity. Typically used with linked sub-entities.
 */
-(void) stepToHrefWithCompletion:(void (^)(NSError *error, SHMEntity *entity))block;

/*
 Get a specific siren action from the entity. If no action with that particular name is present return nil.
 */
-(SHMAction *) getSirenAction:(NSString *)name;

/*
 Check if we have a link in the siren document.
 */
-(BOOL) hasLinkRel:(NSString *)linkRel;

/*
 Retrieve first link for relation if available, otherwise return nil.
 */
-(NSString *) linkForRel:(NSString *)linkRel;

/*
 Retrieve all links for relation. If none empty array will be returned.
*/
-(NSArray *)linksForRel:(NSString *)linkRel;


/*
 Retrieve a link for name if available, otherwise return nil.
*/
-(NSString *) linkForTitle:(NSString *)linkTitle;

/*
 Retrieve full link object representations.
*/
-(NSArray *) linkObjectsForRel:(NSString *)linkRel;

/* 
 Retrieve link object for title.
*/
-(SHMLink *) linkObjectForTitle:(NSString *)linkTitle;

@end
