//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "NSArray+SafeThread.h"
#import <UIKit/UIKit.h>


@implementation NSArray (SafeThread)
- (id)safeObjectAtIndex:(NSInteger)index {
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexpath {
    NSArray *section = [self safeObjectAtIndex:indexpath.section];
    if ([section isKindOfClass:[NSArray class]]) {
        return [section safeObjectAtIndex:indexpath.row];
    }
    return [self safeObjectAtIndex:indexpath.row];
}

- (NSArray *)sectionAtIndexPath:(NSIndexPath *)indexPath {
    return [self sectionAtIndex:indexPath.section];
}
- (NSArray *)sectionAtIndex:(NSInteger)index {
    NSArray *secitons = [self safeObjectAtIndex:index];
    if ([secitons isKindOfClass:[NSArray class]]) {
        return secitons;
    }
    return nil;
}

- (NSArray *)subArrayAtIndex:(NSInteger)index withTotalItem:(NSInteger)total {
    NSInteger startIndex = index *total;
    return [self itemsAtIndex:startIndex withTotalItem:total];
}

- (NSArray *)itemsAtIndex:(NSInteger)startIndex withTotalItem:(NSInteger)total {
    NSInteger length = (self.count - startIndex) > total ? total : self.count - startIndex;
    if (startIndex  + length > self.count) {
      //  DDLogInfo(@"startIndex :%ld",(long)startIndex);
      //  DDLogInfo(@"length :%ld",(long)length);
      //  DDLogInfo(@"count :%ld",(long)self.count);
        return nil;
    }
    NSRange range = NSMakeRange(startIndex, length);
    return [self subarrayWithRange:range];


}

- (NSInteger)subArrayCount:(NSInteger)total {
    return ceil((float)self.count/total);
}
@end

@implementation NSMutableArray (SafeRemove)
- (void)safeRemoveObjectAtIndex:(NSInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}
@end
