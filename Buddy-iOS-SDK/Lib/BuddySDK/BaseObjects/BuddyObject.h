//
//  BuddyObject.h
//  BuddySDK
//
//  Created by Erik Kerber on 9/11/13.
//
//

#import <Foundation/Foundation.h>
#import "BPRestProvider.h"

@protocol BuddyObjectProperties <NSObject>

@end

/**
 Permissions scope for Buddy objects.
 */
typedef NS_ENUM(NSInteger, BuddyPermissions){
    /** Accessible by App. */
    BuddyPermissionsApp,
    /** Accessible by owner. */
    BuddyPermissionsUser,
    /** Default (Accessible by Owner). */
    BuddyPermissionsDefault = BuddyPermissionsUser
};

typedef void (^BuddyObjectCallback)(id newBuddyObject, NSError *error);
typedef void (^BuddyCompletionCallback)(NSError *error);

@interface BuddyObject : NSObject

@property (nonatomic, readonly, strong) id<BPRestProvider> client;

@property (nonatomic, readonly, assign) BOOL isDirty;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSDate *lastModified;
@property (nonatomic, copy) NSString *defaultMetadata;
@property (nonatomic, assign) BuddyPermissions readPermissions;
@property (nonatomic, assign) BuddyPermissions writePermissions;
@property (nonatomic, copy) NSString *id;

- (instancetype) init __attribute__((unavailable("init not available")));
+ (instancetype) new __attribute__((unavailable("new not available")));

- (void)registerProperty:(SEL)property;

+ (NSString *)requestPath;

+ (void)createFromServerWithParameters:(NSDictionary *)parameters client:(id<BPRestProvider>)client callback:(BuddyObjectCallback)callback;
+ (void)queryFromServerWithId:(NSString *)identifier client:(id<BPRestProvider>)client callback:(BuddyObjectCallback)callback;
- (void)deleteMe:(BuddyCompletionCallback)callback;
- (void)deleteMe;
- (void)refresh;
- (void)refresh:(BuddyCompletionCallback)callback;
- (void)save:(BuddyCompletionCallback)callback;

- (void)setMetadataWithKey:(NSString *)key andString:(NSString *)value permissions:(BuddyPermissions)permissions callback:(BuddyCompletionCallback)callback;
- (void)setMetadataWithKey:(NSString *)key andInteger:(NSInteger)value permissions:(BuddyPermissions)permissions callback:(BuddyCompletionCallback)callback;

- (void)getMetadataWithKey:(NSString *)key callback:(BuddyObjectCallback)callback;
- (void)deleteMetadataWithKey:(NSString *)key callback:(BuddyCompletionCallback)callback;

@end
