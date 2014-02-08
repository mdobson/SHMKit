//
//  Siren_Action_Data_HelperTests.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/8/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Siren_Action_Data_Helper.h"

@interface Siren_Action_Data_HelperTests : XCTestCase

@end

@implementation Siren_Action_Data_HelperTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testJSONSerialization
{
    NSDictionary *components = @{@"one":@"1", @"two":@2};
    NSString * encoded = [Siren_Action_Data_Helper encodeJSONData:components withError:nil];
    XCTAssert(encoded != nil, @"Encoding failed with val: %@", encoded);
}

@end
