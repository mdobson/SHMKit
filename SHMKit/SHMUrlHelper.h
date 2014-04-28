//
//  URL_Helper.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/8/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHMUrlHelper : NSObject

/*
 Encoding query data for url string.
 */
+(NSString *)encodeQueryData:(NSDictionary *)params;

/*
 Encode complete url with query string.
 */
+(NSString *)encodeUrl:(NSString*)url withDictParams:(NSDictionary*)params;

@end
