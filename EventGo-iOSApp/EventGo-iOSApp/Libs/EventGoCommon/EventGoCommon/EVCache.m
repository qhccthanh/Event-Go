//
//  EVCache.m
//  EventGoCommon
//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "EVCache.h"
#import "TMCache.h"

@implementation EVCache

+ (void)mem_setObject:(id <NSCoding>)object forKey:(NSString *)key {
    if (key.length == 0) {
        return;
    }
    if (object == nil) {
        [[TMMemoryCache sharedCache] removeObjectForKey:key];
        return;
    }
    [[TMMemoryCache sharedCache] setObject:object forKey:key];
}

+ (id)mem_objectForKey:(NSString *)key {
    id _return = nil;
    @try {
        _return = [[TMMemoryCache sharedCache] objectForKey:key];
    } @catch (NSException *exception) {
        [[TMMemoryCache sharedCache] removeObjectForKey:key];
    } @finally {
        
    }
    return _return;
}

+ (void)disk_setObject:(id <NSCoding>)object forKey:(NSString *)key {
    if (key.length == 0) {
        return;
    }
    if (object == nil) {
        [[TMDiskCache sharedCache] removeObjectForKey:key];
        return;
    }
    [[TMDiskCache sharedCache] setObject:object forKey:key];
}

+ (id)disk_objectForKey:(NSString *)key {
    id _return = nil;
    @try {
        _return = [[TMDiskCache sharedCache] objectForKey:key];
    } @catch (NSException *exception) {
        [[TMDiskCache sharedCache] removeObjectForKey:key];
    } @finally {
        
    }
    
    return _return;
}

@end
