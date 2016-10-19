//
//  StringUtil.m
//  ProjectTemplet
//
//  Created by HouKavin on 16/2/4.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

//判断字符串是否为空(针对http)
+ (BOOL )isEmpty:(NSString *) s
{
    if (s == nil || [[NSNull null] isEqual:s]) {
        return YES;
    } else if ([s length] == 0 || [s isEqualToString:@"<null>"]||[s isEqualToString:@"null"]||[s isEqualToString:@"(null)"]) {
        return YES;
    } else {
        s = [s stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([s length] == 0) {
            return YES;
        }
    }
    return NO;
}

//判断String是否含有有效字符（非空、非空格）
+(BOOL)isValidStr:(NSString *)checkStr{
    NSString *strNoSpace = [self trim:checkStr];//checkStr去空格
    if (strNoSpace.length == 0) {
        return NO;
    }else {
        return YES;
    }
}

//判断s1中是否包含s2
+ (BOOL)containsWith:(NSString *) s1  instr: (NSString *) s2;
{
    if (s1 == nil || s2 == nil)
        return false;
    NSRange range=[s1 rangeOfString:s2];
    if(range.location != NSNotFound){
        return true;
    }else{
        return false;
    }
}

//删除所输入的内容中的空格号
+(NSString*)trim:(NSString * ) str
{
    if(str==nil)
        return @"";
    return  [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
}

//判断文本框中是不是纯数字
+(BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是不是11位的纯数字
+(BOOL)isElevenPureInt:(NSString*)string{
    if (string.length != 11) {
        return NO;
    }else {
        NSScanner* scan = [NSScanner scannerWithString:string];
        int val;
        return[scan scanInt:&val] && [scan isAtEnd];
    }
}

//判断手机号码（0为移动号码，1为非移动号码）
+(BOOL)isYDPhoneNumber:(NSString *)mobPhoneNum{
    /*
     * 移动: 2G号段(GSM网络)有139,138,137,136,135,134,159,158,152,151,150,
     * 3G号段(TD-SCDMA网络)有157,182,183,188,187 147是移动TD上网卡专用号段.
     * 联通:2G号段(GSM网络)有130,131,132,155,156 3G号段(WCDMA网络)有186,185
     * 电信:2G号段(CDMA网络)有133,153 3G号段(CDMA网络)有189,180
     */
    static NSString *YD = @"(^[1]{1}(([3]{1}[4-9]{1})|([5]{1}[012789]{1})|([8]{1}[23478]{1})|([4]{1}[7]{1}))[0-9]{8}$)";
    
    BOOL flag;// 存储匹配结果
    // 判断手机号码是否是11位
    if (mobPhoneNum.length == 11) {
        // 判断手机号码是否符合中国移动的号码规则
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",YD];
        if ([phoneTest evaluateWithObject:mobPhoneNum]) {
            flag = 1;
        }
        // 都不合适 未知
        else {
            flag = 0;
        }
    }
    // 不是11位
    else {
        flag = 0;
    }
    return flag;
    
}

+(BOOL)checkPeopleIdCard:(NSString*)string{
    static NSString *idCardStyle =  @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *normPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", idCardStyle];
    
    return [normPredicate evaluateWithObject:string];
}


+(NSString *)stringByUTF8:(NSString *)str{
    //[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [str stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
}

//去HTML标记的方法（完整版，把&nbsp;转成回车）
+ (NSString *)removeHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
        //把"&nbsp;"转成回车
        html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@"\n"];
    }
    return html;
}

//对于number类型不规则数字的转化,该方法需确保参数为数字
//（不规则指该数字可能为整数，小数，无限小数）
+(NSString *)fitNumberTypeString:(NSString *)str {
    //不用考虑传过来的时小数还是整数，因为%.2f会把所有数转化为123.00、123.11、123.20形式，还自带四舍五入的
    str = [NSString stringWithFormat:@"%.2f",[str floatValue]];//把传过来的String转化为保留两位小数的float类型数
    int intPart = [[str substringWithRange:NSMakeRange(0,str.length-3)] intValue];//截取整数部分（-3使因为不取小数点）
    int decimalPart = [[str substringWithRange:NSMakeRange(str.length-2,2)] intValue];//截取小数部分
    if (decimalPart == 0) {//如果小数部分为0
        str = [NSString stringWithFormat:@"%d",intPart];//返回整数部分
    }else {
        if (decimalPart%10 == 0) {//如果小数部分使10的倍数（即小数部分为30、20这样）
            decimalPart = decimalPart/10;//截取小数部分的第一个数字
        }
        str = [NSString stringWithFormat:@"%d.%d",intPart,decimalPart];//组合整数部分和小数部分
    }
    return str;
}

//获取json字典中某个key的值（防止因Number类型报错）
+(NSString*)valueFromJson:(NSDictionary * )json  forKey:(NSString *)key{
    NSString *str = [NSString stringWithFormat:@"%@", [json objectForKey:key]];
    if ([self isEmpty:str]) {
        return @"";
    }else {
        return str;
    }
}

//转化json中number类型的不规则数字(需确定字典中key对应的值为数字)
//不规则指该数字可能为整数，小数，无限小数
+(NSString *)fitNumberFromJson:(NSDictionary *)json  key:(NSString *)key{
    NSString *str = [NSString stringWithFormat:@"%@", [json objectForKey:key]];
    return [self fitNumberTypeString:str];
}


//中英混排时计算实际字符长度(长度按中文长度来计算，两个英文字符记为+1)
+(NSUInteger)countLengthOfString: (NSString *) text {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
}

@end
