//
//  URL_Helper.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/8/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMUrlHelper.h"

@implementation SHMUrlHelper

+(NSString *) encodeQueryData:(NSDictionary *)params {
    NSMutableArray *encodedParams = [[NSMutableArray alloc] init];
    
    for (id key in params) {
        NSString *keyVal = (NSString *)key;
        NSString *valVal = nil;
        id value = [params objectForKey:key];
        if ([value isMemberOfClass:[NSNumber class]]) {
            valVal = [value stringValue];
        } else {
            valVal = (NSString*)value;
        }
        
        [encodedParams addObject:[NSString stringWithFormat:@"%@=%@", keyVal, valVal]];
    }
    
    return [[encodedParams componentsJoinedByString:@"&"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *) encodeUrl:(NSString *)url withDictParams:(NSDictionary *)params {
    NSString *components = [SHMUrlHelper encodeQueryData:params];
    return [NSString stringWithFormat:@"%@?%@", url, components];
}

@end
