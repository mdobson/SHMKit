//
//  Siren_Action.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMConstants.h"

@class SHMEntity;
@interface SHMAction : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *class;
@property HTTP_VERB method;
@property (nonatomic, retain) NSString *href;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSArray *fields;
@property (nonatomic, retain) NSString *methodString;

/*
 Initialize a action object with a dictionary. This is for post parsing of siren entity. Internal use really.
 */
-(id) initWithDictionary:(NSDictionary *)data;

/*
 Perform the action with specific parameters. If no parameters pass in nil. Actions are performed asynchronously so the block will be necessary to get the next step in the API.
 */
-(void)performActionWithFields:(NSDictionary *)fields andCompletion:(void (^)(NSError *, SHMEntity *))block;

/*
 Perform the action with no parameters. Actions are performed asynchronously so the block will be necessary to get the next step in the API.
 */
-(void)performActionWithCompletion:(void (^)(NSError *, SHMEntity *))block;
@end
