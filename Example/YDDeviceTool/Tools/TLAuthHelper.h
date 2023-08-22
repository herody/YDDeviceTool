//
//  TLAuthHelper.h
//  ZHCustomer
//
//  Created by  ml on 2017/1/9.
//  Copyright © 2017年  caizhuoyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLAuthHelper : NSObject
//定位
+ (BOOL)isEnableLocation;
//通讯录
+ (BOOL)isEnableContact;

//打开，应用设置
+ (void)openSetting;

@end
