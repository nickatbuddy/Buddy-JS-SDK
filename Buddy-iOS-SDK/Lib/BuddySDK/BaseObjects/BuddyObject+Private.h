//
//  BuddyObject+Private.h
//  BuddySDK
//
//  Created by Erik Kerber on 12/2/13.
//
//

#import "BuddyObject.h"
#import "BPRestProvider.h"

@interface BuddyObject (Private)

- (instancetype)initBuddyWithClient:(id<BPRestProvider>)client;
- (instancetype)initBuddyWithResponse:(id)response andClient:(id<BPRestProvider>)rest;

- (NSDictionary *)buildUpdateDictionary;

+ (NSDictionary *)baseEnumMap;
+ (NSDictionary *)enumMap;


@end
