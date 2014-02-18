//
//  URL_Helper.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/8/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHMUrlHelper : NSObject

+(NSString *)encodeQueryData:(NSDictionary *)params;

+(NSString *)encodeUrl:(NSString*)url withDictParams:(NSDictionary*)params;

@end
