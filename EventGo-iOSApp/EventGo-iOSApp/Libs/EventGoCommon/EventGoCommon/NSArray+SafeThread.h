//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeThread)
- (id)safeObjectAtIndex:(NSInteger)index;
- (id)itemAtIndexPath:(NSIndexPath *)indexpath;
- (NSArray *)sectionAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)sectionAtIndex:(NSInteger)index;
- (NSArray *)subArrayAtIndex:(NSInteger)index withTotalItem:(NSInteger)total;
- (NSInteger)subArrayCount:(NSInteger)total;
- (NSArray *)itemsAtIndex:(NSInteger)index withTotalItem:(NSInteger)total;
@end

@interface NSMutableArray (SafeRemove)
- (void)safeRemoveObjectAtIndex:(NSInteger)index;
@end
