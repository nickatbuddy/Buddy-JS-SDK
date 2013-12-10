//
//  BPCheckinCollection.m
//  BuddySDK
//
//  Created by Erik Kerber on 11/15/13.
//
//

#import "BPCheckinCollection.h"
#import "BPCheckin.h"
#import "BPClient.h"
#import "JAGPropertyConverter.h"

@implementation BPCheckinCollection

-(instancetype)init{
    self = [super init];
    if(self){
        self.type = [BPCheckin class];
    }
    return self;
}

-(void)checkinWithComment:(NSString *)comment
              description:(NSString *)description
                 complete:(BuddyObjectCallback)complete
{
    NSDictionary *parameters = @{@"comment": comment,
                                 @"description": description,
                                 @"location": @"1.2, 3.4"};
    
    [BPCheckin createFromServerWithParameters:parameters complete:^(BPCheckin *newBuddyObject) {
        [newBuddyObject refresh:^{
            complete(newBuddyObject);
        }];
    }];
}

-(void)checkinWithComment:(NSString *)comment
          description:(NSString *)description
      defaultMetadata:(NSString *)defaultMetadata
      readPermissions:(BuddyPermissions)readPermissions
     writePermissions:(BuddyPermissions)writePermissions
             complete:(BuddyObjectCallback)complete
{
    [NSException raise:@"NotImplementedException" format:@"Not Implemented."];
}

// TODO - don't put this here
+(JAGPropertyConverter *)converter
{
    static JAGPropertyConverter *c;
    if(!c)
    {
        c = [JAGPropertyConverter new];
        
        // TODO - necessary?
        __weak typeof(self) weakSelf = self;
        c.identifyDict = ^Class(NSDictionary *dict) {
            if ([dict valueForKey:@"userID"]) {
                return [weakSelf class];
            }
            return [weakSelf class];
        };
        
    }
    return c;
}


-(void)getCheckins:(BuddyCollectionCallback)complete
{
    [[BPClient defaultClient] getAll:[[BPCheckin class] requestPath] complete:^(NSArray *buddyObjects) {
        NSArray *f = [buddyObjects map:^id(id object) {
            id newO = [[self.type alloc] init];
            [[[self class]converter] setPropertiesOf:newO fromDictionary:object];
            return newO;
        }];
        complete(f);
    }];
}

-(void)addCheckin:(BPCheckin *)checkin
{
    
}
@end
