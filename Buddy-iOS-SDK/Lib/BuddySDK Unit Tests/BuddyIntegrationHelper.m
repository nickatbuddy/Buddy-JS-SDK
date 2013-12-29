//
//  BuddyIntegrationHelper.m
//  BuddySDK
//
//  Created by Erik Kerber on 12/29/13.
//
//

#import "BuddyIntegrationHelper.h"
#import "Buddy.h"

@implementation BuddyIntegrationHelper

+ (void) bootstrapLogin:(void(^)())complete
{
    [Buddy initClient:APP_NAME appKey:APP_KEY complete:^{
        NSDictionary *options = @{@"name": @"Erik Kerber",
                                  @"gender": @(BPUserGender_Male),
                                  @"email": @"erik.kerber@gmail.com",
                                  @"dateOfBirth": [NSNull null],
                                  @"relationshipStatus": @(BPUserRelationshipStatusOnTheProwl),
                                  @"celebrityMode": @(YES),
                                  @"fuzzLocation": @(NO)
                                  };
        
        [Buddy createUser:TEST_USERNAME password:TEST_PASSWORD options:options completed:^(BPUser *newBuddyObject) {
            [Buddy login:TEST_USERNAME password:TEST_PASSWORD completed:^(BPUser *loggedInsUser) {
                complete();
            }];
        }];
    }];
}

@end