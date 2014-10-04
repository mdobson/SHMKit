//
//  Siren_Link.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHMLink : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSArray *rel;
@property (nonatomic, retain) NSString *href;

/*
 Initialize a link relation object with a dictionary. This is for post parsing of siren entity. Internal use really.
 */
-(id) initWithDictionary:(NSDictionary*)data;

@end
