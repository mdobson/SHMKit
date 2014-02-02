//
//  Siren_LinkTests.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/2/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Siren_Parser.h"
#import "Siren_Entity.h"
#import "Siren_Link.h"

@interface Siren_LinkTests : XCTestCase

@end

@implementation Siren_LinkTests

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

- (void)testLinkParsing
{
    NSString *url = @"http://msiren.herokuapp.com/";
    Siren_Parser *parser = [[Siren_Parser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, Siren_Entity* entity){
        int i = 0;
        for (Siren_Link *link in entity.links) {
            switch (i) {
                case 0:
                    XCTAssert([link.rel count] == 1, @"More than one rel in the first link");
                    XCTAssert([link.rel[0] isEqualToString:@"museums"], @"First rel isn't museums");
                    break;
                case 1:
                    XCTAssert([link.rel count] == 1, @"More than one rel in the first link");
                    XCTAssert([link.rel[0] isEqualToString:@"self"], @"First rel isn't museums");
                    break;
            }
            i++;
        }
    }];
}

@end
