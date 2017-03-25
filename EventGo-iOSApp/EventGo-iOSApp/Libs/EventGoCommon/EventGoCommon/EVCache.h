//
//  EVCache.h
//  EventGoCommon
//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVCache : NSObject

+ (id)mem_objectForKey:(NSString *)key;
+ (void)mem_setObject:(id <NSCoding>)object forKey:(NSString *)key;


+ (id)disk_objectForKey:(NSString *)key;
+ (void)disk_setObject:(id <NSCoding>)object forKey:(NSString *)key;

@end
