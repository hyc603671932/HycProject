//
//  AppInfo.m
//  ProjectTemplet
//
//  Created by HouKavin on 16/2/2.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

+ (AppInfo *)sharedInstance{
    static AppInfo *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[AppInfo alloc] init];
    });
    return _sharedInstance;
}

@end
