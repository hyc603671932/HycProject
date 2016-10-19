//
//  StringUtil.h
//  ProjectTemplet
//
//  Created by HouKavin on 16/2/4.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

//判断字符串是否为（空、null、(null)、<null>）
+ (BOOL ) isEmpty:(NSString *) s;

//判断String是否含有有效字符（非空、非空格）
+(BOOL) isValidStr:(NSString *)checkStr;

//判断s1中是否包含s2
+ (BOOL) containsWith :(NSString *) s1  instr: (NSString *) s2;

//删除所输入的内容中的空格号
+(NSString*)trim:(NSString * ) str;

//判断字符串是否为纯数字,1为纯数字，0为非纯数字
+ (BOOL)isPureInt:(NSString*)string;
//判断是不是11位的纯数字
+(BOOL)isElevenPureInt:(NSString*)string;
//判断手机号码（0为移动号码，1为非移动号码）
+(BOOL) isYDPhoneNumber:(NSString *)mobPhoneNum;
//检验是否是符合标准的身份证号码
+(BOOL)checkPeopleIdCard:(NSString*)string;

//string转utf8
+(NSString *)stringByUTF8:(NSString *)str;

//NSString中去除html标签
+ (NSString *)removeHTML:(NSString *)html;

//对于number类型不规则数字的转化，该方法需确保参数为数字
+(NSString *)fitNumberTypeString:(NSString *)str;

//获取json字典中某个key的值（防止因Number类型报错）
+(NSString*)valueFromJson:(NSDictionary * )json  forKey:(NSString *)key;

//转化json中number类型的不规则数字(需确定字典中key对应的值为数字)
+(NSString *)fitNumberFromJson:(NSDictionary *)json  key:(NSString *)key;

//中英混排时计算实际字符长度(长度按中文长度来计算，两个英文字符记为+1)
+(NSUInteger)countLengthOfString:(NSString *) text;

@end
