//
//  TLAuthHelper.m
//  ZHCustomer
//
//  Created by  ml on 2017/1/9.
//  Copyright © 2017年  caizhuoyue. All rights reserved.
//

#import "TLAuthHelper.h"
#import <CoreLocation/CoreLocation.h>
#import <Contacts/Contacts.h>

#import <UIKit/UIKit.h>

@implementation TLAuthHelper

+ (BOOL)isEnableLocation {

    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    
    if (authStatus == kCLAuthorizationStatusDenied || authStatus == kCLAuthorizationStatusNotDetermined) {
        
        return NO;
        
    } else {
        
        return YES;
    }

}

+ (BOOL)isEnableContact {
    
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    if (status != CNAuthorizationStatusAuthorized) {
        
        return NO;
        
    } else {
        
        return YES;
    }
    
}

+ (void)openSetting {

    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
@end
