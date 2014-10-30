//
//  Siren_Parser.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMEntity.h"

@interface SHMParser : NSObject

@property (nonatomic, retain) NSString *endpoint;
@property (nonatomic, retain) NSString *accessToken;

/*
Initializes a siren root. The endpoint parameter should be the entry point for your API. Ideally this should be placed in an App Delegate if possible.
*/
-(id) initWithSirenRoot:(NSString*)endpoint;


/*
Retrieves the root of your API Asynchronously. Pass in the block to get the first entity of your API.
*/
-(void) retrieveRoot:(void (^)(NSError *err, SHMEntity* entity))block;
@end

