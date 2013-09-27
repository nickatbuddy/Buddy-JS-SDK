//
//  BuddyLocation.h
//  BuddySDK
//
//  Created by Erik Kerber on 9/15/13.
//
//

#import <Foundation/Foundation.h>

@interface BuddyLocation : NSObject

///<summary>
/// Returns YES if the user has restricted location access for the current app.
///</summary>
-(BOOL) shouldRequestLocationTracking;

/// <summary>
/// TODO
/// </summary>
-(void) beginTrackingLocation:(void (^)())success andFailure:(void(^)(NSError *))failure;

/// <summary>
/// TODO
/// </summary>
-(void) endTrackingLocation;

@end