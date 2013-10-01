//
//  BuddyBase.m
//  BuddySDK
//
//  Created by Erik Kerber on 9/11/13.
//
//

#import "BuddyBase.h"

@interface BuddyBase()

@property (nonatomic, readwrite, assign) BOOL isDirty;

@end

@implementation BuddyBase

-(id)init
{
    self = [super init];
    if(self)
    {
        [self registerProperty:@"created"];
        [self registerProperty:@"lastModified"];
        [self registerProperty:@"tag"];
        [self registerProperty:@"userId"];

    }
    return self;
}

-(id)initWithExternalRepresentation:(NSDictionary *)json
{
    self = [super init];
    if(self)
    {
        [self registerProperty:@"created"];
        [self registerProperty:@"lastModified"];
        [self registerProperty:@"tag"];
        [self registerProperty:@"userId"];
        
    }
    return self;
}

-(void)registerProperty:(NSString *)propertyName
{
    [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(change)
        self.isDirty = YES;
}

@end
