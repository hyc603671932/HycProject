//
//  AppInfo.h
//  ProjectTemplet
//
//  Created by HouKavin on 16/2/2.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

+ (AppInfo *)sharedInstance;

//http地址
@property (strong, nonatomic) NSString* baseURL;

//登录人工号（id）
@property (strong, nonatomic) NSString* userId;
//登录人密码
@property (strong, nonatomic) NSString* userPwd;
//登陆人用户名
@property (strong, nonatomic) NSString* userName;

//登陆人部门名称
@property (strong, nonatomic) NSString* unitName;
@property (strong, nonatomic) NSString* orgName;

@end
