//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "NSCollection+JSON.h"

@implementation NSDictionary (JSON)

- (int)intForKey:(id)key defaultValue:(int)defaultValue {
    @try {
        id value = [self objectForKey:key];
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            return defaultValue;
        }
        return [value intValue];
    }
    @catch (NSException *exception) {
        return defaultValue;
    }
    @finally {
    }
}

- (int)intValueForKey:(id)key defaultValue:(int)defaultValue {
    return [self intForKey:key defaultValue:defaultValue];
}

- (uint32_t)uint32ForKey:(id)key defaultValue:(uint32_t)defaultValue {
    @try {
        id value = [self objectForKey:key];
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            return defaultValue;
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [value unsignedIntValue];
        } else {
            return (uint32_t) [value intValue];
        }
    }
    @catch (NSException *exception) {
        return defaultValue;
    }
    @finally {
    }
}

- (uint64_t)uint64ForKey:(id)key defaultValue:(uint64_t)defaultValue {
    @try {
        id value = [self objectForKey:key];
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            return defaultValue;
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [value unsignedLongLongValue];
        } else {
            return (uint64_t) [value longLongValue];
        }
    }
    @catch (NSException *exception) {
        return defaultValue;
    }
    @finally {
    }
}

- (NSArray *)arrayForKey:(id)key defaultValue:(NSArray *)defaultValue {
    @try {
        id value = [self objectForKey:key];
        if (![value isKindOfClass:[NSArray class]]) {
            return defaultValue;
        } else {
            return value;
        }
    }
    @catch (NSException *exception) {
        return defaultValue;
    }
    @finally {
    }
}

- (NSDictionary *)dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue {
    @try {
        id value = [self objectForKey:key];
        if (![value isKindOfClass:[NSDictionary class]]) {
            return defaultValue;
        } else {
            return value;
        }
    }
    @catch (NSException *exception) {
        return defaultValue;
    }
    @finally {
    }
}

- (NSString *)stringForKey:(id)key defaultValue:(NSString *)defaultValue {
    @try {
        id value = [self objectForKey:key];
        if (value == nil || ![value isKindOfClass:[NSString class]]) {
            return defaultValue;
        }
        return value;
    }
    @catch (NSException *exception) {
        return defaultValue;
    }
    @finally {
    }
}

- (NSDate *)dateForKey:(id)key defaultValue:(NSDate *)defaultValue {
    @try {
        int value = [self intForKey:key defaultValue:0];
        return [NSDate dateWithTimeIntervalSince1970:value];
    }
    @catch (NSException *exception) {
        return defaultValue;
    }
    @finally {
    }
}

- (NSNumber *)numericForKey:(id)key defaultValue:(NSNumber *)defaultValue {
    @try {
        id value = [self objectForKey:key];
        if (value == nil || ![value isKindOfClass:[NSNumber class]]) {
            return defaultValue;
        }
        return value;
    }
    @catch (NSException *exception) {
        return defaultValue;
    }
    @finally {
    }
}

- (BOOL)boolForKey:(id)key defaultValue:(BOOL)defaultValue {
    @try {
        id value = [self objectForKey:key];
        if (value == nil) {
            return defaultValue;
        }
        if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
            return [value boolValue];
        }
        return defaultValue;
    }
    @catch (NSException *exception) {
        return defaultValue;
    }
    @finally {
    }
}

- (double)doubleForKey:(id)key defaultValue:(double)defaultValue {
    @try {
        id value = [self objectForKey:key];
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            return defaultValue;
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [value doubleValue];
        } else {
            return [value doubleValue];
        }
    }
    @catch (NSException *exception) {
        return defaultValue;
    }
    @finally {
    }
}


- (uint32_t)uint32ValueForKey:(id)key defaultValue:(uint32_t)defaultValue {
    return [self uint32ForKey:key defaultValue:defaultValue];
}

- (uint64_t)uint64ValueForKey:(id)key defaultValue:(uint64_t)defaultValue {
    return [self uint64ForKey:key defaultValue:defaultValue];
}

- (NSArray *)arrayValueForKey:(id)key defaultValue:(NSArray *)defaultValue {
    return [self arrayForKey:key defaultValue:defaultValue];
}

- (NSDictionary *)dictionaryValueForKey:(id)key defaultValue:(NSDictionary *)defaultValue {
    return [self dictionaryForKey:key defaultValue:defaultValue];
}

- (NSString *)stringValueForKey:(id)key defaultValue:(NSString *)defaultValue {
    return [self stringForKey:key defaultValue:defaultValue];
}

- (NSDate *)dateValueForKey:(id)key defaultValue:(NSDate *)defaultValue {
    return [self dateForKey:key defaultValue:defaultValue];
}

- (NSNumber *)numericValueForKey:(id)key defaultValue:(NSNumber *)defaultValue {
    return [self numericForKey:key defaultValue:defaultValue];
}

- (BOOL)boolValueForKey:(id)key defaultValue:(BOOL)defaultValue {
    return [self boolForKey:key defaultValue:defaultValue];
}

- (double)doubleValueForKey:(id)key defaultValue:(double)defaultValue {
    return [self doubleForKey:key defaultValue:defaultValue];
}

- (int)intForKey:(id)key {
    return [self intForKey:key defaultValue:0];
}

- (uint32_t)uint32ForKey:(id)key {
    return [self uint32ForKey:key defaultValue:0];
}

- (uint64_t)uint64ForKey:(id)key {
    return [self uint64ForKey:key defaultValue:0];
}

- (NSArray *)arrayForKey:(id)key {
    return [self arrayForKey:key defaultValue:nil];
}

- (NSDictionary *)dictionaryForKey:(id)key {
    return [self dictionaryForKey:key defaultValue:nil];
}

- (NSString *)stringForKey:(id)key {
    return [self stringForKey:key defaultValue:nil];
}

- (NSDate *)dateForKey:(id)key {
    return [self dateForKey:key defaultValue:nil];
}

- (NSNumber *)numericForKey:(id)key {
    return [self numericForKey:key defaultValue:nil];
}

- (BOOL)boolForKey:(id)key {
    return [self boolForKey:key defaultValue:NO];
}

- (double)doubleForKey:(id)key {
    return [self doubleForKey:key defaultValue:0.0];
}

- (int)intValueForKey:(id)key {
    return [self intForKey:key defaultValue:0];
}

- (uint32_t)uint32ValueForKey:(id)key {
    return [self uint32ValueForKey:key defaultValue:0];
}

- (uint64_t)uint64ValueForKey:(id)key {
    return [self uint64ValueForKey:key defaultValue:0];
}

- (NSArray *)arrayValueForKey:(id)key {
    return [self arrayValueForKey:key defaultValue:nil];
}

- (NSDictionary *)dictionaryValueForKey:(id)key {
    return [self dictionaryValueForKey:key defaultValue:nil];
}

- (NSString *)stringValueForKey:(id)key {
    return [self stringValueForKey:key defaultValue:nil];
}

- (NSDate *)dateValueForKey:(id)key {
    return [self dateValueForKey:key defaultValue:nil];
}

- (NSNumber *)numericValueForKey:(id)key {
    return [self numericValueForKey:key defaultValue:nil];
}

- (BOOL)boolValueForKey:(id)key {
    return [self boolValueForKey:key defaultValue:NO];
}

- (double)doubleValueForKey:(id)key {
    return [self doubleValueForKey:key defaultValue:0.0];
}
@end

@implementation NSMutableDictionary (NewSetObjectForKey)

- (void)setObjectCheckNil:(id)anObject forKey:(id <NSCopying>)aKey {
    if (anObject == nil || aKey == nil) {
        return;
    }
        [self setObject:anObject forKey:aKey];
}
@end

@implementation NSMutableArray (NewAddObject)

- (void)addObjectNotNil:(id)anObject {
    if (anObject == nil) {
        return;
    } else {
        [self addObject:anObject];
    }
}

- (void)addObjectNotExist:(id)anObject {
    if ([self containsObject:anObject]) {
        return;
    } else {
        [self addObjectNotNil:anObject];
    }
}

- (void)addObjectsFromArrayNotNil:(NSArray *)otherArray {
    if (otherArray == nil) {
        return;
    } else {
        [self addObjectsFromArray:otherArray];
    }
}
@end

@implementation NSMutableSet (NewAddObject)

- (void)addObjectNotNil:(id)anObject {
    if (anObject == nil) {
        return;
    } else {
        [self addObject:anObject];
    }
}

@end

@implementation NSArray (FeedJSON)
- (NSArray *)toJSON {
    if ([self count] == 0) {
        return [NSArray array];
    }

    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    for (NSObject *item in self) {
        if ([item respondsToSelector:@selector(toJSON)]) {
            [result addObject:[(id) item toJSON]];
        }
    }
    return result;
}
@end

@implementation NSString (Hyperlink)

- (NSString *)autoEnableHyperlink {
    if ([self length] == 0) {
        return self;
    }

    NSString *regExPattern = @"((?!(?!.*?<a)[^<]*<\\/a>)(?:(?:https?|ftp|file)://|www\\.|ftp\\.)[-A-Z0-9+&#/%=~_|$?!:,.]*[A-Z0-9+&#/%=~_|$])";
    NSString *replaceTemplate = @"<a href=\"$1\">$1</a>";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];

    NSRange inputRange = NSMakeRange(0, self.length);

    NSString *output = [regex stringByReplacingMatchesInString:self options:0 range:inputRange withTemplate:replaceTemplate];
    return output;
}

- (NSString *)autoEnableHyperlink2 {
    if ([self length] == 0) {
        return self;
    }

    NSRange range = [self rangeOfString:@"<a href"];
    if (range.length > 0) {
        return self;
    }

    return [self autoEnableHyperlink];
}

@end
@implementation NSData (JSON)

- (id)JSONValue {
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        json = nil;
    }
    return json;
}

@end
@implementation NSString (JSON)

- (id)JSONValue {
    if ([self length] == 0) {
        return nil;
    }
    NSData *correctedData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:correctedData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        json = nil;
    }
    return json;
}

- (NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

- (NSString *)encodeBase64UrlSafe {
    // Create NSData object
    NSData *nsdata = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    base64Encoded = [base64Encoded stringByReplacingOccurrencesOfString:@"/"
                                                             withString:@"_"];
    
    base64Encoded = [base64Encoded stringByReplacingOccurrencesOfString:@"+"
                                                             withString:@"-"];
    
    return base64Encoded;
}

- (NSString *)decodeBase64UrlSafe {
    NSString *result = [self stringByReplacingOccurrencesOfString:@"_"
                                                        withString:@"/"];
    
    result = [result stringByReplacingOccurrencesOfString:@"-"
                                               withString:@"+"];
    // Get NSData from NSString object in Base64
    NSData *nsdata = [[NSData alloc] initWithBase64EncodedString:result options:0];
    
    // Create NSData object
    NSString *returnValue = [[NSString alloc] initWithData:nsdata encoding:NSUTF8StringEncoding];
    return returnValue;
}
@end

@implementation NSObject (JSON)

- (NSString *)JSONRepresentation {
    return [self JSONRepresentation:false];
}

- (NSString *)JSONRepresentation:(BOOL)beautifulFormat {
    int option = beautifulFormat == true ? NSJSONWritingPrettyPrinted: 0;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:option error:nil];
    if (jsonData) {
        return [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

@end
