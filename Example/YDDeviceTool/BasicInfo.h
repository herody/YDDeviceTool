//
//  BasicInfo.h
//  YDDeviceTool_Example
//
//  Created by ml on 2023/8/18.
//  Copyright © 2023 houyadi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicInfo : NSObject

@property (nonatomic, copy) NSString *infoKey;
@property (nonatomic, strong) NSObject *infoValue;

@end

NS_ASSUME_NONNULL_END
