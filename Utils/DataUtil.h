//
//  DataUtil.h
//  ProjectTemplet
//
//  Created by HouKavin on 16/2/4.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtil : NSObject


#pragma mark - 获取当前时间
//根据字符串格式获取当前时间
+ (NSString *)getNowTimeByFormat:(NSString*)format;
//获取当前时间（2013-11-12 12:11:11）年-月-日 时:分:秒
+ (NSString *) getTotalNowDateWithLine;
//获取当前时间（2013-11-12 12:11:11）年-月-日 时:分
+ (NSString *) getTotalNowDateWithLineWithoutSec;
//获取当前时间（20131112121111）年月日时分秒
+ (NSString *) getTotalNowDateWithoutLine;

#pragma mark - date类型转为String类型
//将日期按指定格式转换，并返回字符串数据
+ (NSString*)dateToString:(NSDate*)date withFormart:(NSString*)format;

//date转String（2013-11-12 12:11:11）年-月-日 时:分:秒
+ (NSString *)dateToStringWithLine:(NSDate *)date;
//date转String（20131112121111）年月日时分秒
+ (NSString *)dateToStringWithoutLine:(NSDate *)date;
//date转string(2013年11月12日)
+ (NSString *)dateToStringWithChina:(NSDate *)date;
//date转String（2013-11-12）年-月-日
+ (NSString *)dateToStringWithLineYYDDMM:(NSDate *)date;
//date转String（20131112）年月日
+ (NSString *)dateToStringWithoutLineYYDDMM:(NSDate *)date;
//date转String（12:11:11）时分秒
+ (NSString *)dateToStringWithLineHHMMSS:(NSDate *)date;
//date转String，只有年份（2013）
+ (NSString *)dateToStringOnlyYear:(NSDate *)date;
//date转String，返回一年中的第几周（1，12，52）
+ (NSString *)dateToStringWithWeekOfYear:(NSDate *)date;

#pragma mark - date类型转为String类型
//将字符按指定格式转换，并返回日期
+ (NSDate*)stringToDate:(NSString*)date withFormart:(NSString*)format;
//String转date（string格式为2013-11-12）
+ (NSDate *)stringToDateWithLine:(NSString *)dateString;
//String转date（string格式为20131112）
+ (NSDate *)stringToDateWithoutLine:(NSString *)dateString;
//String转成时间(16:00)
+ (NSDate *)stringToDateWithLineHHMM:(NSString *)dateString;

@end
