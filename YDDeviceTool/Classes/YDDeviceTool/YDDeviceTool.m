//
//  CKDeviceTools.m
//  YDDeviceTool
//
//  Created by houyadi on 2018.
//  Copyright © 2018年 houyadi. All rights reserved.
//

#import "YDDeviceTool.h"
#import <sys/utsname.h>
#import <sys/ioctl.h>
#import <sys/stat.h>
#import <net/if.h>
#import <arpa/inet.h>
#import <dlfcn.h>
#import <ifaddrs.h>
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <AVFoundation/AVFoundation.h>

@implementation YDDeviceTool

//获取idfa
+ (NSString *)getIDFA
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

//获取idfv
+ (NSString *)getIDFV
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

//获取UUID
+ (NSString *)getUUID
{
    return [[NSUUID UUID] UUIDString];
}

//系统版本
+ (NSString *)getSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

// 获取设备型号然后手动转化为对应名称
+ (NSString *)getDeviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if([deviceString isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if([deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if([deviceString isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
    if([deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if([deviceString isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if([deviceString isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

//获取设备名字
+ (NSString *)getDeviceName
{
    return [UIDevice currentDevice].name;
}

//获取磁盘大小
+ (long)getTotalDiskSize
{
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *diskTotalSize = [systemAttributes objectForKey:NSFileSystemSize];
    return (long)(diskTotalSize.floatValue / 1024.f / 1024.f);
}

//获取磁盘剩余空间
+ (long)getUsableDiskSize
{
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *diskFreeSize = [systemAttributes objectForKey:NSFileSystemFreeSize];
    return (long)(diskFreeSize.floatValue / 1024.f / 1024.f);
}

//获取电量
+ (CGFloat)getBatteryValue
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [[UIDevice currentDevice] batteryLevel];
}

//获取电池的状态
+ (int)getBatteryStatus
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    UIDeviceBatteryState batteryState = [UIDevice currentDevice].batteryState;
    switch (batteryState) {
        case UIDeviceBatteryStateUnplugged:
            return 0;
        case UIDeviceBatteryStateCharging:
            return 1;
        case UIDeviceBatteryStateFull:
            return 2;
        default:
            return 3;
    }
}

//屏幕尺寸
+ (CGSize)getScreenSize
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGSize screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);
    return screenSize;
}

//屏幕亮度
+ (CGFloat)getScreenBrightness
{
    return [UIScreen mainScreen].brightness;
}

//音量大小
+ (CGFloat)getVolumeValue
{
    return [[AVAudioSession sharedInstance] outputVolume];
}

//获取wifi名称
+ (NSString *)getWifiSSID
{
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dctySSID = (NSDictionary *)info;
    
    return [dctySSID objectForKey:@"SSID"];
}

//网络制式
+ (NSString *)getMobileCarrier
{
    NSString *mobileCarrier;
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
    NSString *MCC = carrier.mobileCountryCode;
    NSString *MNC = carrier.mobileNetworkCode;
    
    if (!MCC || !MNC) {
        mobileCarrier = @"No Sim";
    } else {
        if ([MCC isEqualToString:@"460"]) {
            if ([MNC isEqualToString:@"00"] || [MNC isEqualToString:@"02"] || [MNC isEqualToString:@"07"]) {
                mobileCarrier = @"China Mobile";
            } else if ([MNC isEqualToString:@"01"] || [MNC isEqualToString:@"06"]) {
                mobileCarrier = @"China Unicom";
                
            } else if ([MNC isEqualToString:@"03"] || [MNC isEqualToString:@"05"] || [MNC isEqualToString:@"11"]) {
                mobileCarrier = @"China Telecom";
                
            } else if ([MNC isEqualToString:@"20"]) {
                mobileCarrier = @"China Tietong";
                
            } else {
                mobileCarrier = [NSString stringWithFormat:@"MNC%@", MNC];
            }
        } else {
            mobileCarrier = @"Foreign Carrier";
        }
    }
    return mobileCarrier;
}

//获取外网ip
+ (NSString *)getWANIPAddress
{
    //请求url
    NSURL *url = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
    NSMutableString *mString = [NSMutableString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //判断返回字符串是否为所需数据
    if ([mString hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，获取json数据
        [mString deleteCharactersInRange:NSMakeRange(0, 19)];
        NSString *jsonStr = [mString substringToIndex:mString.length - 1];
        //对Json字符串进行Json解析
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return dict[@"cip"];
    }
    return nil;
}

//获取内网ip
+ (NSString *)getLANIPAddress
{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) return nil;
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    return ips.lastObject;
}

//判断是否越狱
+ (BOOL)isJailBroken
{
    //以下检测的过程是越往下，越狱越高级
    //获取越狱文件路径
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        return YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return YES;
    }
    
    //可能存在hook了NSFileManager方法，此处用底层C stat去检测
    struct stat stat_info;
    if (0 == stat("/Library/MobileSubstrate/MobileSubstrate.dylib", &stat_info)) {
        return YES;
    }
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        return YES;
    }
    if (0 == stat("/var/lib/cydia/", &stat_info)) {
        return YES;
    }
    if (0 == stat("/var/cache/apt", &stat_info)) {
        return YES;
    }
    
    //可能存在stat也被hook了，可以看stat是不是出自系统库，有没有被攻击者换掉。这种情况出现的可能性很小
    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char *,struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        //相等为0，不相等，肯定被攻击
        if (strcmp(dylib_info.dli_fname, "/usr/lib/system/libsystem_kernel.dylib")) {
            return YES;
        }
    }
    
    //通常，越狱机的输出结果会包含字符串：Library/MobileSubstrate/MobileSubstrate.dylib。
    //攻击者给MobileSubstrate改名，原理都是通过DYLD_INSERT_LIBRARIES注入动态库。那么可以检测当前程序运行的环境变量
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    if (env != NULL) {
        return YES;
    }
    
    return NO;
}

//判断是否插入sim卡
+ (BOOL)isSimCardInserted
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    if (!carrier.isoCountryCode) {
        return NO;
    }
    return YES;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

//是否允许推送
+ (BOOL)isPushEnabled
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            return NO;
        } else {
            return YES;
        }
    } else {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone == type){
            return NO;
        } else {
            return YES;
        }
    }
}

#pragma clang diagnostic pop

//获取系统开机时间到1970时间差值（毫秒）
+ (long)getBootTimeStamp
{
    NSTimeInterval timer = [NSProcessInfo processInfo].systemUptime;
    NSDate *startTime = [[NSDate new] dateByAddingTimeInterval:(-timer)];
    NSTimeInterval timeStamp = [startTime timeIntervalSince1970];
    return timeStamp * 1000;
}

//获取剪切板内容
+ (NSString *)getPasteBoardContent
{
    return [UIPasteboard generalPasteboard].string;
}

//用户是否使用代理
+ (BOOL)isViaProxy
{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com/"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = proxies[0];
    if (![[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        return YES;
    }
    return NO;
}

@end
