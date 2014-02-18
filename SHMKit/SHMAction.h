//
//  Siren_Action.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMConstants.h"
@interface SHMAction : NSObject

@property NSString *name;
@property NSArray *class;
@property HTTP_VERB method;
@property NSString *href;
@property NSString *title;
@property NSString *type;
@property NSArray *fields;

-(id) initWithDictionary:(NSDictionary *)data;
-(void)performActionWithFields:(NSDictionary *)fields andCompletion:(void (^)(NSError *, NSHTTPURLResponse*, NSData *))block;

@end
