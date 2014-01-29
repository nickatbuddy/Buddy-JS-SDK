//
//  BPAlbum.h
//  BuddySDK
//
//  Created by Erik Kerber on 1/8/14.
//
//

#import "Buddy.h"

@interface BPAlbum : BuddyObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *comment;

- (void)addItemToAlbum:(id)albumItem callback:(BuddyCompletionCallback)callback;

@end