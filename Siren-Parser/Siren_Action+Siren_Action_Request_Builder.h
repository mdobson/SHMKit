//
//  Siren_Action+Siren_Action_Request_Builder.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/11/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "Siren_Action.h"

@interface Siren_Action (Siren_Action_Request_Builder)

-(NSMutableURLRequest *) constructRequest:(NSDictionary *)dict;
-(NSMutableURLRequest *) constructHTTPRequestWithParams:(NSDictionary *)dict;
-(NSMutableURLRequest *) constructBodylessHTTPRequestWithParams:(NSDictionary *)dict;
+ (HTTP_VERB) verbFromString:(NSString *)verb;
+ (NSString *) verbFromEnum:(HTTP_VERB)verb;

@end
