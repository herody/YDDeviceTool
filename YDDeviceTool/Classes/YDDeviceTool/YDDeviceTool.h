//
//  YDDeviceTool.h
//  YDDeviceTool
//
//  Created by houyadi on 2018.
//  Copyright © 2018年 houyadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDDeviceTool : NSObject

//获取idfa
+ (NSString *)getIDFA;

//获取idfv
+ (NSString *)getIDFV;

//获取uuid
+ (NSString *)getUUID;

//系统版本
+ (NSString *)getSystemVersion;

// 获取设备型号然后手动转化为对应名称
+ (NSString *)getDeviceType;

//获取设备名字
+ (NSString *)getDeviceName;

//获取磁盘大小
+ (long)getTotalDiskSize;

//获取磁盘剩余空间
+ (long)getUsableDiskSize;

//获取电量
+ (CGFloat)getBatteryValue;

//获取电池的状态
+ (int)getBatteryStatus;

//屏幕尺寸
+ (CGSize)getScreenSize;

//屏幕亮度
+ (CGFloat)getScreenBrightness;

//音量大小
+ (CGFloat)getVolumeValue;

//网络制式
+ (NSString *)getMobileCarrier;

//获取wifi名称
+ (NSString *)getWifiSSID;

//获取内网ip
+ (NSString *)getLANIPAddress;

//获取外网ip
+ (NSString *)getWANIPAddress;

//判断是否越狱
+ (BOOL)isJailBroken;

//判断是否插入sim卡
+ (BOOL)isSimCardInserted;

//是否允许推送
+ (BOOL)isPushEnabled;

//获取系统开机时间到1970时间差值（毫秒）
+ (long)getBootTimeStamp;

//获取剪切板内容
+ (NSString *)getPasteBoardContent;

//用户是否使用代理
+ (BOOL)isViaProxy;

@end
