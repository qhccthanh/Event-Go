//
//  UIImage+Extention.m
//  MarQet
//
//  Created by Bon on 2/13/15.
//  Copyright (c) 2015 Bon. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

+ (UIImage *)imageFromColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage*)scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions( newSize, NO, [UIScreen mainScreen].scale );
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)scaledAspectToSize:(CGSize)newSize {
    
    CGRect scaledImageRect = CGRectZero;
    
    CGFloat aspectWidth = newSize.width / self.size.width;
    CGFloat aspectHeight = newSize.height / self.size.height;
    CGFloat aspectRatio = MIN ( aspectWidth, aspectHeight );
    
    scaledImageRect.size.width = self.size.width * aspectRatio;
    scaledImageRect.size.height = self.size.height * aspectRatio;
    scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0f;
    scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0f;
    
    UIGraphicsBeginImageContextWithOptions( newSize, NO, 0 );
    [self drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage*)resizeImageWithScale:(CGFloat)scale {
    
    CGSize newSize = CGSizeMake(self.size.width*scale, self.size.height*scale);
    return [self scaledToSize:newSize];
}

- (void)saveImageToDoucument:(NSString *)name {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]];
    
    NSData *imageData = UIImagePNGRepresentation(self);
    [imageData writeToFile:savedImagePath atomically:YES];
}

+ (UIImage *)filledImageFrom:(UIImage *)source withColor:(UIColor *)color {
    
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

+ (UIImage*) imageWithImage:(UIImage*) source
                      color:(UIColor *)color
                      alpha:(CGFloat) alpha {

    CGRect rect = CGRectMake(0, 0, source.size.width, source.size.height);

    CGSize imageSize = [source size];

    UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw original image
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, source.CGImage);
    
    // tint image (loosing alpha) - the luminosity of the original image is preserved
    CGContextSetBlendMode(context, kCGBlendModeColor);
    [color setFill];
    CGContextFillRect(context, rect);
    
    // mask by alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    CGContextDrawImage(context, rect, source.CGImage);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef cgRef = result.CGImage;
    return [[UIImage alloc] initWithCGImage:cgRef scale:source.scale orientation:UIImageOrientationDown];
    
    return result;
}

- (UIImage*) imageWithImage:(UIImage*) source rotatedByHue:(CGFloat) deltaHueRadians;
{
    // Create a Core Image version of the image.
    CIImage *sourceCore = [CIImage imageWithCGImage:[source CGImage]];
    
    // Apply a CIHueAdjust filter
    CIFilter *hueAdjust = [CIFilter filterWithName:@"CIHueAdjust"];
    [hueAdjust setDefaults];
    [hueAdjust setValue: sourceCore forKey: @"inputImage"];
    [hueAdjust setValue: [NSNumber numberWithFloat: deltaHueRadians] forKey: @"inputAngle"];
    CIImage *resultCore = [hueAdjust valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef resultRef = [context createCGImage:resultCore fromRect:[resultCore extent]];
    UIImage *result = [UIImage imageWithCGImage:resultRef];
    CGImageRelease(resultRef);
    
    return result;
    
}
@end
