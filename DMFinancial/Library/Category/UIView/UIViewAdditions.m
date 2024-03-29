//
//  UIViewAdditions.m
//  LaShouCommunity
//
//  Created by wanyueming on 09-11-27.
//  Copyright 2009 ___LASHOU-INC___. All rights reserved.
//

#import "UIViewAdditions.h"
#import <objc/runtime.h>

@implementation UIView (LSAdditional) 

UIInterfaceOrientation TTDeviceOrientation() {
	UIInterfaceOrientation orient = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
	if (!orient) {
		return UIInterfaceOrientationPortrait;
	} else {
		return orient;
	}
}

- (void)removeSubviews {
	while (self.subviews.count) {
		UIView* child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	self.frame = frame;
}

- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	self.frame = frame;
}

- (CGFloat)centerX {
	return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
	self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
	return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
	self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGFloat)screenX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
	}
	return x;
}

- (CGFloat)screenY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
	}
	return y;
}

- (CGFloat)screenViewX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			x -= scrollView.contentOffset.x;
		}
	}
	
	return x;
}

- (CGFloat)screenViewY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			y -= scrollView.contentOffset.y;
		}
	}
	return y;
}

- (CGRect)screenFrame {
	return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)offsetFromView:(UIView*)otherView {
	CGFloat x = 0, y = 0;
	for (UIView* view = self; view && view != otherView; view = view.superview) {
		x += view.left;
		y += view.top;
	}
	return CGPointMake(x, y);
}

- (CGFloat)orientationWidth {
	return UIDeviceOrientationIsLandscape(TTDeviceOrientation())
    ? self.height : self.width;
}

- (CGFloat)orientationHeight {
	return UIDeviceOrientationIsLandscape(TTDeviceOrientation())
    ? self.width : self.height;
}

- (CGPoint)centerOfFrame {
	CGRect rect = self.frame;
	return CGPointMake(rect.origin.x + rect.size.width / 2.0f,
					   rect.origin.y + rect.size.height / 2.0f);
}

- (CGPoint)centerOfBounds {
	CGRect rect = self.bounds;
	return CGPointMake(rect.origin.x + rect.size.width / 2.0f,
					   rect.origin.y + rect.size.height / 2.0f);
}

- (NSObject *)attachment {
    return objc_getAssociatedObject(self, @"kViewAttachment");
}

- (void)setAttachment:(NSObject *)attachment {
    objc_setAssociatedObject(self, @"kViewAttachment",nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @"kViewAttachment",attachment, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius color:(UIColor*)color{
	CGContextRef context = UIGraphicsGetCurrentContext();
	[color set];
	
	CGRect rrect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
	
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFill);
}

- (void)drawShadowLayer:(CGSize)offset withRadius:(CGFloat)radius color:(UIColor*)color {
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = offset;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
}

- (void)drawShadowLayerInRect:(CGRect)rect downward:(BOOL)downward {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:1.0],nil];
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[[UIColor blackColor] colorWithAlphaComponent:0.15f].CGColor,nil];
    if (downward) {
        gradientLayer.startPoint = CGPointMake(0.5, 1);
        gradientLayer.endPoint = CGPointMake(0.5, 0);
    } else {
        gradientLayer.startPoint = CGPointMake(0.5, 0);
        gradientLayer.endPoint = CGPointMake(0.5, 1);
    }
    self.layer.masksToBounds = NO;
    self.clipsToBounds = NO;
    [self.layer addSublayer:gradientLayer];
}

- (void)drawDashLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint color:(UIColor *)color lineWidth:(float)lineWidth lineDashPattern:(NSArray *)lineDashPattern{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    shapeLayer.path = path;
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:lineWidth];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:lineDashPattern];
    self.layer.masksToBounds = NO;
    [self.layer addSublayer:shapeLayer];
    CGPathRelease(path);
}

- (void)drawDashLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint color:(UIColor *)color {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    shapeLayer.path = path;
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:0.5f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:2],
      [NSNumber numberWithInt:2],
      nil]];
    self.layer.masksToBounds = NO;
    [self.layer addSublayer:shapeLayer];
    CGPathRelease(path);
}

- (void)drawSolidLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint color:(UIColor *)color thickness:(CGFloat)thickness{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    shapeLayer.path = path;
    [shapeLayer setStrokeColor:color.CGColor];
    [shapeLayer setLineWidth:thickness];
    self.layer.masksToBounds = NO;
    [self.layer addSublayer:shapeLayer];
    CGPathRelease(path);
}

//划清晰直线
-(CAShapeLayer *)drawSolidLineWithFrame:(CGRect)rec
{
    return [self drawSolidLineWithFrame:rec color:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1]];
}

//划清晰直线
-(CAShapeLayer *)drawSolidLineWithFrame:(CGRect)rec color:(UIColor *)color
{
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.backgroundColor = color.CGColor;
    lineLayer.frame = rec;
    self.layer.masksToBounds = NO;
    [self.layer addSublayer:lineLayer];
    return lineLayer;
}

- (UIImage *)captureFrame:(CGRect)r {
    CGFloat scale = 2.0;
    UIGraphicsBeginImageContextWithOptions(r.size, YES, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImageJPEGRepresentation(theImage, 1);
    theImage  = [UIImage imageWithData:data];
    return  theImage;
}

@end
