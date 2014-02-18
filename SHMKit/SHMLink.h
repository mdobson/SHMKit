//
//  Siren_Link.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHMLink : NSObject

@property NSArray *rel;
@property NSString *href;

-(id) initWithDictionary:(NSDictionary*)data;

@end
