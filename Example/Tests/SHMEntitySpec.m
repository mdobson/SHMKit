#import "Specta.h"
#import "SHMEntity.h"
#import "SHMParser.h"

SpecBegin(SHMEntity)

describe(@"Entity Parsing and Retrieval", ^{
    it(@"Should retrieve a base entity", ^AsyncBlock{
        NSString *uri = @"http://msiren.herokuapp.com/";
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:uri];
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
            expect(err).to.beNil();
            expect(entity.links.count).to.equal(2);
            expect(entity.class.count).to.equal(1);
            expect(entity.class[0]).to.equal(@"root");
            done();
        }];
    });
    
    it(@"Should properly navigate to a single link rel", ^AsyncBlock {
        NSString *uri = @"http://msiren.herokuapp.com/";
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:uri];
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
            [entity stepToLinkRel:@"museums" withCompletion:^(NSError *error, SHMEntity *entity) {
                expect(error).to.beNil();
                expect(entity.class.count).to.equal(2);
                expect(entity.class[0]).to.equal(@"museums");
                expect(entity.entities.count).to.equal(10);
                expect(entity.links.count).to.equal(1);
                expect(entity.actions.count).to.equal(4);
                done();
            }];
        }];
    });
    
    it(@"Should properly locate a link rel that is present", ^AsyncBlock {
        NSString *uri = @"http://msiren.herokuapp.com/";
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:uri];
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
            expect([entity hasLinkRel:@"museums"]).to.equal(YES);
            done();
        }];
    });
    
    it(@"Should indicate when a link rel is not present", ^AsyncBlock {
        NSString *uri = @"http://msiren.herokuapp.com/";
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:uri];
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
            expect([entity hasLinkRel:@"foo"]).to.equal(NO);
            done();
        }];
    });
});

SpecEnd
