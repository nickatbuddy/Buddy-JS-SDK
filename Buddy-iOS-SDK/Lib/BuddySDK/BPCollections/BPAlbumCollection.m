//
//  BPAlbumCollection.m
//  BuddySDK
//
//  Created by Erik Kerber on 1/24/14.
//
//

#import "BPAlbumCollection.h"
#import "BuddyObject+Private.h"
#import "BPAlbum.h"

@implementation BPAlbumCollection

- (instancetype)initWithClient:(id<BPRestProvider>)client{
    self = [super initWithClient:client];
    if(self){
        self.type = [BPAlbum class];
    }
    return self;
}
    
- (void)addAlbum:(NSString *)name
     withComment:(NSString *)comment
        callback:(BuddyObjectCallback)callback
{
    NSDictionary *parameters = @{
                                 @"name": BOXNIL(name),
                                 @"comment": BOXNIL(comment)
                                 };
    
    [self.type createFromServerWithParameters:parameters client:self.client callback:callback];
}
    
    
-(void)getAlbums:(BuddyCollectionCallback)callback
{
    [self getAll:callback];
}
    
-(void)searchAlbums:(BuddyCollectionCallback)callback
{
    NSDictionary *parameters = @{
                                 @"ownerID": BOXNIL([Buddy user].id)
                                 };
    
    [self search:parameters callback:callback];
}
    
- (void)getAlbum:(NSString *)albumId callback:(BuddyObjectCallback)callback
{
    [self getItem:albumId callback:callback];
}

@end