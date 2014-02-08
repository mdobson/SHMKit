//
//  Siren_Action_Data_Helper.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/8/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "Siren_Action_Data_Helper.h"
#import "URL_Helper.h"

@implementation Siren_Action_Data_Helper

+(NSString *)encodeUrlData:(NSDictionary *)params {
    return [URL_Helper encodeQueryData:params];
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
