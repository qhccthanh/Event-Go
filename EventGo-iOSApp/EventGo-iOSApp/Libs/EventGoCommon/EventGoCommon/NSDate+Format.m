//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)

- (NSString *)format:(NSString *)format {
    static NSDateFormatter *formatter;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }    
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}
@end
