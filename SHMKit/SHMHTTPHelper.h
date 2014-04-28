//
//  SHMHTTPHelper.h
//  SHMKit
//
//  Created by Matthew Dobson on 4/28/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMEntity.h"

@interface SHMHTTPHelper : NSObject

+(void) sendSirenRequest:(NSMutableURLRequest *)req withBlock:(void (^)(NSError *error, SHMEntity *entity))block;

@end
