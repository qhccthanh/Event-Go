//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)
- (int)intForKey:(id)key defaultValue:(int)defaultValue;
- (int)intForKey:(id)key;

- (uint32_t)uint32ForKey:(id)key defaultValue:(uint32_t)defaultValue;
- (uint32_t)uint32ForKey:(id)key;

- (uint64_t)uint64ForKey:(id)key defaultValue:(uint64_t)defaultValue;
- (uint64_t)uint64ForKey:(id)key;

- (NSArray *)arrayForKey:(id)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)arrayForKey:(id)key;

- (NSDictionary *)dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)dictionaryForKey:(id)key;

- (NSString *)stringForKey:(id)key defaultValue:(NSString *)defaultValue;
- (NSString *)stringForKey:(id)key;

- (NSDate *)dateForKey:(id)key defaultValue:(NSDate *)defaultValue;
- (NSDate *)dateForKey:(id)key;

- (NSNumber *)numericForKey:(id)key defaultValue:(NSNumber *)defaultValue;
- (NSNumber *)numericForKey:(id)key;

- (BOOL)boolForKey:(id)key defaultValue:(BOOL)defaultValue;
- (BOOL)boolForKey:(id)key;

- (double)doubleForKey:(id)key defaultValue:(double)defaultValue;
- (double)doubleForKey:(id)key;

@end

@interface NSMutableDictionary (NewSetObjectForKey)
- (void)setObjectCheckNil:(id)anObject forKey:(id <NSCopying>)aKey;
@end

@interface NSMutableArray (NewAddObject)
- (void)addObjectNotNil:(id)anObject;
- (void)addObjectsFromArrayNotNil:(NSArray *)otherArray;
- (void)addObjectNotExist:(id)anObject;
@end

@interface NSMutableSet (NewAddObject)
- (void)addObjectNotNil:(id)anObject;
@end

@interface NSArray (FeedJSON)
- (NSArray *)toJSON;
@end

@interface NSString (Hyperlink)
- (NSString *)autoEnableHyperlink;

- (NSString *)autoEnableHyperlink2;
@end

@interface NSString (JSON)
- (id)JSONValue;
- (NSString *)encodeBase64UrlSafe;
- (NSString *)decodeBase64UrlSafe;
@end

@interface NSObject (JSON)
- (NSString *)JSONRepresentation;
- (NSString *)JSONRepresentation:(BOOL)beautifulFormat;
@end

@interface NSData (JSON)
- (id)JSONValue;
@end

