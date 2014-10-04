#import "Specta.h"
#import "SHMParser.h"

SpecBegin(SHMParser)

describe(@"Constructor", ^{
    
    it(@"Should retrieve the API Root", ^AsyncBlock{
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:@"http://zetta-cloud-devices.herokuapp.com/"];
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
            expect(entity.class).to.equal(@[@"root"]);
            done();
        }];
    });
    
    it(@"Will throw an error if there is a bad endpoint", ^AsyncBlock{
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:@"http://foo/"];
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
            expect(err.domain).to.equal(@"siren");
            done();
        }];
    });
    
});


SpecEnd
