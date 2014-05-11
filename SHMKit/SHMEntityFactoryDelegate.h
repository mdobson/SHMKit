//
//  SHMEntityFactoryDelegate.h
//  SHMKit
//
//  Created by Matthew Dobson on 5/10/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHMEntity.h"
/*
 * A factory delegate that allows us to control the parsing logic of incoming data from API requests
 */
@protocol SHMEntityFactoryDelegate <NSObject>

/*
 * This method is called when data is received from an HTTP request to an API.
 */
-(SHMEntity *)didRecieveRequestData:(NSData*)requestResult;

/*
 * This method should be called if a specific delegate 
 */
-(BOOL)didRecieveRequestHeaders:(NSDictionary *)headers;
@end
