//
//  BuddyCollection.h
//  BuddySDK
//
//  Created by Erik Kerber on 10/7/13.
//
//

#import <Foundation/Foundation.h>

typedef void (^BuddyCollectionCallback)(NSArray *buddyObjects);

@interface BuddyCollection : NSObject

@property (nonatomic) Class type;

- (void)getAll:(NSString *)resource complete:(BuddyCollectionCallback)complete;

@end
