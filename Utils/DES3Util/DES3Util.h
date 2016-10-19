//
//  DES3Util.h
//  YMT
//
//  Created by Yilia on 3/16/15.
//  Copyright (c) 2015 com.softtek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DES3Util : NSObject {
    
}

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

@end
