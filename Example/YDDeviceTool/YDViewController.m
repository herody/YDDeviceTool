//
//  YDViewController.m
//  YDDeviceTool
//
//  Created by houyadi on 06/25/2018.
//  Copyright (c) 2018 houyadi. All rights reserved.
//

#import "YDViewController.h"
#import <YDDeviceTool/YDDeviceTool.h>

@interface YDViewController ()

@end

@implementation YDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"设备名称是：%@", [YDDeviceTool getDeviceName]);
    NSLog(@"设备类型是：%@", [YDDeviceTool getDeviceType]);
    NSLog(@"设备外网ip是：%@", [YDDeviceTool getWANIPAddress]);
    NSLog(@"设备内网ip是：%@", [YDDeviceTool getLANIPAddress]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
