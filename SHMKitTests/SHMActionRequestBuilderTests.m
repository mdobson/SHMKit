//
//  Request_BuilderTests.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/11/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHMAction.h"
#import "SHMRequestFactory.h"
#import "SHMParser.h"
#import "SHMEntity.h"
#import "SHMConstants.h"


@interface SHMActionRequestBuilderTests : XCTestCase

@end

@implementation SHMActionRequestBuilderTests

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
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, SHMEntity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, SHMEntity *entity){
                   SHMAction *action = [entity getSirenAction:@"get-museums"];
                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"where museum='DIA'", @"query", @"5", @"limit", nil];
                   NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForAction:action withParams:dict];
                   XCTAssertTrue([req.HTTPMethod isEqualToString:@"GET"], @"Incorrect HTTP Method expecting GET had %@", req.HTTPMethod);
                   XCTAssertTrue([[req.URL absoluteString] isEqualToString:@"http://msiren.herokuapp.com/museums?query=where%20museum=%27DIA%27&limit=5"], @"Incorrect HTTP Method expecting GET had %@", req.HTTPMethod);
               }];
    }];
}

- (void)testBuildPOST
{
    NSString *url = @"http://msiren.herokuapp.com/";
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, SHMEntity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, SHMEntity *entity){
                   SHMAction *action = [entity getSirenAction:@"add-museum"];
                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"DIA", @"museum", @"5200 Woodward Ave.", @"address", @"Detroit", @"city", nil];
                   NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForAction:action withParams:dict];
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
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, SHMEntity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, SHMEntity *entity){
                   SHMAction *action = [entity getSirenAction:@"update-museum"];
                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"DIA", @"museum", @"5200 Woodward Ave.", @"address", @"Detroit", @"city", nil];
                   NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForAction:action withParams:dict];
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
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, SHMEntity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, SHMEntity *entity){
                   SHMEntity *first = entity.entities[0];
                   SHMAction *action = [first getSirenAction:@"delete-museum"];
                   NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForAction:action withParams:nil];
                   XCTAssertTrue([[req.URL absoluteString] isEqualToString:action.href], @"HREF doesn't match");
                   XCTAssertTrue([req.HTTPMethod isEqualToString:@"DELETE"], @"Incorrect HTTP Method expecting DELETE had %@", req.HTTPMethod);
               }];
    }];
}


-(void)testVerbConversion {
    HTTP_VERB verb = [SHMConstants verbFromString:@"FOO"];
    XCTAssert(verb == 0, @"Bad verb returns zero");
}

-(void)testFragmentLinkBuild {
    [[SHMRequestFactory sharedFactory] setBaseUrl:[NSURL URLWithString:@"http://msiren.herokuapp.com/"]];
    
    NSURL *url = [[SHMRequestFactory sharedFactory] generateUrlForHref:@"/museums"];
    NSLog(@"URL: %@", [url absoluteString]);
    XCTAssertTrue([[url absoluteString] isEqualToString:@"http://msiren.herokuapp.com/museums"], @"Fragment not constructed properly");
}

-(void)testFullURLLinkBuild {
    [[SHMRequestFactory sharedFactory] setBaseUrl:[NSURL URLWithString:@"http://example.com"]];
    NSURL *url = [[SHMRequestFactory sharedFactory] generateUrlForHref:@"http://msiren.herokuapp.com/museums"];
    XCTAssertTrue([[url absoluteString] isEqualToString:@"http://msiren.herokuapp.com/museums"], @"Fragment not constructed properly");
}

- (void)testBuildGETWithFragment
{
    NSString *url = @"http://msiren.herokuapp.com/";
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, SHMEntity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, SHMEntity *entity){
                   SHMAction *action = [entity getSirenAction:@"get-museums-fragment"];
                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"where museum='DIA'", @"query", @"5", @"limit", nil];
                   NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForAction:action withParams:dict];
                   XCTAssertTrue([req.HTTPMethod isEqualToString:@"GET"], @"Incorrect HTTP Method expecting GET had %@", req.HTTPMethod);
                   XCTAssertTrue([[req.URL absoluteString] isEqualToString:@"http://msiren.herokuapp.com/museums?query=where%20museum=%27DIA%27&limit=5"], @"Incorrect HTTP Method expecting GET had %@", req.HTTPMethod);
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
