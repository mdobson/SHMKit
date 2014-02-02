//
//  Siren_ParserTests.m
//  Siren-ParserTests
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Siren_Parser.h"
#import "Siren_Entity.h"

@interface Siren_ParserTests : XCTestCase

@end

@implementation Siren_ParserTests

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
    Siren_Parser *parser = [[Siren_Parser alloc] initWithSirenRoot:url];
    XCTAssert(parser.endpoint == url, @"URLs: parser:%@ base:%@", parser.endpoint, url);
    
}

- (void)testGetRoot
{
    NSString *url = @"http://msiren.herokuapp.com/";
    Siren_Parser *parser = [[Siren_Parser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *error, Siren_Entity *entity){
        XCTAssert(error == nil, @"Error is not nil");
        XCTAssert(entity != nil, @"Entity is nil");
    }];
}

- (void)testGetRootSendsError
{
    NSString * url = @"http://mattsaidshouldfail.com/";
    Siren_Parser *parser = [[Siren_Parser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, Siren_Entity *entity){
        XCTAssert(err != nil, @"Retrieved endpoint successfully?");
        XCTAssert(entity == nil, @"Entity not nil.");
    }];
}

@end
