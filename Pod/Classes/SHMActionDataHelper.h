//
//  Siren_Action_Data_Helper.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/8/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHMActionDataHelper : NSObject

/*
 Encode query data url style for siren action
 */
+(NSString *) encodeUrlData:(NSDictionary *)params;

/*
 Encode data JSON style for siren action.
 */
+(NSString *) encodeJSONData:(NSDictionary *)params withError:(NSError **)err;

@end
