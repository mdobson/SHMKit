//
//  Request_BuilderTests.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/11/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Siren_Action.h"
#import "Siren_Action+Siren_Action_Request_Builder.h"
#import "Siren_Parser.h"
#import "Siren_Entity.h"


@interface Request_BuilderTests : XCTestCase

@end

@implementation Request_BuilderTests

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

- (void)testBuildGET
{
    NSString *url = @"http://msiren.herokuapp.com/";
    Siren_Parser *parser = [[Siren_Parser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, Siren_Entity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, Siren_Entity *entity){
                   Siren_Action *action = [entity getSirenAction:@"get-museums"];
                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"where museum='DIA'", @"query", @"5", @"limit", nil];
                   NSMutableURLRequest *req = [action constructRequest:dict];
                   XCTAssertTrue([req.HTTPMethod isEqualToString:@"GET"], @"Incorrect HTTP Method expecting GET had %@", req.HTTPMethod);
                   XCTAssertTrue([[req.URL absoluteString] isEqualToString:@"http://msiren.herokuapp.com/museums?query=where%20museum=%27DIA%27&limit=5"], @"Incorrect HTTP Method expecting GET had %@", req.HTTPMethod);
               }];
    }];
}

- (void)testBuildPOST
{
    NSString *url = @"http://msiren.herokuapp.com/";
    Siren_Parser *parser = [[Siren_Parser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, Siren_Entity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, Siren_Entity *entity){
                   Siren_Action *action = [entity getSirenAction:@"add-museum"];
                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"DIA", @"museum", @"5200 Woodward Ave.", @"address", @"Detroit", @"city", nil];
                   NSMutableURLRequest *req = [action constructRequest:dict];
                   NSDictionary *d = [NSJSONSerialization JSONObjectWithData:req.HTTPBody options:kNilOptions error:nil];
                   XCTAssertTrue([d[@"museum"] isEqualToString:@"DIA"], @"Museum not DIA");
                   XCTAssertTrue([d[@"address"] isEqualToString:@"5200 Woodward Ave"], @"Museum not DIA");
                   XCTAssertTrue([d[@"city"] isEqualToString:@"Detroit"], @"Museum not DIA");
                   XCTAssertTrue([req.HTTPMethod isEqualToString:@"POST"], @"Incorrect HTTP Method expecting POST had %@", req.HTTPMethod);

               }];
    }];
}

- (void)testBuildPUT
{
    NSString *url = @"http://msiren.herokuapp.com/";
    Siren_Parser *parser = [[Siren_Parser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, Siren_Entity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, Siren_Entity *entity){
                   Siren_Action *action = [entity getSirenAction:@"update-museum"];
                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"DIA", @"museum", @"5200 Woodward Ave.", @"address", @"Detroit", @"city", nil];
                   NSMutableURLRequest *req = [action constructRequest:dict];
                   NSDictionary *d = [NSJSONSerialization JSONObjectWithData:req.HTTPBody options:kNilOptions error:nil];
                   XCTAssertTrue([d[@"museum"] isEqualToString:@"DIA"], @"Museum not DIA");
                   XCTAssertTrue([d[@"address"] isEqualToString:@"5200 Woodward Ave"], @"Museum not DIA");
                   XCTAssertTrue([d[@"city"] isEqualToString:@"Detroit"], @"Museum not DIA");
                   XCTAssertTrue([req.HTTPMethod isEqualToString:@"POST"], @"Incorrect HTTP Method expecting POST had %@", req.HTTPMethod);
                   XCTAssertTrue([req.HTTPMethod isEqualToString:@"PUT"], @"Incorrect HTTP Method expecting PUT had %@", req.HTTPMethod);
               }];
    }];
}

- (void)testBuildDELETE
{
    NSString *url = @"http://msiren.herokuapp.com/";
    Siren_Parser *parser = [[Siren_Parser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, Siren_Entity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, Siren_Entity *entity){
                   Siren_Entity *first = entity.entities[0];
                   Siren_Action *action = [first getSirenAction:@"delete-museum"];
                   NSMutableURLRequest *req = [action constructRequest:nil];
                   XCTAssertTrue([[req.URL absoluteString] isEqualToString:action.href], @"HREF doesn't match");
                   XCTAssertTrue([req.HTTPMethod isEqualToString:@"DELETE"], @"Incorrect HTTP Method expecting DELETE had %@", req.HTTPMethod);
               }];
    }];
}

//- (void)testBuildPATCH
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}
//
//- (void)testBuildTRACE
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}
//
//- (void)testBuildOPTIONS
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}
//
//- (void)testBuildCONNECT
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}
//
//- (void)testBuildHEAD
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

@end
