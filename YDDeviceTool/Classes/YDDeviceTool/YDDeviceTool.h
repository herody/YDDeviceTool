//
//  YDDeviceTool.h
//  YDDeviceTool
//
//  Created by houyadi on 2018.
//  Copyright © 2018年 houyadi. All rights reserved.
//

/*
 UUID：英文名称是：Universally Unique Identifier，翻译过来就是通用唯一标识符。
 UUID是指在一台机器上生成的数字，它保证对在同一时空中的所有机器都是唯一的。通常平台会提供生成的API，
 是一个32位的十六进制序列，使用小横线来连接：8-4-4-4-12。
 由于UUID的本身特性,它保证对在同一时空中的所有机器都是唯一的。
 所以，需要作为唯一标识码的话，你可以通过保存在keychain或者NSUserDefaults中。
 
 UDID: 目前主要用于配置真机调试证书。
 
 MAC地址: 因为隐私问题，在iOS7以后，苹果禁止获取MAC地址，系统现在只会返回02:00:00:00:00:00虚拟的地址。
 
 IMEI:  因为隐私问题，苹果用户在iOS5以后不能再获取IMEI的值了。隐私api不能上架苹果商店，
 */

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





// ================
/** 获取本 App 所占磁盘空间 */
+ (NSString *)getApplicationSize;
/** 获取磁盘总空间 */
+ (int64_t)getTotalDiskSpace;
/** 获取未使用的磁盘空间 */
+ (int64_t)getFreeDiskSpace;
/** 获取已使用的磁盘空间 */
+ (int64_t)getUsedDiskSpace;


/** 获取总内存空间 */
+ (int64_t)getTotalMemory;
/** 获取活跃的内存空间 */
+ (int64_t)getActiveMemory;
/** 获取不活跃的内存空间 */
+ (int64_t)getInActiveMemory;
/** 获取空闲的内存空间 */
+ (int64_t)getFreeMemory;
/** 获取正在使用的内存空间 */
+ (int64_t)getUsedMemory;
/** 获取存放内核的内存空间 */
+ (int64_t)getWiredMemory;
/** 获取可释放的内存空间 */
+ (int64_t)getPurgableMemory;

@end
