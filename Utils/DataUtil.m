//
//  DataUtil.m
//  ProjectTemplet
//
//  Created by HouKavin on 16/2/4.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

#import "DataUtil.h"

@implementation DataUtil

//根据字符串格式获取当前时间
+ (NSString *)getNowTimeByFormat:(NSString*)format{
    @try {
        //构造日期格式
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        
        //根据指定日期格式将日期转换成字符串
        NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
        return destDateString;
    }
    @catch (NSException *exception) {
    }
    return @"";
}


//获取当前时间（2013-11-12 12:11:11）年-月-日 时:分:秒
+ (NSString *) getTotalNowDateWithLine {
    NSDate *  senddate = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    
    return locationString;
}

+ (NSString *)getTotalNowDateWithLineWithoutSec {
    NSDate *  senddate = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    
    return locationString;
}

//获取当前时间（20131112121111）年月日时分秒
+ (NSString *) getTotalNowDateWithoutLine {
    NSDate *  senddate = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    
    return locationString;
}

#pragma mark - date类型转为String类型
//将日期按指定格式转换，并返回字符串数据
+ (NSString*)dateToString:(NSDate*)date withFormart:(NSString*)format{
    @try {
        //构造日期格式
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        //根据指定日期格式将日期转换成字符串
        [dateFormatter setDateFormat:format];
        return [dateFormatter stringFromDate:date];
    }
    @catch (NSException *exception) {
        
    }
    return @"";
}

//date转String（2013-11-12 12:11:11）年-月-日 时:分:秒
+ (NSString *)dateToStringWithLine:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//date转String（20131112121111）年月日时分秒
+ (NSString *)dateToStringWithoutLine:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//date转string(2013年11月12日)
+ (NSString *)dateToStringWithChina:(NSDate *)date{
    NSString *destDateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    return destDateString;
}

//date转String（2013-11-12）
+ (NSString *)dateToStringWithLineYYDDMM:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//date转String（20131112）
+ (NSString *)dateToStringWithoutLineYYDDMM:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//date转String（12:11:11）时分秒
+ (NSString *)dateToStringWithLineHHMMSS:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:MM:SS"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//date转String，只有年份（2013）
+ (NSString *)dateToStringOnlyYear:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//date转String，返回一年中的第几周（1，12，52）
+ (NSString *)dateToStringWithWeekOfYear:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //小w代表一年中的第几周，大W代表一月中的第几周
    [dateFormatter setDateFormat:@"w"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


#pragma mark - date类型转为String类型

//将字符按指定格式转换，并返回日期
+ (NSDate*)stringToDate:(NSString*)date withFormart:(NSString*)format{
    @try {
        if(date==nil ||[date isEqualToString:@""]){
            return nil;
        }
        
        //构造日期格式
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        
        //根据指定日期格式将字符串转换成日期
        return [dateFormatter dateFromString:date];
    }
    @catch (NSException *exception) {
    }
}

//String转date（string格式为2013-11-12）
+ (NSDate *)stringToDateWithLine:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

//String转date（string格式为20131112）
+ (NSDate *)stringToDateWithoutLine:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

//String转成时间(16:00)
+ (NSDate *)stringToDateWithLineHHMM:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

@end
