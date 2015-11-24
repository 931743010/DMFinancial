//
//  NSStringHelper.h
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

#import <Foundation/Foundation.h>

/* 
 * Short hand NSLocalizedString, doesn't need 2 parameters
 */
#define LocalizedString(s) NSLocalizedString(s,s)

/*
 * LocalizedString with an additionl parameter for formatting
 */
#define LocalizedStringWithFormat(s,...) [NSString stringWithFormat:NSLocalizedString(s,s),##__VA_ARGS__]

enum {
	NSTruncateStringPositionStart=0,
	NSTruncateStringPositionMiddle,
	NSTruncateStringPositionEnd
}; typedef int NSTruncateStringPosition;

@interface NSString (Helper)

/*
 * Returns a comma separated NSString for an NSUInteger
 */
+ (NSString*)stringWithFormattedUnsignedInteger:(NSUInteger)integer;

/*
 * Checks to see if the string contains the given string, case insenstive
 */
- (BOOL)containsString:(NSString*)string;

/*
 * Checks to see if the string contains the given string while allowing you to define the compare options
 */
- (BOOL)containsString:(NSString*)string options:(NSStringCompareOptions)options;

/*
 * Returns the MD5 value of the string
 */
- (NSString*)md5;

/*
 * Returns the long value of the string
 */
- (long)longValue;
- (long long)longLongValue;
- (unsigned long long)unsignedLongLongValue;

/*
 * Truncate string to length
 */
- (NSString*)stringByTruncatingToLength:(int)length;
- (NSString*)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom;
- (NSString*)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom withEllipsisString:(NSString*)ellipsis;


/**
 *    判断字符串是否存在于数组中
 *
 *    @param array 
 *
 *    @return 如果存在就返回YES,默认返回NO
 */
-(BOOL)isBelongToArray:(NSArray *)array;

/**
 *    调整文字行间距
 *
 *    @param lineSpacing 行间距
 *
 *    @return
 */
- (NSMutableAttributedString *)attributedTextWithLineSpacing:(CGFloat)lineSpacing font:(UIFont *)font;

/**
 *    替换字符串中指定的字符
 *
 *    @param originalString         原字符串
 *    @param newString              新字符串
 *    @param originalStringLength   originalString的长度
 *    @param onlyReplaceFirstString 是否只替换第一个
 *
 *    @return 替换后的完整字符串
 */
- (NSString *)replaceStringWithOriginalString:(NSString *)originalString newString:(NSString *)newString originalStringLength:(int)originalStringLength onlyReplaceFirstString:(BOOL)onlyReplaceFirstString;

- (NSString *)insertString:(NSString *)aString frontOfString:(NSString *)frontOfString frontOfStringLength:(int)frontOfStringLength onlyInsertFirstOne:(BOOL)onlyInsertFirstOne;

+ (NSString *)getCountdownStringWithSeconds:(long int)seconds;

/**
 *    改变字符串中的数字的颜色
 *
 *    @param string        原字符串
 *    @param originalColor 原来的颜色
 *    @param newColor      新的颜色
 *    @param onlyReplaceFirstNumber      只改变第一串数字
 *
 *    @return <#return value description#>
 */
+ (NSMutableAttributedString *)replaceNumberColorInString:(NSString *)string originalColor:(UIColor *)originalColor newColor:(UIColor *)newColor originalFont:(UIFont *)originalFont newFont:(UIFont *)newFont onlyReplaceFirstNumber:(BOOL)onlyReplaceFirstNumber;


/*
 *    改变字符串[]中间字符串的颜色
 *    @param string        原字符串
 *    @param newColor      新的颜色
 *    @param newFont       新的字体

 */
+ (NSMutableAttributedString *)replaceColorOfBracketString:(NSString *)string newColor:(UIColor *)newColor newFont:(UIFont *)newFont;

/*
 *    改变字符串[]中间字符串的颜色
 *    @param newColor      新的颜色
 *    @param newFont       新的字体

 */

- (NSMutableAttributedString *)replaceColorOfBracketNewColor:(UIColor *)newColor newFont:(UIFont *)newFont;
/*
 *   改变多个字符串的颜色
 *   @param colorArray 颜色的数组
 *   @param fontArray 字体的数组
 *   @param stringArray 字符串的数组
 */
- (NSMutableAttributedString *)replaceWithColorArray:(NSArray *)colorArray fontArray:(NSArray *)fontArray stringArray:(NSArray *)stringArray;
/*   获取指定字符中间的字符串
 *	 @param string 获取之间的字符串
 *   @param stringContain 返回的字符串是否包含原字符
 *
 */

- (NSMutableAttributedString *)replaceWithColor:(UIColor *)color font:(UIFont *)font string:(NSString *)string;

- (NSString *)stringCutByString:(NSString *)string stringContain:(BOOL)stringContain;
@end
