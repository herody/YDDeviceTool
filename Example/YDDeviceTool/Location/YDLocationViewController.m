//
//  YDLocationViewController.m
//  YDDeviceTool_Example
//
//  Created by ml on 2023/8/18.
//  Copyright © 2023 houyadi. All rights reserved.
//

#import "YDLocationViewController.h"
#import "TLAuthHelper.h"
#import "TLAlert.h"
#import "DXLocationManager.h"


@interface YDLocationViewController ()

@end

@implementation YDLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"位置信息";
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{
                                                     NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:28],
                                          NSForegroundColorAttributeName:[UIColor blackColor],
                                                     };
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getLocation];
}

- (void)getLocation {
    
    if (![TLAuthHelper isEnableLocation]) {
        
        NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
        
        NSString *displayName = [infoDict objectForKey:@"CFBundleDisplayName"];
        
        NSString *promptStr = [NSString stringWithFormat:@"位置未授权，请前往“设置->%@->位置“中开启位置", displayName];
        
        [TLAlert alertWithTitle:@"提示" msg:promptStr confirmMsg:@"设置" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {
            
        } confirm:^(UIAlertAction *action) {
            
            [TLAuthHelper openSetting];
        }];
    } else {
        [DXLocationManager getlocationWithBlock:^(double longitude, double latitude) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"位置信息" message:[NSString stringWithFormat:@"经度:%f \n纬度:%f",longitude,latitude] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
@end
