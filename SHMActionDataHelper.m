//
//  Siren_Action_Data_Helper.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/8/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMActionDataHelper.h"
#import "SHMUrlHelper.h"

@implementation SHMActionDataHelper

+(NSString *)encodeUrlData:(NSDictionary *)params {
    return [SHMUrlHelper encodeQueryData:params];
}

+(NSString *)encodeJSONData:(NSDictionary *)params withError:(NSError **)err {

    NSData *json = [NSJSONSerialization dataWithJSONObject:params
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:err];
    
    if (err) {
        return nil;
    } else {
        return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    }
}

@end
