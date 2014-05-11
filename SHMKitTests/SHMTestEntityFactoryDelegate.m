//
//  SHMTestEntityFactoryDelegate.m
//  SHMKit
//
//  Created by Matthew Dobson on 5/10/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMTestEntityFactoryDelegate.h"


@implementation SHMTestEntityFactoryDelegate

-(SHMEntity *) didRecieveRequestData:(NSData *)requestResult {
    SHMEntity *parsedEntity = [[SHMEntity alloc] initWithData:requestResult];
    return parsedEntity;
}

-(BOOL) didRecieveRequestHeaders:(NSDictionary *)headers {
    NSString *contentType = [headers objectForKey:@"Content-Type"];
    return contentType != nil && ([contentType isEqualToString:@"application/json"] || [contentType isEqualToString:@"application/vnd.siren+json"]);
}

@end
