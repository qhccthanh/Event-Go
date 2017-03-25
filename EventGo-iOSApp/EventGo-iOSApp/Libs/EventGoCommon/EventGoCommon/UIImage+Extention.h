//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)

+ (UIImage *)imageFromColor:(UIColor *)color;

- (UIImage*)scaledToSize:(CGSize)newSize;

- (UIImage*)resizeImageWithScale:(CGFloat)scale;

- (void)saveImageToDoucument:(NSString *)name;

+ (UIImage *)filledImageFrom:(UIImage *)source withColor:(UIColor *)color;

+ (UIImage*) imageWithImage:(UIImage*) source
                      color:(UIColor *)color
                      alpha:(CGFloat) alpha;

- (UIImage *)scaledAspectToSize:(CGSize)newSize;
@end
