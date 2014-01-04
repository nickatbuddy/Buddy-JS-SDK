//
//  BPBlob.m
//  BuddySDK
//
//  Created by Erik Kerber on 1/4/14.
//
//

#import "BPBlob.h"
#import "BuddyObject+Private.h"
#import "Buddy.h"

@implementation BPBlob

+ (void)createWithData:(NSData *)data parameters:(NSDictionary *)parameters callback:(BuddyObjectCallback)callback
{
    NSDictionary *multipartParameters = @{@"data": data};
    
    [[[BPClient defaultClient] restService] MULTIPART_POST:[[self class] requestPath] parameters:parameters data:multipartParameters callback:^(id json) {

        BuddyObject *newObject = [[[self class] alloc] initBuddy];

#pragma messsage("TODO - Short term hack until response is always an object.")
        if([json isKindOfClass:[NSDictionary class]]){
            newObject.id = json[@"id"];
        }else{
            newObject.id = json;
        }
        
        if(!newObject.id){
#pragma messsage("TODO - Error")
            callback(newObject, nil);
            return;
        }
        
        [newObject refresh:^(NSError *error){
#pragma messsage("TODO - Error")
            callback(newObject, nil);
        }];
        
        callback(newObject, nil);
    }];
}

@end
