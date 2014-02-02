//
//  Siren_Action_Field.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Siren_Action_Field : NSObject

@property NSString *name;
@property NSString *type;
@property NSString *value;

-(id) initWithDictionary:(NSDictionary *)data;

@end
