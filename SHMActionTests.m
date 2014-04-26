//
//  SHMActionTests.m
//  SHMKit
//
//  Created by Matthew Dobson on 4/25/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHMAction.h"
#import "SHMAction+SHMActionRequestBuilder.h"
#import "SHMParser.h"
#import "SHMEntity.h"

@interface SHMActionTests : XCTestCase

@end

@implementation SHMActionTests

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

-(void)testPost
{
    NSString *url = @"http://msiren.herokuapp.com/";
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, SHMEntity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, SHMEntity *entity){
                   SHMAction *action = [entity getSirenAction:@"add-museum"];
                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"DIA", @"museum", @"5200 Woodward Ave.", @"address", @"Detroit", @"city", nil];
                   [action performActionWithFields:dict andCompletion:^(NSError *e, NSHTTPURLResponse *r, NSData *d) {
                       XCTAssert(e == nil, @"No error.");
                       NSError *parseError;
                       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:&parseError];
                       SHMEntity *entity = [[SHMEntity alloc] initWithDictionary:dict];
                       XCTAssert([entity.class count] == 1, @"Class amount is incorrect");
                       XCTAssert([entity.entities count] == 0, @"Class amount is incorrect");
                       XCTAssert([entity.actions count] == 1, @"Class amount is incorrect");
                       XCTAssert([entity.links count] == 2, @"Class amount is incorrect");
                       XCTAssert([entity.properties[@"museum"] isEqualToString:@"DIA"] == YES, @"Musuem prop amount is incorrect");
                       XCTAssert([entity.properties[@"address"] isEqualToString:@"5200 Woodward Ave."] == YES, @"Musuem prop amount is incorrect");
                       XCTAssert([entity.properties[@"city"] isEqualToString:@"Detroit"] == YES, @"Musuem prop amount is incorrect");
                       
                    }];
               }];
    }];
}

- (void)testGet
{
    NSString *url = @"http://msiren.herokuapp.com/";
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, SHMEntity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, SHMEntity *entity){
                   SHMAction *action = [entity getSirenAction:@"get-museums"];
                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"where museum='DIA'", @"query", @"5", @"limit", nil];
                   [action performActionWithFields:dict andCompletion:^(NSError * e, NSHTTPURLResponse * r, NSData * d) {
                       XCTAssert(e == nil, @"No error.");
                       NSError *parseError;
                       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:&parseError];
                       SHMEntity *entity = [[SHMEntity alloc] initWithDictionary:dict];
                       XCTAssert([entity.class count] == 2, @"Class amount is incorrect");
                       XCTAssert([entity.entities count] == 1, @"Class amount is incorrect");
                       XCTAssert([entity.actions count] == 3, @"Class amount is incorrect");
                       XCTAssert([entity.links count] == 1, @"Class amount is incorrect");
                   }];
               }];
    }];
}

- (void)testDelete
{
    
    NSString *url = @"http://msiren.herokuapp.com/";
    SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
    [parser retrieveRoot:^(NSError *err, SHMEntity* entity){
        [entity stepToLinkRel:@"museums"
               withCompletion:^(NSError *err, SHMEntity *entity){
                   SHMAction *action = [entity getSirenAction:@"get-museums"];
                   NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"where museum='DIA'", @"query", @"5", @"limit", nil];
                   [action performActionWithFields:dict andCompletion:^(NSError * e, NSHTTPURLResponse * r, NSData * d) {
                       XCTAssert(e == nil, @"No error.");
                       NSError *parseError;
                       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:&parseError];
                       SHMEntity *entity = [[SHMEntity alloc] initWithDictionary:dict];
                       SHMEntity *museum = entity.entities[0];
                       [museum stepToLinkRel:@"museums"
                              withCompletion:^(NSError *err, SHMEntity *entity){
                                  SHMAction *action = [entity getSirenAction:@"delete-museum"];
                                  [action performActionWithFields:nil andCompletion:^(NSError * e, NSHTTPURLResponse *r, NSData *d) {
                                      NSString *url = @"http://msiren.herokuapp.com/";
                                      SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
                                      [parser retrieveRoot:^(NSError *err, SHMEntity* entity){
                                          [entity stepToLinkRel:@"museums"
                                                 withCompletion:^(NSError *err, SHMEntity *entity){
                                                     SHMAction *action = [entity getSirenAction:@"get-museums"];
                                                     NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"where museum='DIA'", @"query", @"5", @"limit", nil];
                                                     [action performActionWithFields:dict andCompletion:^(NSError * e, NSHTTPURLResponse * r, NSData * d) {
                                                         XCTAssert(e == nil, @"No error.");
                                                         NSError *parseError;
                                                         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:&parseError];
                                                         SHMEntity *entity = [[SHMEntity alloc] initWithDictionary:dict];
                                                         XCTAssert([entity.class count] == 2, @"Class amount is incorrect");
                                                         XCTAssert([entity.entities count] == 0, @"Class amount is incorrect");
                                                         XCTAssert([entity.actions count] == 3, @"Class amount is incorrect");
                                                         XCTAssert([entity.links count] == 1, @"Class amount is incorrect");
                                                     }];
                                                 }];
                                      }];
                                  }];
                              }];
                   }];
               }];
    }];
}

@end
