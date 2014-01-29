//
//  Buddy.h
//  BuddySDK
//
//  Created by Erik Kerber on 11/15/13.
//
//

#import <Foundation/Foundation.h>

#import "BPClientDelegate.h"
#import "BuddyDevice.h"
#import "BPClient.h"
#import "BPCheckin.h"
#import "BPCheckinCollection.h"
#import "BPAlbumCollection.h"
#import "BPPhoto.h"
#import "BPUser.h"
#import "BPGameBoards.h"
#import "BPSounds.h"
#import "BPAppMetadata.h"
#import "BPPhotoCollection.h"
#import "BPBlobCollection.h"
#import "BPCoordinate.h"
#import "BPBlob.h"
#import "BPAlbum.h"

/**
 * TODO
 *
 * @since v2.0
 */
@interface Buddy : NSObject

/**
 The currently logged in user. Will be nil if no login session has occurred.
 */
+ (BPUser *)user;

#pragma message ("Implement BPDevice")
//+ (BuddyDevice *)device;

/**
 Accessor to create and query checkins
 */
+ (BPCheckinCollection *) checkins;

/**
 Accessor to create and query photos.
 */
+ (BPPhotoCollection *) photos;

/**
 Accessor to create and query data and files.
 */
+ (BPBlobCollection *) blobs;

    
/**
 Accessor to create and query albums.
 */
+ (BPAlbumCollection *) albums;


+ (BOOL) locationEnabled;

#pragma message("Implement location")
+ (void) setLocationEnabled:(BOOL)enabled;

/**
 *
 * Initialize the Buddy SDK with your App ID and App Key
 *
 * @param appID  Your application ID.
 *
 * @param appKey Your application key.
 *
 * @param callback A BuddyCompletionBlock that has an error, if any.
 */
+ (void)initClient:(NSString *)appID
            appKey:(NSString *)appKey
            callback:(BuddyCompletionCallback)callback;


/**
 *
 * Create a new Buddy User.
 *
 * @param username The new user's username
 *
 * @param password THe new user's password
 *
 * @param options The set of creation options for the user.
 */
+ (void)createUser:(NSString *)username password:(NSString *)password options:(NSDictionary *)options callback:(BuddyObjectCallback)callback;

/**
 *
 * Login a user using the provided username and password.
 */
+ (void)login:(NSString *)username password:(NSString *)password callback:(BuddyObjectCallback)callback;

/**
 *
 * Login the app using a social provider such as Facebook or Twitter.
 */
+ (void)socialLogin:(NSString *)provider providerId:(NSString *)providerId token:(NSString *)token success:(BuddyObjectCallback) callback;

/**
 *
 * Logout of the current app
 */
+ (void)logout:(BuddyCompletionCallback)callback;

@end