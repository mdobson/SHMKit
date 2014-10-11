#import "Specta.h"
#import "SHMLink.h"
#import "SHMParser.h"
#import "SHMEntity.h"

SpecBegin(SHMLink)

describe(@"SHMLink class", ^{
    it(@"will parse links into objects", ^{
        NSDictionary *mockLink = @{@"rel":@[@"self"], @"href":@"http://foo.com/", @"title": @"A link to myself"};
        SHMLink *link = [[SHMLink alloc] initWithDictionary:mockLink];
        expect(link.rel.count).to.equal(1);
        expect(link.href).to.equal(@"http://foo.com/");
        expect(link.title).to.equal(@"A link to myself");
    });
    
    it(@"will have links populated on entities", ^AsyncBlock{
        SHMParser *parser = [[SHMParser alloc] initWithSirenRoot:@"http://msiren.herokuapp.com/"];
        
        [parser retrieveRoot:^(NSError *err, SHMEntity *entity) {
            expect(entity.links.count).to.equal(2);
            SHMLink *museums = entity.links[0];
            SHMLink *selfLink = entity.links[1];
            expect(selfLink.rel[0]).to.equal(@"self");
            expect(museums.rel[0]).to.equal(@"museums");
            expect(museums.rel[1]).to.equal(@"collection");
            expect(museums.title).to.beNil();
            expect(selfLink.title).to.beNil();
            done();
        }];
    });
});

SpecEnd
