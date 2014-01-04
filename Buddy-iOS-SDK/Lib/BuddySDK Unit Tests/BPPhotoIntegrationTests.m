//
//  BPPhotoIntegrationTests.m
//  BuddySDK
//
//  Created by Erik Kerber on 12/3/13.
//
//

#import "Buddy.h"
#import "BuddyIntegrationHelper.h"
#import <Kiwi/Kiwi.h>

SPEC_BEGIN(BuddyPhotoSpec)

describe(@"BPPhotoIntegrationSpec", ^{
    context(@"When a user is logged in", ^{
        
        beforeAll(^{
            __block BOOL fin = NO;
            
            [BuddyIntegrationHelper bootstrapLogin:^{
                fin = YES;
            }];
            
            [[expectFutureValue(theValue(fin)) shouldEventuallyBeforeTimingOutAfter(4.0)] beTrue];
        });
        
        afterAll(^{
            
        });
        
        it(@"Should allow users to post photos", ^{
            //[Buddy photos]
        });
    });
});

SPEC_END

