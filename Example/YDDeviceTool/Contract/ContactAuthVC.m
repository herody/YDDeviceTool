//
//  ContactAuthVC.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2017/12/28.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "ContactAuthVC.h"
#import "ContactManager.h"
#import "ContactModel.h"

#import "TLAuthHelper.h"
#import "TLAlert.h"
#import "NSString+Check.h"

#import <Contacts/Contacts.h>

@interface ContactAuthVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<ContactModel *> *dataSourceArray; //!< 数据源.
@property (nonatomic, strong) NSMutableArray *contacts;
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation ContactAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSourceArray = [NSMutableArray array];
    self.contacts = [NSMutableArray array];
    [self getContact];
    
    self.title = @"通讯录权限";
        
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getContact];
}

#pragma mark - Data
- (void)getContact {
    
    [[ContactManager getInstance] getAddressBookWithSort:SortByFirstName completionBlock:^(int code, NSArray<ContactModel *> *personArray, NSString *msg) {
        
        if (code == 1) {
            
            [self.dataSourceArray removeAllObjects];
            [self.dataSourceArray addObjectsFromArray:personArray];
            [self.contacts removeAllObjects];
            NSLog(@"arrayCount = %ld", _dataSourceArray.count);
            
            [self requestContactAuth];
            
        } else if (code == -1) {
            
            NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
            
            NSString *displayName = [infoDict objectForKey:@"CFBundleDisplayName"];
            
            NSString *promptStr = [NSString stringWithFormat:@"通讯录未授权，请前往“设置->%@->通讯录“中开启通讯录", displayName];
            
            [TLAlert alertWithTitle:@"提示" msg:promptStr confirmMsg:@"设置" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {
                
            } confirm:^(UIAlertAction *action) {
                
                [TLAuthHelper openSetting];
            }];
        }
        
    }];
}

- (void)requestContactAuth {
    
    for (ContactModel *contact in self.dataSourceArray) {
        
        NSDictionary *dic = [NSDictionary dictionary];
        
        NSString *name = @"";
        //姓名不存在就传公司名
        if (contact.firstName == nil && contact.lastName == nil) {
            name = contact.organization == nil ? @"无": contact.organization;
        } else {
            NSString *firstName = contact.firstName == nil ? @"": contact.firstName;
            NSString *lastName = contact.lastName == nil ? @"": contact.lastName;
            name = [NSString stringWithFormat:@"%@%@", lastName, firstName];
            if (![name valid]) {
                continue ;
            }
        }
        
        NSString *mobile = @"";
        if (contact.phones.count > 0) {
            for (LabelStringModel *stringModel in contact.phones) {
                mobile = [NSString stringWithFormat:@"%@/%@", mobile, stringModel.content];
                //如果mobile为空就跳过本次循环
                if (![mobile valid]) {
                    continue ;
                }
            }
        } else {
            mobile = @"无";
        }
        dic = @{@"name": name,
                @"mobile": mobile,
        };
        [self.contacts addObject:dic];
    }
    [self.myTableView reloadData];

    
//    TLNetworking *http = [[TLNetworking alloc] init];
//
//    http.showView = self.view;
//
//    http.code = @"805257";
//    http.parameters[@"addressBookList"] = self.contacts;
//    http.parameters[@"userId"] = [TLUser user].userId;
//    http.parameters[@"searchCode"] = [TLUser user].tempSearchCode;
//
//    [http postWithSuccess:^(id responseObject) {
//
//        [TLAlert alertWithSucces:@"通讯录认证成功"];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            [self pushViewController];
//
//        });
//    } failure:^(NSError *error) {
//
//
//    }];
}

- (void)getContactAfteriOS9 {
    
    if (![TLAuthHelper isEnableContact]) {
        
        NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
        
        NSString *displayName = [infoDict objectForKey:@"CFBundleDisplayName"];
        
        NSString *promptStr = [NSString stringWithFormat:@"通讯录未授权，请前往“设置->%@->通讯录“中开启通讯录", displayName];
        
        [TLAlert alertWithTitle:@"提示" msg:promptStr confirmMsg:@"设置" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {
            
        } confirm:^(UIAlertAction *action) {
            
            [TLAuthHelper openSetting];
        }];
    }
    
    // 3.创建通信录对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    // 4.创建获取通信录的请求对象
    // 4.1.拿到所有打算获取的属性对应的key
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    // 4.2.创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    // 5.遍历所有的联系人
    [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        // 1.获取联系人的姓名
        NSString *lastname = contact.familyName;
        NSString *firstname = contact.givenName;
        NSLog(@"%@ %@", lastname, firstname);
        
        // 2.获取联系人的电话号码
        NSArray *phoneNums = contact.phoneNumbers;
        for (CNLabeledValue *labeledValue in phoneNums) {
            // 2.1.获取电话号码的KEY
            NSString *phoneLabel = labeledValue.label;
            
            // 2.2.获取电话号码
            CNPhoneNumber *phoneNumer = labeledValue.value;
            NSString *phoneValue = phoneNumer.stringValue;
            
            NSLog(@"%@ %@", phoneLabel, phoneValue);
        }
    }];
    
}



#pragma mark - UITableViewDelegate && UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.contacts.count;
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
    NSDictionary *info = self.contacts[indexPath.row];
    cell.textLabel.text = info[@"name"];
    cell.detailTextLabel.text = info[@"mobile"];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
