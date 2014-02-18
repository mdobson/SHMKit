//
//  Siren_ParserTests.m
//  Siren-ParserTests
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHMParser.h"
#import "SHMEntity.h"

@interface SHMParserTests : XCTestCase

@end

@implementation SHMParserTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit
{
    NSString *url = @"http://msiren.herokuapp.com/";
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    XCTAssert(parser.endpoint == url, @"URLs: parser:%@ base:%@", parser.endpoint, url);
    
}

- (void)testGetRoot
{
    NSString *url = @"http://msiren.herokuapp.com/";
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *error, SHMEntity *entity){
        XCTAssert(error == nil, @"Error is not nil");
        XCTAssert(entity != nil, @"Entity is nil");
    }];
}

- (void)testGetRootSendsError
{
    NSString * url = @"http://mattsaidshouldfail.com/";
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, SHMEntity *entity){
        XCTAssert(err != nil, @"Retrieved endpoint successfully?");
        XCTAssert(entity == nil, @"Entity not nil.");
    }];
}

@end
