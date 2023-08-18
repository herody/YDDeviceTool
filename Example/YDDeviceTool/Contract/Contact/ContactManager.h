//
//  ContactManager.h
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/8/23.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "BaseModel.h"
#import "ContactModel.h"

/** 联系人排序方式 */
typedef enum : NSUInteger {
    SortByFirstName = 0,    //!< 名字排序.
    SortByLastName = 1,     //!< 姓氏排序.
    SortByCreationTime = 2, //!< 创建时间排序.
} PersonSort;

@interface ContactManager : BaseModel

/** 获取单例对象 */
+ (instancetype)getInstance;


/**
 获取通讯录联系人列表
 
 @param personSort 排序方式
 @param completionBlock 完成回调
 code 等于1成功,否则失败
 personArray 成功返回ContactModel数组, 失败返回nil
 msg 成功或者失败消息
 */
- (void)getAddressBookWithSort:(PersonSort)personSort completionBlock:(void (^)(int code, NSArray<ContactModel *> *personArray, NSString *msg))completionBlock;


/**
 根据RecordID查找联系人
 
 @param recordID 联系人ID
 @return ContactModel对象
 */
- (ContactModel *)getPersonWithRecordID:(ABRecordID)recordID;


/**
 根据Name查找联系人
 
 @param name 查找关键字
 @return ContactModel数组
 */
- (NSArray<ContactModel *> *)getPersonsWithName:(NSString *)name;


/**
 添加联系人到通讯录
 
 @param personModel ContactModel对象
 @return 添加结果
 */
- (BOOL)addPerson:(ContactModel *)personModel;


/**
 批量添加联系到通讯录
 
 @param personArray ContactModel数组
 @return 添加结果
 */
- (BOOL)addPersons:(NSArray<ContactModel *> *)personArray;


/**
 更新联系人
 
 @param personModel ContactModel对象
 @return 更新结果
 */
- (BOOL)updatePerson:(ContactModel *)personModel;


/**
 删除联系人
 
 @param personModel ContactModel对象
 @return 删除结果
 */
- (BOOL)removePerson:(ContactModel *)personModel;


/**
 根据RecordID删除联系人
 
 @param recordID 联系人ID
 @return 删除结果
 */
- (BOOL)removePersonWithRecordID:(ABRecordID)recordID;

@end
