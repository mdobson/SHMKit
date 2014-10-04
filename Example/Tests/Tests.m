//
//  SHMKitTests.m
//  SHMKitTests
//
//  Created by Matt Dobson on 10/04/2014.
//  Copyright (c) 2014 Matt Dobson. All rights reserved.
//

#import <Specta/Specta.h>
#import <SHMKit/SHMParser.h>

SpecBegin(InitialSpecs)

describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
    it(@"will wait and succeed", ^AsyncBlock {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            done();
        });
    });
});

SpecEnd
