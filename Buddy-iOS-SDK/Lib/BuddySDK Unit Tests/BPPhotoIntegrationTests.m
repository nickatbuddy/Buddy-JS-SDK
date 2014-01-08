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

#ifdef kKW_DEFAULT_PROBE_TIMEOUT
#undef kKW_DEFAULT_PROBE_TIMEOUT
#endif
#define kKW_DEFAULT_PROBE_TIMEOUT 4.0

SPEC_BEGIN(BuddyPhotoSpec)

describe(@"BPPhotoIntegrationSpec", ^{
    context(@"When a user is logged in", ^{
        
        beforeAll(^{
            __block BOOL fin = NO;
            
            [BuddyIntegrationHelper bootstrapLogin:^{
                fin = YES;
            }];
            
            [[expectFutureValue(theValue(fin)) shouldEventually] beTrue];
        });
        
        afterAll(^{
            
        });
        
        it(@"Should allow users to post photos", ^{
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSString *imagePath = [bundle pathForResource:@"1" ofType:@"jpg"];
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            
            __block BPPhoto *newPhoto;
            [[Buddy photos] addPhoto:image withComment:@"Hello, comment!" callback:^(id buddyObject, NSError *error) {
                newPhoto = buddyObject;
            }];
            
            [[expectFutureValue(newPhoto) shouldEventually] beNonNil];
            [[expectFutureValue(theValue(newPhoto.contentLength)) shouldEventually] beGreaterThan:theValue(1)];
            [[expectFutureValue(newPhoto.contentType) shouldEventually] equal:@"image/png"];
            [[expectFutureValue(newPhoto.signedUrl) shouldEventually] haveLengthOfAtLeast:1];
//            [[expectFutureValue(newPhoto.description) shouldEventually] equal:@"Hello, comment!"];

        });
        
        pending_(@"Should allow retrieving photos", ^{
            
        });
        
        pending_(@"Should allow searching for images", ^{
            
        });
        
        it (@"Should allow the user to delete photos", ^{
            
        });
        
        
    });
});

SPEC_END

