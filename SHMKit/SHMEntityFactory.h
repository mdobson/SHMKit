//
//  SHMHTTPHelper.h
//  SHMKit
//
//  Created by Matthew Dobson on 4/28/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMEntity.h"
#import "SHMEntityFactoryDelegate.h"

typedef void (^SirenHTTPResult) (NSError *error, SHMEntity *entity);

@interface SHMEntityFactory : NSObject

@property (nonatomic, retain) id<SHMEntityFactoryDelegate> delegate;

+(id) sharedFactory;

-(void) sendSirenRequest:(NSURLRequest *)req withBlock:(void (^)(NSError *error, SHMEntity *entity))block;

@end
