#import "Specta.h"
#import "SHMRequestFactory.h"
#import "SHMParser.h"
#import "SHMConstants.h"

SpecBegin(SHMRequestFactory)

describe(@"Request factory", ^{
    it(@"builds GET requests", ^AsyncBlock{
        NSString *url = @"http://msiren.herokuapp.com/";
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
           [entity stepToLinkRel:@"museums" withCompletion:^(NSError *error, SHMEntity *entity) {
               SHMAction *action = [entity getSirenAction:@"get-museums"];
               NSDictionary *params = @{@"query":@"where museum='DIA'", @"limit": @"5"};
               NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForAction:action withParams:params];
               expect(req.HTTPMethod).to.equal(@"GET");
               expect([req.URL absoluteString]).to.equal(@"http://msiren.herokuapp.com/museums?query=where%20museum='DIA'&limit=5");
               done();
           }];
        }];
    });
    it(@"builds POST requests", ^AsyncBlock{
        NSString *url = @"http://msiren.herokuapp.com/";
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
            [entity stepToLinkRel:@"museums" withCompletion:^(NSError *error, SHMEntity *entity) {
                SHMAction *action = [entity getSirenAction:@"add-museum"];
                NSDictionary *params = @{@"museum": @"DIA", @"address": @"5200 Woodward Ave.", @"city": @"Detroit"};
                NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForAction:action withParams:params];
                
                NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:req.HTTPBody options:kNilOptions error:nil];
                
                expect(req.HTTPMethod).to.equal(@"POST");
                expect(parsedData[@"museum"]).to.equal(@"DIA");
                expect(parsedData[@"address"]).to.equal(@"5200 Woodward Ave.");
                expect(parsedData[@"city"]).to.equal(@"Detroit");
                done();
            }];
        }];
    });
    
    it(@"builds PUT requests", ^AsyncBlock{
        NSString *url = @"http://msiren.herokuapp.com/";
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
            [entity stepToLinkRel:@"museums" withCompletion:^(NSError *error, SHMEntity *entity) {
                    SHMAction *action = [entity getSirenAction:@"update-museum"];
                    NSDictionary *params = @{@"museum": @"DIA", @"address": @"5200 Woodward Ave.", @"city": @"Detroit"};
                    NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForAction:action withParams:params];
                    NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:req.HTTPBody options:kNilOptions error:nil];
                
                    expect(req.HTTPMethod).to.equal(@"PUT");
                    expect(parsedData[@"museum"]).to.equal(@"DIA");
                    expect(parsedData[@"address"]).to.equal(@"5200 Woodward Ave.");
                    expect(parsedData[@"city"]).to.equal(@"Detroit");
                    done();
            }];
        }];
    });
         
    it(@"builds DELETE requests", ^AsyncBlock{
        NSString *url = @"http://msiren.herokuapp.com/";
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
            [entity stepToLinkRel:@"museums" withCompletion:^(NSError *error, SHMEntity *entity) {
                SHMEntity *first = entity.entities[0];
                [first stepToLinkRel:@"self" withCompletion:^(NSError *error, SHMEntity *entity) {
                    SHMAction *action = [entity getSirenAction:@"delete-museum"];
                    NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForAction:action withParams:nil];
                    expect([req.URL absoluteString]).to.equal(action.href);
                    expect(req.HTTPMethod).to.equal(@"DELETE");
                    done();
                }];
            }];
        }];
    });
    
    it(@"Will build links off of fragments", ^{
        [[SHMRequestFactory sharedFactory] setBaseUrl:[NSURL URLWithString:@"http://msiren.herokuapp.com/"]];
        NSURL *url = [[SHMRequestFactory sharedFactory] generateUrlForHref:@"/museums"];
        expect([url absoluteString]).to.equal(@"http://msiren.herokuapp.com/museums");
    });
    
    it(@"Will use full hrefs instead of default url", ^{
        [[SHMRequestFactory sharedFactory] setBaseUrl:[NSURL URLWithString:@"http://example.com/"]];
        NSURL *url = [[SHMRequestFactory sharedFactory] generateUrlForHref:@"http://msiren.herokuapp.com/museums"];
        expect([url absoluteString]).to.equal(@"http://msiren.herokuapp.com/museums");
    });
    
    it(@"Will put together fragment links in actions", ^AsyncBlock{
        NSString *url = @"http://msiren.herokuapp.com/";
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:url];
        [parser retrieveRoot:^(NSError *err, SHMEntity* entity){
            [entity stepToLinkRel:@"museums"
                   withCompletion:^(NSError *err, SHMEntity *entity){
                       SHMAction *action = [entity getSirenAction:@"get-museums-fragment"];
                       NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"where museum='DIA'", @"query", @"5", @"limit", nil];
                       NSURLRequest *req = [[SHMRequestFactory sharedFactory] constructRequestForAction:action withParams:dict];
                       expect(req.HTTPMethod).to.equal(@"GET");
                       expect([req.URL absoluteString]).to.equal(@"http://msiren.herokuapp.com/museums?query=where%20museum='DIA'&limit=5");
                       done();
                   }];
        }];

    
    });
});

SpecEnd
