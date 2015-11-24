//
//  NSStringHelper.m
//  CocoaHelpers
//
//  Created by Shaun Harrison on 10/14/08.
//  Copyright (c) 2008-2009 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSStringHelper.h"
#import <CommonCrypto/CommonDigest.h>

int const GGCharacterIsNotADigit = 10;

@implementation NSString (Helper)

+ (NSString*)stringWithFormattedUnsignedInteger:(NSUInteger)integer {
	NSNumber* number = [NSNumber numberWithUnsignedInteger:integer];
	NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSString* formattedString = [formatter stringFromNumber:number];
	return formattedString;
}

- (BOOL)containsString:(NSString*)string {
	return [self containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)containsString:(NSString*)string options:(NSStringCompareOptions)options {
	return [self rangeOfString:string options:options].location == NSNotFound ? NO : YES;
}

#pragma mark -
#pragma mark Long conversions

- (long)longValue {
	return (long)[self longLongValue];
}

- (long long)longLongValue {
	NSScanner* scanner = [NSScanner scannerWithString:self];
	long long valueToGet;
	if([scanner scanLongLong:&valueToGet] == YES) {
		return valueToGet;
	} else {
		return 0;
	}
}

/*
 * Contact info@enormego.com if you're the author and we'll update this comment to reflect credit
 */

- (unsigned)digitValue:(unichar)c {
	
	if ((c>47)&&(c<58)) {
        return (c-48);
	}
	
	return GGCharacterIsNotADigit;
}

- (unsigned long long)unsignedLongLongValue {
	NSUInteger n = [self length];
	unsigned long long v,a;
	unsigned small_a, j;
	
	v=0;
	for (j=0;j<n;j++) {
		unichar c=[self characterAtIndex:j];
		small_a=[self digitValue:c];
		if (small_a==GGCharacterIsNotADigit) continue;
		a=(unsigned long long)small_a;
		v=(10*v)+a;
	}
	
	return v;
	
}

#pragma mark -
#pragma mark Hashes
// TODO: Add other methods, specifically SHA1

/*
 * Contact info@enormego.com if you're the author and we'll update this comment to reflect credit
 */

- (NSString*)md5 {
	const char* string = [self UTF8String];
	unsigned char result[16];
	CC_MD5(string, strlen(string), result);
	NSString* hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
												result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], 
												result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];

	return [hash lowercaseString];
}


- (BOOL)isBelongToArray:(NSArray *)array {
    if (!self || [self length]==0) {
        return NO;
    }
    if ([array  count]>0) {
        for (id tmpData in array) {
            if (tmpData && [tmpData isKindOfClass:[NSString class]]) {
                if ([tmpData isEqualToString:self]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (NSMutableAttributedString *)attributedTextWithLineSpacing:(CGFloat)lineSpacing font:(UIFont *)font{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    [attributedString addAttribute:(NSString *)NSFontAttributeName
                   value:font
                   range:NSMakeRange(0, [self length])];

    return attributedString;
}

- (NSString *)replaceStringWithOriginalString:(NSString *)originalString newString:(NSString *)newString originalStringLength:(int)originalStringLength onlyReplaceFirstString:(BOOL)onlyReplaceFirstString{
    
    if ([self length] > 0 && [originalString length] > 0 && [newString length] > 0) {
        NSMutableString * string = [NSMutableString stringWithString:self];
        for (int i = 0; i<[string length]; i++) {
            NSString *tmpString = [string substringWithRange:NSMakeRange(i, originalStringLength)];
            if ([tmpString length] > 0 &&[originalString isEqualToString:tmpString]) {
                [string replaceOccurrencesOfString:tmpString withString:newString options:NSLiteralSearch range:NSMakeRange(i, originalStringLength)];
                if (onlyReplaceFirstString) {
                    break;
                }
            }
        }
        return string;
    } else {
        return self;
    }
}

- (NSString *)insertString:(NSString *)aString frontOfString:(NSString *)frontOfString frontOfStringLength:(int)frontOfStringLength onlyInsertFirstOne:(BOOL)onlyInsertFirstOne{
    
    if ([self length] > 0 && [frontOfString length] > 0 && [aString length] > 0) {
        NSMutableString * string = [NSMutableString stringWithString:self];
        for (int i = 0; i<[string length]; i++) {
            NSString *tmpString = [string substringWithRange:NSMakeRange(i, frontOfStringLength)];
            if ([tmpString length] > 0 &&[frontOfString isEqualToString:tmpString]) {
                [string insertString:aString atIndex:i];

                if (onlyInsertFirstOne) {
                    break;
                }
            }
        }
        return string;
    } else {
        return self;
    }

}

+ (NSString *)getCountdownStringWithSeconds:(long int)seconds {
    NSString *day = [NSString stringWithFormat:@"%ld",seconds/(3600*24)];
    NSString *hour = [NSString stringWithFormat:@"%ld",(seconds%(3600*24))/3600];
    NSString *min = [NSString stringWithFormat:@"%ld",(seconds%3600)/60];
    NSString *sec = [NSString stringWithFormat:@"%ld",(seconds%3600)%60];

    if ([day intValue]<10) {
        day = [NSString stringWithFormat:@"0%@",day];
    }
    if ([hour intValue]<10) {
        hour = [NSString stringWithFormat:@"0%@",hour];
    }
    if ([min intValue]<10) {
        min = [NSString stringWithFormat:@"0%@",min];
    }
    if ([sec intValue]<10) {
        sec = [NSString stringWithFormat:@"0%@",sec];
    }

    NSString *string = [[NSString alloc] init];
        if (seconds < 60)
        {//秒
            string = [NSString stringWithFormat:@"00小时00分%@秒",sec];
        }
        else if (seconds < 60 * 60)
        {  //分
            string = [NSString stringWithFormat:@"00小时%@分%@秒",min,sec];
        }
        else if (seconds < 60 * 60 * 24)
        {  //时
            string = [NSString stringWithFormat:@"%@小时%@分%@秒",hour,min,sec];
        }
        else
        {//天
            string = [NSString stringWithFormat:@"%@天%@小时%@分%@秒",day,hour,min,sec];
        }
    
    return string;
}

+ (NSMutableAttributedString *)replaceNumberColorInString:(NSString *)string originalColor:(UIColor *)originalColor newColor:(UIColor *)newColor originalFont:(UIFont *)originalFont newFont:(UIFont *)newFont onlyReplaceFirstNumber:(BOOL)onlyReplaceFirstNumber{
    if(!string || [string isEqualToString:@""]) {
        return nil;
    }
    NSMutableAttributedString *regStr = [[NSMutableAttributedString alloc]initWithString:string];
    BOOL isStartReplaceNumber = NO;//遇到字符串中第一个数字
    BOOL isEndReplaceNumber = NO;//完成替换

    for (int i = 0; i<[string length]; i++) {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        
        if(str.length > 0 && ![str isEqualToString:@"."]) {//不是数字
            if (isStartReplaceNumber && onlyReplaceFirstNumber) {//开始替换数字后遇到的第一个非数字的字符
                isEndReplaceNumber = YES;
            }
            [regStr addAttribute:NSForegroundColorAttributeName
                           value:originalColor
                           range:NSMakeRange(i, 1)];
            [regStr addAttribute:(NSString *)NSFontAttributeName
                           value:originalFont
                           range:NSMakeRange(i, 1)];
        } else {//是数字
            if (isEndReplaceNumber) {//如果完成替换则结束循环
                [regStr addAttribute:NSForegroundColorAttributeName
                               value:originalColor
                               range:NSMakeRange(i, 1)];
                [regStr addAttribute:(NSString *)NSFontAttributeName
                               value:originalFont
                               range:NSMakeRange(i, 1)];
                continue;
            }
            if (str.length == 0) {
                isStartReplaceNumber = YES;
            }
            [regStr addAttribute:NSForegroundColorAttributeName
                           value:newColor
                           range:NSMakeRange(i, 1)];
            [regStr addAttribute:(NSString *)NSFontAttributeName
                           value:newFont
                           range:NSMakeRange(i, 1)];
        }
    }
    
    return regStr;
}

+ (NSMutableAttributedString *)replaceColorOfBracketString:(NSString *)string newColor:(UIColor *)newColor newFont:(UIFont *)newFont
{
	NSString * newString = [string stringCutByString:@"[]" stringContain:YES];
	return [string replaceWithColorArray:@[newColor] fontArray:@[newFont] stringArray:@[newString]];
}

- (NSMutableAttributedString *)replaceColorOfBracketNewColor:(UIColor *)newColor newFont:(UIFont *)newFont
{
	NSString * string = [self stringCutByString:@"[]" stringContain:YES];
	return [self replaceWithColorArray:@[newColor] fontArray:@[newFont] stringArray:@[string]];
}

- (NSMutableAttributedString *)replaceWithColorArray:(NSArray *)colorArray fontArray:(NSArray *)fontArray stringArray:(NSArray *)stringArray
{
	if(!self || [self isEqualToString:@""])
	{
		return nil;
	}
	NSMutableAttributedString * regStr = [[NSMutableAttributedString alloc]initWithString:self];
	for(int i = 0 ;i < stringArray.count ; i++)
	{
		NSRange range = [self rangeOfString:stringArray[i]];
		[regStr addAttribute:NSForegroundColorAttributeName value:colorArray[i] range:range];
		[regStr addAttribute:NSFontAttributeName value:fontArray[i] range:range];
	}
	return regStr;
}

- (NSMutableAttributedString *)replaceWithColor:(UIColor *)color font:(UIFont *)font string:(NSString *)string
{
    if(!self || [self isEqualToString:@""])
    {
        return nil;
    }
    
//    NSString *copySelf = [self copy];
    NSMutableAttributedString * regStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:string];
    [regStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [regStr addAttribute:NSFontAttributeName value:font range:range];
    return regStr;
}


- (NSString *)stringCutByString:(NSString *)string stringContain:(BOOL)stringContain
{
	NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:string];
	NSRange startRange = [self rangeOfCharacterFromSet:set];
	NSRange endRange = [self rangeOfCharacterFromSet:set options:NSBackwardsSearch];
    if(startRange.location == NSNotFound && endRange.location == NSNotFound){
        if(![string isEqualToString:@"[]"]){
            return [self stringCutByString:@"[]" stringContain:stringContain];
        }
        return self;
    }
	NSRange range;
	if(stringContain == YES)
	{
		range = NSMakeRange(startRange.location, endRange.location-startRange.location+1);
	}
	else
	{
		range = NSMakeRange(startRange.location+1, endRange.location-startRange.location-1);
	}
	return [self substringWithRange:range];
}


- (NSString *)stringOmittingTheMiddleSectionWithWidth:(CGFloat)width font:(UIFont *)font{
    NSMutableString *string = [NSMutableString string];
    CGSize size = [self sizeWithFont:font];
    if (size.width <= width) {
        return self;
    } else {
        
    }
    return string;
}
@end
