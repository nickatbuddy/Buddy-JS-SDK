//
//  BPCheckinCollection.h
//  BuddySDK
//
//  Created by Erik Kerber on 11/15/13.
//
//

#import "BuddyCollection.h"
#import "BPCheckin.h"
#import "BuddyLocation.h"

@interface BPCheckinCollection : BuddyCollection

// Hmm, I don't like these parameter-heavy methods.
-(void)addWithComment:(NSString *)comment
          description:(NSString *)description
             location:(struct BPCoordinate)coordinate
      defaultMetadata:(NSString *)defaultMetadata
      readPermissions:(BuddyPermissions)readPermissions
     writePermissions:(BuddyPermissions)writePermissions;


@end