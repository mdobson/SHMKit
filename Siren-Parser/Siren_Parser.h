//
//  Siren_Parser.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Siren_Entity.h"

@interface Siren_Parser : NSObject

@property NSString *endpoint;

-(id) initWithSirenRoot:(NSString*)endpoint;

-(void) retrieveRoot:(void (^)(NSError *err, Siren_Entity* entity))block;
@end

