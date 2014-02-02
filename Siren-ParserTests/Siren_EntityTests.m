//
//  Siren_EntityTests.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/2/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Siren_Parser.h"
#import "Siren_Entity.h"

@interface Siren_EntityTests : XCTestCase

@end

@implementation Siren_EntityTests

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

- (void)testEntityParsing
{
    NSString *url = @"http://msiren.herokuapp.com/";
    Siren_Parser *parser = [[Siren_Parser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, Siren_Entity* entity){
        XCTAssert([entity.class count] == 1, @"There is more than one entity class");
        XCTAssert([entity.class[0] isEqualToString:@"root"], @"First class in array isn't root");
        XCTAssert([entity.links count] == 2, @"Two links in the root API");
    }];
}

- (void)testEntityNavigation
{
    NSString *url = @"http://msiren.herokuapp.com/";
    Siren_Parser *parser = [[Siren_Parser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, Siren_Entity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, Siren_Entity *entity){
                   XCTAssert(err == nil, @"Error doesn't equal nil");
                   XCTAssert([entity.class count] == 2, @"Class amount is incorrect");
                   XCTAssert([entity.entities count] == 10, @"Class amount is incorrect");
                   XCTAssert([entity.actions count] == 1, @"Class amount is incorrect");
                   XCTAssert([entity.links count] == 1, @"Class amount is incorrect");
               }];
    }];
}

@end
