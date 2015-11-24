//
//  UILabel+Additions.m
//  DamaiHD
//
//  Created by lixiang on 13-11-5.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "UILabel+Additions.h"
#include <CoreText/CTFramesetter.h>
#include <CoreText/CTLine.h>

@implementation UILabel (Additions)

- (void)adjustFontWithMaxSize:(CGSize)maxSize {
    CGSize stringSize;
    if (CGSizeEqualToSize(maxSize, CGSizeZero)) {
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
        stringSize = [self.text boundingRectWithSize:self.frame.size options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.font} context:NULL].size;
#else
        stringSize = [self.text sizeWithFont:self.font
                     constrainedToSize:self.frame.size
                         lineBreakMode:NSLineBreakByWordWrapping];
#endif
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
        stringSize = [self.text boundingRectWithSize:maxSize options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.font} context:NULL].size;
#else
        stringSize = [self.text sizeWithFont:self.font
                           constrainedToSize:maxSize
                               lineBreakMode:NSLineBreakByWordWrapping];
#endif
    }
    CGRect frame = self.frame;
    frame.size.width = stringSize.width;
    if (stringSize.height > frame.size.height) {
        frame.size.height = stringSize.height;
    }
    self.frame = frame;
    NSInteger lines = (int)stringSize.height / self.font.pointSize;
    self.numberOfLines = lines;
}

- (void)adjustFontAttributeWithMaxSize:(CGSize)maxSize {
    CGSize stringSize;
    stringSize.width = maxSize.width;
    if (self.text.length > 0) {
        stringSize.height = [self getAttributedStringHeightWithString:self.attributedText WidthValue:stringSize.width];
    } else {
        stringSize.height = 0;
    }
    
    CGRect frame = self.frame;
    frame.size.width = stringSize.width;
    if (stringSize.height > frame.size.height) {
        frame.size.height = stringSize.height;
    }
    self.frame = frame;

}

- (int)getAttributedStringHeightWithString:(NSAttributedString *)string  WidthValue:(int) width
{
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 10000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 10000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
    
}

- (void)withAttributesForString:(NSString *)string font:(UIFont *)font color:(UIColor *)color {
    NSRange range = [self.text rangeOfString:string];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedStr addAttribute:NSFontAttributeName
                          value:font
                          range:range];
    self.attributedText = attributedStr;
}

@end
