//
//  YDBasicViewController.m
//  YDDeviceTool_Example
//
//  Created by ml on 2023/8/18.
//  Copyright © 2023 houyadi. All rights reserved.
//

#import "YDBasicViewController.h"
#import <YDDeviceTool/YDDeviceTool.h>

@interface BasicInfo : NSObject

@property (nonatomic, copy) NSString *infoKey;
@property (nonatomic, strong) NSObject *infoValue;

@end

@implementation BasicInfo
@end


@interface YDBasicViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *infoArray;

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation YDBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备信息";
    
    [self _setupHardwareInfo];
    
    self.myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.rowHeight = 80;
    
    [self.view addSubview:self.myTableView];
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{
                                                     NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:28],
                                          NSForegroundColorAttributeName:[UIColor blackColor],
                                                     };
    }
}

- (void)_setupHardwareInfo {
    [self _addInfoWithKey:@"获取idfa" infoValue:[YDDeviceTool getIDFA]];
    [self _addInfoWithKey:@"获取idfv" infoValue:[YDDeviceTool getIDFV]];
    [self _addInfoWithKey:@"获取uuid" infoValue:[YDDeviceTool getUUID]];
    [self _addInfoWithKey:@"系统版本" infoValue:[YDDeviceTool getSystemVersion]];
    
    [self _addInfoWithKey:@"获取设备型号然后手动转化为对应名称" infoValue:[YDDeviceTool getDeviceType]];
    [self _addInfoWithKey:@"获取设备名字" infoValue:[YDDeviceTool getDeviceName]];
    
    [self _addInfoWithKey:@"获取电量" infoValue:@([YDDeviceTool getBatteryValue])];
    [self _addInfoWithKey:@"获取电池的状态" infoValue:@([YDDeviceTool getBatteryStatus])];
    
    [self _addInfoWithKey:@"屏幕尺寸" infoValue:@([YDDeviceTool getScreenSize])];
    
    [self _addInfoWithKey:@"屏幕亮度" infoValue:@([YDDeviceTool getScreenBrightness])];
    [self _addInfoWithKey:@"音量大小" infoValue:@([YDDeviceTool getVolumeValue])];
    
    [self _addInfoWithKey:@"网络制式" infoValue:[YDDeviceTool getMobileCarrier]];
    [self _addInfoWithKey:@"获取wifi名称" infoValue:[YDDeviceTool getWifiSSID]];
    [self _addInfoWithKey:@"获取内网ip" infoValue:[YDDeviceTool getLANIPAddress]];
    [self _addInfoWithKey:@"获取外网ip" infoValue:[YDDeviceTool getWANIPAddress]];
    
    
    [self _addInfoWithKey:@"判断是否越狱" infoValue:@([YDDeviceTool isJailBroken])];
    [self _addInfoWithKey:@"判断是否插入sim卡" infoValue:@([YDDeviceTool isSimCardInserted])];
    
    [self _addInfoWithKey:@"是否允许推送" infoValue:@([YDDeviceTool isPushEnabled])];
    [self _addInfoWithKey:@"获取系统开机时间到1970时间差值（毫秒）" infoValue:@([YDDeviceTool getBootTimeStamp])];
    
    [self _addInfoWithKey:@"获取剪切板内容" infoValue:[YDDeviceTool getPasteBoardContent]];
    [self _addInfoWithKey:@"用户是否使用代理" infoValue:@([YDDeviceTool isViaProxy])];
    
    
    // ============
    
    NSString *applicationSize = [YDDeviceTool getApplicationSize];
    [self _addInfoWithKey:@"当前 App 所占内存空间" infoValue:applicationSize];
    
    int64_t totalDisk = [YDDeviceTool getTotalDiskSpace];
    NSString *totalDiskInfo = [NSString stringWithFormat:@"== %.2f MB == %.2f GB", totalDisk/1024/1024.0, totalDisk/1024/1024/1024.0];
    [self _addInfoWithKey:@"磁盘总空间" infoValue:totalDiskInfo];
    
    int64_t usedDisk = [YDDeviceTool getUsedDiskSpace];
    NSString *usedDiskInfo = [NSString stringWithFormat:@" == %.2f MB == %.2f GB", usedDisk/1024/1024.0, usedDisk/1024/1024/1024.0];
    [self _addInfoWithKey:@"磁盘 已使用空间" infoValue:usedDiskInfo];
    
    int64_t freeDisk = [YDDeviceTool getFreeDiskSpace];
    NSString *freeDiskInfo = [NSString stringWithFormat:@" %.2f MB == %.2f GB", freeDisk/1024/1024.0, freeDisk/1024/1024/1024.0];

    [self _addInfoWithKey:@"磁盘空闲空间" infoValue:freeDiskInfo];
    
    int64_t totalMemory = [YDDeviceTool getTotalMemory];
    NSString *totalMemoryInfo = [NSString stringWithFormat:@" %.2f MB == %.2f GB", totalMemory/1024/1024.0, totalMemory/1024/1024/1024.0];
    [self _addInfoWithKey:@"系统总内存空间" infoValue:totalMemoryInfo];
    
    int64_t freeMemory = [YDDeviceTool getFreeMemory];
    NSString *freeMemoryInfo = [NSString stringWithFormat:@" %.2f MB == %.2f GB", freeMemory/1024/1024.0, freeMemory/1024/1024/1024.0];
    [self _addInfoWithKey:@"空闲的内存空间" infoValue:freeMemoryInfo];
    
    int64_t usedMemory = [YDDeviceTool getFreeDiskSpace];
    NSString *usedMemoryInfo = [NSString stringWithFormat:@" %.2f MB == %.2f GB", usedMemory/1024/1024.0, usedMemory/1024/1024/1024.0];
    [self _addInfoWithKey:@"已使用的内存空间" infoValue:usedMemoryInfo];
    
}



- (void)_addInfoWithKey:(NSString *)infoKey infoValue:(NSObject *)infoValue {
    BasicInfo *info = [[BasicInfo alloc] init];
    info.infoKey = infoKey;
    info.infoValue = infoValue;
    NSLog(@"%@---%@", infoKey, infoValue);
    [self.infoArray addObject:info];
}

#pragma mark - BatteryInfoDelegate
- (void)batteryStatusUpdated {
#warning 当电池状态改变时，会调用该方法，应该在此处reload对应的cell，进行更新UI操作
}

#pragma mark - UITableViewDelegate && UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 为cell设置标识符
    static NSString *idetifier = @"kIndentifier";
    
    //从缓存池中取出 对应标示符的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idetifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idetifier];
    }
    
    // 获取数据字典
    BasicInfo *infoModel = self.infoArray[indexPath.row];
    cell.textLabel.text = infoModel.infoKey;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"------>%@", infoModel.infoValue];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - setters && getters
- (NSMutableArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}


@end

