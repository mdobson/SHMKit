#import "Specta.h"
#import "SHMUrlHelper.h"

SpecBegin(SHMUrlHelper)

describe(@"Url Helper", ^{
    it(@"encodes components in a dictionary", ^{
        NSDictionary *components = @{@"one":@"1", @"two":@2};
        NSString * encoded = [SHMUrlHelper encodeQueryData:components];
        expect(encoded).to.equal(@"one=1&two=2");
    });
    it(@"encodes components with spaces present", ^{
        NSDictionary *components = @{@"one":@" 1 ", @"two":@2};
        NSString * encoded = [SHMUrlHelper encodeQueryData:components];
        expect(encoded).to.equal(@"one=%201%20&two=2");
    });
    it(@"encodes and appends to url properly", ^{
        NSString *root = @"http://www.example.com";
        NSDictionary *components = @{@"one":@"1", @"two":@2};
        NSString *url = [SHMUrlHelper encodeUrl:root withDictParams:components];
        expect(url).to.equal(@"http://www.example.com?one=1&two=2");
    });
});

SpecEnd
