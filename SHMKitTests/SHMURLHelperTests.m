//
//  URL_HelperTests.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/8/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHMUrlHelper.h"

@interface SHMURLHelperTests : XCTestCase

@end

@implementation SHMURLHelperTests

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

- (void)testComponentsEncoded
{
    NSDictionary *components = @{@"one":@"1", @"two":@2};
    NSString * encoded = [SHMUrlHelper encodeQueryData:components];
    XCTAssert([encoded isEqualToString:@"one=1&two=2"], @"Encoding failed with val: %@", encoded);
}

- (void)testComponentsEncodedWithPercents
{
    NSDictionary *components = @{@"one":@" 1 ", @"two":@2};
    NSString * encoded = [SHMUrlHelper encodeQueryData:components];
    XCTAssert([encoded isEqualToString:@"one=%201%20&two=2"], @"Encoding failed with val: %@", encoded);
}

- (void)testUrlEncoded
{
    NSString *root = @"http://www.example.com";
    NSDictionary *components = @{@"one":@"1", @"two":@2};
    NSString *url = [SHMUrlHelper encodeUrl:root withDictParams:components];
    XCTAssert([url isEqualToString:@"http://www.example.com?one=1&two=2"], @"Encoding failed with val: %@", url);
}

@end
