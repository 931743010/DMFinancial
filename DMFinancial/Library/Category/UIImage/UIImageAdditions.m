#import "UIImageAdditions.h"

#define DegreesToRadians(x) (x*M_PI)/180

@interface UIImage ()
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;
@end

@implementation UIImage (LSAdditional)

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
  CGContextBeginPath(context);
  CGContextSaveGState(context);

  if (radius == 0) {
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddRect(context, rect);
  } else {
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, radius, radius);
    float fw = CGRectGetWidth(rect) / radius;
    float fh = CGRectGetHeight(rect) / radius;
    
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
  }

  CGContextClosePath(context);
  CGContextRestoreGState(context);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

+ (UIImage*)imageWithContentsOfURL:(NSURL*)url {
	NSError* error = nil;
	NSData* data = [NSData dataWithContentsOfURL:url options:0 error:&error];
	if(error || !data) {
		return nil;
	} else {
		return [UIImage imageWithData:data];
	}
}

- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate {
  CGFloat destW = width;
  CGFloat destH = height;
  CGFloat sourceW = width;
  CGFloat sourceH = height;
  if (rotate) {
    if (self.imageOrientation == UIImageOrientationRight
        || self.imageOrientation == UIImageOrientationLeft) {
      sourceW = height;
      sourceH = width;
    }
  }
  
  CGImageRef imageRef = self.CGImage;
  CGContextRef bitmap = CGBitmapContextCreate(NULL, destW, destH,
    CGImageGetBitsPerComponent(imageRef), 4*destW, CGImageGetColorSpace(imageRef),
    CGImageGetBitmapInfo(imageRef));

  if (rotate) {
    if (self.imageOrientation == UIImageOrientationDown) {
      CGContextTranslateCTM(bitmap, sourceW, sourceH);
      CGContextRotateCTM(bitmap, 180 * (M_PI/180));
    } else if (self.imageOrientation == UIImageOrientationLeft) {
      CGContextTranslateCTM(bitmap, sourceH, 0);
      CGContextRotateCTM(bitmap, 90 * (M_PI/180));
    } else if (self.imageOrientation == UIImageOrientationRight) {
      CGContextTranslateCTM(bitmap, 0, sourceW);
      CGContextRotateCTM(bitmap, -90 * (M_PI/180));
    }
  }

  CGContextDrawImage(bitmap, CGRectMake(0,0,sourceW,sourceH), imageRef);

  CGImageRef ref = CGBitmapContextCreateImage(bitmap);
  UIImage* result = [UIImage imageWithCGImage:ref];
  CGContextRelease(bitmap);
  CGImageRelease(ref);

  return result;
}

- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode {
  BOOL clip = NO;
  CGRect originalRect = rect;
  if (self.size.width != rect.size.width || self.size.height != rect.size.height) {
    if (contentMode == UIViewContentModeLeft) {
      rect = CGRectMake(rect.origin.x,
                        rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeRight) {
      rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                        rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeTop) {
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                        rect.origin.y,
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeBottom) {
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                        rect.origin.y + floor(rect.size.height - self.size.height),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeCenter) {
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                        rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                        self.size.width, self.size.height);
    } else if (contentMode == UIViewContentModeBottomLeft) {
      rect = CGRectMake(rect.origin.x,
                        rect.origin.y + floor(rect.size.height - self.size.height),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeBottomRight) {
      rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                        rect.origin.y + (rect.size.height - self.size.height),
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeTopLeft) {
      rect = CGRectMake(rect.origin.x,
                        rect.origin.y,
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeTopRight) {
      rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                        rect.origin.y,
                        self.size.width, self.size.height);
      clip = YES;
    } else if (contentMode == UIViewContentModeScaleAspectFill) {
      CGSize imageSize = self.size;
      if (imageSize.height < imageSize.width) {
        imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
        imageSize.height = rect.size.height;
      } else {
        imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
        imageSize.width = rect.size.width;
      }
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                        rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                        imageSize.width, imageSize.height);
    } else if (contentMode == UIViewContentModeScaleAspectFit) {
      CGSize imageSize = self.size;
      if (imageSize.height < imageSize.width) {
        imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
        imageSize.width = rect.size.width;
      } else {
        imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
        imageSize.height = rect.size.height;
      }
      rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                        rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                        imageSize.width, imageSize.height);
    }
  }
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  if (clip) {
    CGContextSaveGState(context);
    CGContextAddRect(context, originalRect);
    CGContextClip(context);
  }

  [self drawInRect:rect];

  if (clip) {
    CGContextRestoreGState(context);
  }
}

- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius {
  [self drawInRect:rect radius:radius contentMode:UIViewContentModeScaleToFill];
}

- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  if (radius) {
    [self addRoundedRectToPath:context rect:rect radius:radius];
    CGContextClip(context);
  }
  
  [self drawInRect:rect contentMode:contentMode];
  
  CGContextRestoreGState(context);
}

- (UIImage*)scaleToCenterSize:(CGSize)size {
    CGFloat scale = 0;
    if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
        scale = [[UIScreen mainScreen] scale];
    } else {
        scale = 2.0;
    }
	UIGraphicsBeginImageContextWithOptions(size, NO, scale);

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, 0.0, size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
    int top = 0;
    int left = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        left = (size.width - self.size.width)/2;
        top = (size.height - self.size.height)/2;
        CGContextDrawImage(context, CGRectMake(left, top, (self.size.width), (self.size.height)), self.CGImage);
    } else {
        left = (size.width - (self.size.width/2))/2;
        top = (size.height - (self.size.height/2))/2;
        CGContextDrawImage(context, CGRectMake(left, top, (self.size.width/2), (self.size.height/2)), self.CGImage);
    }
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return scaledImage;
}

- (UIImage*)scaleToSize:(CGSize)size {
	UIGraphicsBeginImageContext(size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, 0.0, size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return scaledImage;
}

- (UIImage*)scaleAndCropToSize:(CGSize)size {
	if(size.height > size.width) {
		if(self.size.height > self.size.width) {
			if((self.size.width  / self.size.height) >= (size.width / size.height)) {
				return [self scaleHeightAndCropWidthToSize:size];
			} else {
				return [self scaleWidthAndCropHeightToSize:size];
			}
		} else {
			return [self scaleHeightAndCropWidthToSize:size];
		}    
	} else {
		if(self.size.width > self.size.height) {
			if((self.size.height / self.size.width) >= (size.height / size.width)) {
				return [self scaleWidthAndCropHeightToSize:size];
			} else {
				return [self scaleHeightAndCropWidthToSize:size];
			}
		} else {
			return [self scaleWidthAndCropHeightToSize:size];
		}    
	}
}

- (UIImage*)scaleHeightAndCropWidthToSize:(CGSize)size {
	float newWidth = (self.size.width * size.height) / self.size.height;
	return [self scaleToSize:size withOffset:CGPointMake((newWidth - size.width) / 2, 0.0f)];
}

- (UIImage*)scaleWidthAndCropHeightToSize:(CGSize)size {
	float newHeight = (self.size.height * size.width) / self.size.width;
	return [self scaleToSize:size withOffset:CGPointMake(0, (newHeight - size.height) / 2)];
}

- (UIImage*)scaleToSize:(CGSize)size withOffset:(CGPoint)offset {
	UIImage* scaledImage = [self scaleToSize:CGSizeMake(size.width + (offset.x * -2), size.height + (offset.y * -2))];
	
	UIGraphicsBeginImageContext(size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, 0.0, size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CGRect croppedRect;
	croppedRect.size = size;
	croppedRect.origin = CGPointZero;
	
	CGContextClipToRect(context, croppedRect);
	
	CGRect drawRect;
	drawRect.origin = offset;
	drawRect.size = scaledImage.size;
	
	CGContextDrawImage(context, drawRect, scaledImage.CGImage);
	
	UIImage* croppedImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return croppedImage;
}

// Returns true if the image has an alpha layer
- (BOOL)hasAlpha {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

// Returns a copy of the given image, adding an alpha channel if it doesn't already have one
- (UIImage *)imageWithAlpha {
    if ([self hasAlpha]) {
        return self;
    }
    
    CGImageRef imageRef = self.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL,
                                                          width,
                                                          height,
                                                          8,
                                                          0,
                                                          CGImageGetColorSpace(imageRef),
                                                          kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    // Draw the image into the context and retrieve the new image, which will now have an alpha layer
    CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(offscreenContext);
    UIImage *imageWithAlpha = [UIImage imageWithCGImage:imageRefWithAlpha];
    
    // Clean up
    CGContextRelease(offscreenContext);
    CGImageRelease(imageRefWithAlpha);
    
    return imageWithAlpha;
}

// Returns a copy of the image with a transparent border of the given size added around its edges.
// If the image has no alpha layer, one will be added to it.
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    
    CGRect newRect = CGRectMake(0, 0, image.size.width + borderSize * 2, image.size.height + borderSize * 2);
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(self.CGImage),
                                                0,
                                                CGImageGetColorSpace(self.CGImage),
                                                CGImageGetBitmapInfo(self.CGImage));
    
    // Draw the image in the center of the context, leaving a gap around the edges
    CGRect imageLocation = CGRectMake(borderSize, borderSize, image.size.width, image.size.height);
    CGContextDrawImage(bitmap, imageLocation, self.CGImage);
    CGImageRef borderImageRef = CGBitmapContextCreateImage(bitmap);
    
    // Create a mask to make the border transparent, and combine it with the image
    CGImageRef maskImageRef = [self newBorderMask:borderSize size:newRect.size];
    CGImageRef transparentBorderImageRef = CGImageCreateWithMask(borderImageRef, maskImageRef);
    UIImage *transparentBorderImage = [UIImage imageWithCGImage:transparentBorderImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(borderImageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(transparentBorderImageRef);
    
    return transparentBorderImage;
}

#pragma mark -
#pragma mark Private helper methods

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

// Creates a mask that makes the outer edges transparent and everything else opaque
// The size must include the entire mask (opaque part + transparent border)
// The caller is responsible for releasing the returned reference by calling CGImageRelease
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Build a context that's the same dimensions as the new size
    CGContextRef maskContext = CGBitmapContextCreate(NULL,
                                                     size.width,
                                                     size.height,
                                                     8, // 8-bit grayscale
                                                     0,
                                                     colorSpace,
                                                     kCGBitmapByteOrderDefault | kCGImageAlphaNone);
    
    // Start with a mask that's entirely transparent
    CGContextSetFillColorWithColor(maskContext, [UIColor blackColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(0, 0, size.width, size.height));
    
    // Make the inner part (within the border) opaque
    CGContextSetFillColorWithColor(maskContext, [UIColor whiteColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(borderSize, borderSize, size.width - borderSize * 2, size.height - borderSize * 2));
    
    // Get an image of the context
    CGImageRef maskImageRef = CGBitmapContextCreateImage(maskContext);
    
    // Clean up
    CGContextRelease(maskContext);
    CGColorSpaceRelease(colorSpace);
    
    return maskImageRef;
}

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage *)croppedImage:(CGRect)bounds {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

- (UIImage *)croppedImage:(CGRect)bounds withScale:(CGFloat)scale {
    if (scale == 1) {
        return [self croppedImage:bounds];
    } else {
        return [self croppedImage:CGRectMake(0, 0, CGRectGetWidth(bounds)*scale, CGRectGetHeight(bounds)*scale)];
    }
}

// Returns a copy of this image that is squared to the thumbnail size.
// If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality {
    UIImage *resizedImage = [self resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                                       bounds:CGSizeMake(thumbnailSize, thumbnailSize)
                                         interpolationQuality:quality];
    
    // Crop out any part of the image that's larger than the thumbnail size
    // The cropped rect must be centered on the resized image
    // Round the origin points so that the size isn't altered when CGRectIntegral is later invoked
    CGRect cropRect = CGRectMake(round((resizedImage.size.width - thumbnailSize) / 2),
                                 round((resizedImage.size.height - thumbnailSize) / 2),
                                 thumbnailSize,
                                 thumbnailSize);
    UIImage *croppedImage = [resizedImage croppedImage:cropRect];
    
    UIImage *transparentBorderImage = borderSize ? [croppedImage transparentBorderImage:borderSize] : croppedImage;
	
    return [transparentBorderImage roundedCornerImage:cornerRadius borderSize:borderSize];
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
            
        default:
            drawTransposed = NO;
    }
    
    return [self resizedImage:newSize
                    transform:[self transformForOrientation:newSize]
               drawTransposed:drawTransposed
         interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    NSInteger mode = contentMode;
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %ld", (long)mode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self resizedImage:newSize interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch ((Byte)self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch ((Byte)self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    return transform;
}

// Creates a copy of this image with rounded corners
// If borderSize is non-zero, a transparent border of the given size will also be added
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    
    // Build a context that's the same dimensions as the new size
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));
	
    // Create a clipping path with rounded corners
    CGContextBeginPath(context);
    [self addRoundedRectToPath:CGRectMake(borderSize, borderSize, image.size.width - borderSize * 2, image.size.height - borderSize * 2)
                       context:context
                     ovalWidth:cornerSize
                    ovalHeight:cornerSize];
    CGContextClosePath(context);
    CGContextClip(context);
	
    // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    // Create a CGImage from the context
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // Create a UIImage from the CGImage
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
    
    return roundedImage;
}

#pragma mark -
#pragma mark Private helper methods

// Adds a rectangular path to the given context and rounds its corners by the given extents
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight {
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
    CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

-(UIImage *)resizableImageExtendWithCapInsets:(UIEdgeInsets)capInsets{
    UIImage *newImage = nil;
    if ([self respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
        newImage = [self resizableImageWithCapInsets:capInsets];
    } else {
        newImage = [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
    return newImage;
}

- (UIImage *)rotateByDegrees:(CGFloat)degrees {
    CGSize imageSize = self.size;
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
//    CGContextTranslateCTM(bitmap, 0, imageSize.height);
//    CGContextScaleCTM(bitmap, 1.0, -1.0);
//    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
//    CGContextDrawImage(bitmap, CGRectMake(0, 0, imageSize.width, imageSize.height), [self CGImage]);

    //Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, imageSize.width/2, imageSize.height/2);
    //Rotate the image context
    CGContextRotateCTM(bitmap, (degrees * M_PI / 180));
    //Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-imageSize.width/2, -imageSize.height/2, imageSize.width, imageSize.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)getViewImage:(UIView *)theView atFrame:(CGRect)r
{
    NSLog(@"%f",[[UIScreen mainScreen] scale]);
    UIGraphicsBeginImageContextWithOptions(r.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImageJPEGRepresentation(theImage, 1);
    theImage  = [UIImage imageWithData:data];
    return  theImage;
}
+ (UIImage *)_cropImage:(UIImage *)image withRect:(CGRect)cropRect
{
    cropRect = CGRectMake(cropRect.origin.x * 2.0,
                          cropRect.origin.y * 2.0,
                          cropRect.size.width * 2.0,
                          cropRect.size.height * 2.0);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return croppedImage;
}

/**
 * 图片拼接，将参数数组中的图片按顺序接成一张图片 
 * direction 0纵向  1横向
 */
+(UIImage *)jointWithImages:(NSArray *)images direction:(int)direction
{
    CGSize sz = CGSizeZero;
    for (UIImage *image in images)
    {
        if (direction)
        {
            sz.width += image.size.width;
            if (image.size.height > sz.height)
            {
                sz.height = image.size.height;
            }
        }
        else
        {
            sz.height += image.size.height;
            if (image.size.width > sz.width)
            {
                sz.width = image.size.width;
            }
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width, sz.height), NO, 1);
    
    CGFloat height = 0.0;
    CGFloat width = 0.0;
    for (UIImage *image in images)
    {
        [image drawAtPoint:CGPointMake(width, height)];
        if (direction)
        {
            width += image.size.width;
        }
        else
        {
            height += image.size.height;
        }
    }
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage *)imageWithSize:(CGSize)imageSize color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+(UIImage *)imageWithBaseImage:(UIImage *)baseImage superposedImage:(UIImage *)superposedImage {
    //这种情况下我们需要最终合成的图片大小是和person一致的，让我们获得我们需要的最终图片的大小：
    CGSize finalSize = [baseImage size];
    //然后再搞到hat的大小，可能比person要小得多：
    
    CGSize hatSize = [superposedImage size];
    // 现在我们需要创建一个graphics context来画我们的东西：
    
    UIGraphicsBeginImageContext(finalSize);
    // graphics context就像一张能让我们画上任何东西的纸。我们要做的第一件事就是把person画上去：
    
    [baseImage drawInRect:CGRectMake(0,0,finalSize.width,finalSize.height)];
    // 然后再把hat画在合适的位置：
    
    [superposedImage drawInRect:CGRectMake(0,0,hatSize.width,hatSize.height)];
    //接着通过下面的语句创建新的UIImage:
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 最后，我们必须得清理并关闭这个我们再也不需要的context：
    
    
    UIGraphicsEndImageContext();
    return newImage;
    
}
+ (UIImage *)imageWithBaseImage:(UIImage *)image roundedCornersSize:(float)cornerRadius imageSize:(CGSize)imageSize{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    //[UIScreen mainScreen].scale
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageSize.width, imageSize.height) cornerRadius:cornerRadius] addClip];
    // Draw your image
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];          // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
