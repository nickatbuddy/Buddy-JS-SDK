//
//  BuddyObject.m
//  BuddySDK
//
//  Created by Erik Kerber on 9/11/13.
//
//

#import "BuddyObject.h"
#import "BuddyObject+Private.h"
#import "JAGPropertyConverter.h"
#import "BPClient.h"

@interface BuddyObject()

@property (nonatomic, readwrite, assign) BOOL isDirty;
@property (nonatomic, strong) NSMutableArray *keyPaths;

@end

@implementation BuddyObject

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

-(instancetype)initBuddy
{
    self = [super init];
    if(self)
    {
        self.keyPaths = [NSMutableArray array];
        [self registerProperty:@selector(created)];
        [self registerProperty:@selector(lastModified)];
        [self registerProperty:@selector(defaultMetadata)];
        [self registerProperty:@selector(userId)];
        [self registerProperty:@selector(identifier)];
    }
    return self;
}

+(NSString *)requestPath
{
    [NSException raise:@"requestPathNotSpecified" format:@"Class did not specify requestPath"];
    return nil;
}

-(void)registerProperty:(SEL)property
{
    NSString *propertyName = NSStringFromSelector(property);
    
    [self.keyPaths addObject:propertyName];
    
    [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)dealloc
{
    for(NSString *keypath in self.keyPaths)
    {
        [self removeObserver:self forKeyPath:keypath];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(change)
        self.isDirty = YES;
}

#pragma mark CRUD

+(instancetype)create
{
    [[BPClient defaultClient] createObjectWithPath:[[self class] requestPath] parameters:nil complete:^(id json) {
        
    }];
    return nil;
}

+(void)createFromServerWithParameters:(NSDictionary *)parameters complete:(BuddyObjectCallback)callback
{
    [[BPClient defaultClient] createObjectWithPath:[[self class] requestPath] parameters:parameters complete:^(id json) {
        
        id newObject = [[[self class] alloc] initBuddy];

        [[[self class] converter] setPropertiesOf:newObject fromDictionary:json];
        callback(newObject);
    }];
}

-(void)deleteMe
{
    [[BPClient defaultClient] deleteObjectWithPath:[[self class] requestPath] parameters:nil complete:^(id json) {
        // TODO - anything?
    }];
}

-(void)refresh
{
    [[BPClient defaultClient] refreshObjectWithPath:[[self class] requestPath] parameters:nil complete:^(id json) {
        [[[self class] converter] setPropertiesOf:self fromDictionary:json];
    }];
}

-(void)update
{
    [[BPClient defaultClient] updateObjectWithPath:[[self class] requestPath] parameters:nil complete:^(id json) {
        [[[self class] converter] setPropertiesOf:self fromDictionary:json];
    }];
}

#pragma mark Abstract implementors
// "Abstract" methods.
-(NSDictionary *)buildUpdateDictionary
{
    // Abstract
    return nil;
}

-(void)updateObjectWithJSON:(NSString *)json
{
    // Abstract
}
@end
