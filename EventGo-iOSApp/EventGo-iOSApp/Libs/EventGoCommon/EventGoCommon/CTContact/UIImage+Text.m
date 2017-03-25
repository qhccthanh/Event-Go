//
//  UIImage+Text.m
//  ZaloContact
//
//  Created by qhcthanh on 6/1/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import "UIImage+Text.h"

@implementation UIImage (Text)

+ (UIImage *)createImageFromText:(NSString *)text size:(CGSize)size {
    
    UIImage* image = [UIImage imageNamed:@"mask-circle-avatar-60"];
    image = [UIImage filledImageFrom:image withColor:[UIImage randomColor]];
    
    CGPoint point = CGPointMake(0,size.height * 0.7);
    image = [UIImage drawText:text inImage:image atPoint:point];
    
    return image;
}

/**
 *  Draw text in Image at position. Font is Arial 30 whiteColor
 *
 *  @param text  will draw in position
 *  @param image will be drawed text in position
 *  @param point position will draw text
 *
 *  @return new Image has drawed text in position
 */
+(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0.0f);
    
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    UIColor *textColor = [UIColor whiteColor];
    UIFont *font = [UIFont fontWithName:@"Roboto-Bold" size:55];
    
    [[UIColor whiteColor] set];
    if([text respondsToSelector:@selector(drawInRect:withAttributes:)])
    {
        //iOS 7 or above iOS 7
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = NSTextAlignmentCenter;
        NSDictionary *attr = @{NSFontAttributeName:font,
                              NSForegroundColorAttributeName: textColor,
                              NSParagraphStyleAttributeName:style};
        [text drawInRect:rect withAttributes:attr];
    }
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  fill color in image
 *
 *  @param source image will be filled color
 *  @param color  will fill in source image
 *
 *  @return new image has filled from source image
 */
+ (UIImage *)filledImageFrom:(UIImage *)source withColor:(UIColor *)color{
    
    // begin a new image context, to draw our colored image onto with the right scale
    UIGraphicsBeginImageContextWithOptions(source.size, NO, [UIScreen mainScreen].scale);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, source.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, source.size.width, source.size.height);
    CGContextDrawImage(context, rect, source.CGImage);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}

/**
 *  Random color
 *
 *  @return new color has random RGB
 */
+ (UIColor *)randomColor {
    
    srand48(arc4random());
    
    float red = 0.0;
    while (red < 0.1 || red > 0.84) {
        red = drand48();
    }
    
    float green = 0.0;
    while (green < 0.1 || green > 0.84) {
        green = drand48();
    }
    
    float blue = 0.0;
    while (blue < 0.1 || blue > 0.84) {
        blue = drand48();
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}
@end
