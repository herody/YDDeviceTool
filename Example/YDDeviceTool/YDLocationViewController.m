//
//  YDLocationViewController.m
//  YDDeviceTool_Example
//
//  Created by ml on 2023/8/18.
//  Copyright © 2023 houyadi. All rights reserved.
//

#import "YDLocationViewController.h"

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

@end
