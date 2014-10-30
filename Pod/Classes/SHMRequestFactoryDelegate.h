//
//  SHMRequestFactoryDelegate.h
//  SHMKit
//
//  Created by Matthew Dobson on 5/11/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMAction.h"

@protocol SHMRequestFactoryDelegate <NSObject>

-(NSURLRequest *) buildRequestForAction:(SHMAction *)action withParameters:(NSDictionary *)params;

-(NSURLRequest *) buildBodylessRequestForAction:(SHMAction *)action withParameters:(NSDictionary *)params;

-(NSString *) setAuthorizationTokenHeader;

@end
