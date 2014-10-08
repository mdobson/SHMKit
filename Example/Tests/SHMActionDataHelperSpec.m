#import "Specta.h"
#import "SHMActionDataHelper.h"

SpecBegin(SHMActionDataHelper)

describe(@"Data Helper", ^{
    it(@"Will correctly encode parameters from a dictionary", ^{
        NSDictionary *components = @{@"one":@"1", @"two":@2};
        NSString * encoded = [SHMActionDataHelper encodeJSONData:components withError:nil];
        expect(encoded).notTo.beNil();
    });
});

SpecEnd
