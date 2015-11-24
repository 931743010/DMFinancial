//
//  DMUserDetailInfoViewController.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMUserDetailInfoViewController.h"
#import "DMUserCenterService.h"
#import "DMUserWorksViewController.h"
#import "DMInfoCell.h"
#import "DMUserInfo.h"
#import "DMBirthdayPicker.h"
#import "DMUserWorksViewController.h"
#define kGenderSheet 0x1001

@interface DMUserDetailInfoViewController () <UITableViewDataSource, UITableViewDelegate,DMInfoCellDelegate,UIActionSheetDelegate>{
    UITableView *_tableView;
    NSArray *_array1;
    NSArray *_array2;
    NSArray *_array3;
    DMUserInfoDetail *_userInfoDetail;

}

@end

@implementation DMUserDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更新个人信息";
    [self createSubViews];
    _userInfoDetail = [DMUserInfoDetail new];
    _array1 = @[@"头像",@"真实姓名",@"性别",@"学校",@"专业",@"毕业时间",@"行业方向",@"公司",@"职业"];
    _array2 = @[@"个人标签",@"工作经历",@"教育经历"];
    _array3 = @[@"求职心态",@"工作年限",@"期望薪资",@"求职宣言",@"工作地点",@"邮箱",@"微信",@"QQ"];
    [self requestUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0,
                                                               0,
                                                               self.view.width,
                                                               self.view.height)
                                              style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled = YES;
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:_tableView];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _tableView.tableFooterView = [[UIView alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithResourcesPathCompontent:@"icon_experst_rightBarButton.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];

}

#pragma mark-----------------私有方法-------------------

-(void)rightBarButtonAction {
    [self sendUserInfoDetail];
}
- (void)gotoUserDetailInfo {
    
}

-(NSMutableDictionary *)getParams {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"info1" forKey:@"action"];
    [params setSafetyObject:_userInfoDetail.headimgid forKey:@"headimgid"];
    [params setSafetyObject:_userInfoDetail.name forKey:@"name"];
    [params setSafetyObject:_userInfoDetail.sex forKey:@"sex"];
    [params setSafetyObject:_userInfoDetail.school forKey:@"school"];
    [params setSafetyObject:_userInfoDetail.Professional forKey:@"Professional"];
    [params setSafetyObject:_userInfoDetail.gradtime forKey:@"gradtime"];
    [params setSafetyObject:_userInfoDetail.career_direction forKey:@"career_direction"];
    [params setSafetyObject:_userInfoDetail.Company forKey:@"Company"];
    [params setSafetyObject:_userInfoDetail.Position forKey:@"Position"];
    [params setSafetyObject:_userInfoDetail.Tags forKey:@"Tags"];
    [params setSafetyObject:_userInfoDetail.Work_experience forKey:@"Work_experience"];
    [params setSafetyObject:_userInfoDetail.Education_experience forKey:@"Education_experience"];
    [params setSafetyObject:_userInfoDetail.Job_attitude forKey:@"Job_attitude"];
    [params setSafetyObject:_userInfoDetail.Work_age forKey:@"Work_age"];
    [params setSafetyObject:_userInfoDetail.Expected_salary forKey:@"Expected_salary"];
    [params setSafetyObject:_userInfoDetail.Job_declaration forKey:@"Job_declaration"];
    [params setSafetyObject:_userInfoDetail.Place forKey:@"Place"];
    [params setSafetyObject:_userInfoDetail.mail forKey:@"mail"];
    [params setSafetyObject:_userInfoDetail.wechat forKey:@"wechat"];
    [params setSafetyObject:_userInfoDetail.qq forKey:@"qq"];

    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00rcG9UQkt1VlhaMmxWblE" forKey:@"token"];
    return params;
    
}
#pragma mark -----------------request--------------------

-(void)sendUserInfoDetail {
    
    [self showLoadingViewWithText:kLoadingText];
    [DMUserCenterService setUserInformation1WithParams:[self getParams] success:^(id returnData) {
        [self hideLoadingView];
        [self userInfoRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];

}
-(void)requestUserInfo {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"getinfo1" forKey:@"action"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];

    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00rcG9UQkt1VlhaMmxWblE" forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMUserCenterService getUserInformation1WithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self userInfoRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
    
}

-(void)requestSendUserInfo {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setSafetyObject:@"info1" forKey:@"action"];
    [params setSafetyObject:@"E0Y3I0MTc5_NFc4NHpDTzFUdTQ9" forKey:@"userid"];
    
    [params setSafetyObject:@"kxemhhbmduaW5nMTM5OANy9wZzVoL0tBNU4xUUZpZGwzTmtBMlViMEQ3UDBaUGRtU2lUNHhPMnlYVFd5NUJ0NktyRzFZdm1NRzBaejRnNUdkMVo3M00rcG9UQkt1VlhaMmxWblE" forKey:@"token"];
    
    [self showLoadingViewWithText:kLoadingText];
    [DMUserCenterService getUserInformation1WithParams:params success:^(id returnData) {
        [self hideLoadingView];
        [self userInfoRequestSuccess:returnData];
    } fail:^(NSError *error) {
        [self hideLoadingView];
        [self showErrorViewWithText:[error localizedDescription]];
    }];
    
}

#pragma mark -------------dataRequestSuccess----------------

-(void)userInfoRequestSuccess:(DMUserInfoDetail *)returnData {
    _userInfoDetail = returnData;
    
    [_tableView reloadData];
}

- (BOOL)shouldShowTextFieldAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString *string = [_array1 objectAt:indexPath.row];
        if ([string isEqualToString:@"头像"] || [string isEqualToString:@"性别"] || [string isEqualToString:@"毕业时间"]) {
            return NO;
        }
    } else if (indexPath.section == 0) {
        NSString *string = [_array2 objectAt:indexPath.row];
        if ([string isEqualToString:@"工作经历"] || [string isEqualToString:@"教育经历"]) {
            return NO;
        }
    } else {
        NSString *string = [_array3 objectAt:indexPath.row];
        if ([string isEqualToString:@"工作年限"] || [string isEqualToString:@"期望薪资"] || [string isEqualToString:@"毕业时间"]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - Actionsheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == kGenderSheet) {
        if (buttonIndex != actionSheet.cancelButtonIndex) {
//            self.userProfile.gender = buttonIndex + 1;
//            [self uploadUserInfo];
        }
        
    }
}

#pragma mark-----------------DMInfoCellDelegate-------------------


-(void)textChangeActionWithcell:(DMTableViewCell *)cell string:(NSString *)string {
    if (string.length == 0) {
        return;
    }
    if ([cell.textLabel.text isEqualToString:@"真实姓名"]) {
        _userInfoDetail.name = string;
    }
    if ([cell.textLabel.text isEqualToString:@"性别"]) {
        _userInfoDetail.sex = string;
    }
    if ([cell.textLabel.text isEqualToString:@"学校"]) {
        _userInfoDetail.school = string;
    }
    if ([cell.textLabel.text isEqualToString:@"专业"]) {
        _userInfoDetail.Professional = string;
    }
    if ([cell.textLabel.text isEqualToString:@"毕业时间"]) {
        _userInfoDetail.gradtime = string;
    }
    if ([cell.textLabel.text isEqualToString:@"行业方向"]) {
        _userInfoDetail.career_direction = string;
    }
    if ([cell.textLabel.text isEqualToString:@"公司"]) {
        _userInfoDetail.Company = string;
    }
    if ([cell.textLabel.text isEqualToString:@"职业"]) {
        _userInfoDetail.Position = string;
    }
    if ([cell.textLabel.text isEqualToString:@"个人标签"]) {
        _userInfoDetail.Tags = string;
    }
    if ([cell.textLabel.text isEqualToString:@"工作经历"]) {
        _userInfoDetail.Work_experience = string;
    }
    if ([cell.textLabel.text isEqualToString:@"教育经历"]) {
        _userInfoDetail.Education_experience = string;
    }
    if ([cell.textLabel.text isEqualToString:@"求职心态"]) {
        _userInfoDetail.Job_attitude = string;
    }
    if ([cell.textLabel.text isEqualToString:@"工作年限"]) {
        _userInfoDetail.Work_age = string;
    }
    if ([cell.textLabel.text isEqualToString:@"期望薪资"]) {
        _userInfoDetail.Expected_salary = string;
    }
    if ([cell.textLabel.text isEqualToString:@"求职宣言"]) {
        _userInfoDetail.Job_declaration = string;
    }
    if ([cell.textLabel.text isEqualToString:@"工作地点"]) {
        _userInfoDetail.Place = string;
    }
    if ([cell.textLabel.text isEqualToString:@"邮箱"]) {
        _userInfoDetail.mail = string;
    }
    if ([cell.textLabel.text isEqualToString:@"微信"]) {
        _userInfoDetail.wechat = string;
    }
    if ([cell.textLabel.text isEqualToString:@"QQ"]) {
        _userInfoDetail.qq = string;
    }
}


#pragma mark-----------------UITableViewDataSource-------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _array1.count;
    } else if (section == 1) {
        return _array2.count;
    } else {
        return _array3.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMInfoCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DMInfoCell"];
    if (!cell) {
        cell = [[DMInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DMInfoCell"];
    }

    if (indexPath.section == 0) {
        cell.textLabel.text = [_array1 objectAt:indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = [_array2 objectAt:indexPath.row];
    } else {
        cell.textLabel.text = [_array3 objectAt:indexPath.row];
    }
    cell.showTextField = [self shouldShowTextFieldAtIndexPath:indexPath];

    if ([cell.textLabel.text isEqualToString:@"真实姓名"]) {
        cell.detailText = _userInfoDetail.name;
    }
    if ([cell.textLabel.text isEqualToString:@"性别"]) {
        cell.detailText = _userInfoDetail.sex;

    }
    if ([cell.textLabel.text isEqualToString:@"学校"]) {
        cell.detailText = _userInfoDetail.school;
    }
    if ([cell.textLabel.text isEqualToString:@"专业"]) {
        cell.detailText = _userInfoDetail.Professional;
    }
    if ([cell.textLabel.text isEqualToString:@"毕业时间"]) {
        cell.detailText = _userInfoDetail.gradtime;
    }
    if ([cell.textLabel.text isEqualToString:@"行业方向"]) {
        cell.detailText = _userInfoDetail.career_direction;
    }
    if ([cell.textLabel.text isEqualToString:@"公司"]) {
        cell.detailText = _userInfoDetail.Company;
    }
    if ([cell.textLabel.text isEqualToString:@"职业"]) {
        cell.detailText = _userInfoDetail.Position;
    }
    if ([cell.textLabel.text isEqualToString:@"个人标签"]) {
        cell.detailText = _userInfoDetail.Tags;
    }
    if ([cell.textLabel.text isEqualToString:@"工作经历"]) {
        cell.detailText = _userInfoDetail.Work_experience;
    }
    if ([cell.textLabel.text isEqualToString:@"教育经历"]) {
        cell.detailText = _userInfoDetail.Education_experience;
    }
    if ([cell.textLabel.text isEqualToString:@"求职心态"]) {
        cell.detailText = _userInfoDetail.Job_attitude;
    }
    if ([cell.textLabel.text isEqualToString:@"工作年限"]) {
        cell.detailText = _userInfoDetail.Work_age;
    }
    if ([cell.textLabel.text isEqualToString:@"期望薪资"]) {
        cell.detailText = _userInfoDetail.Expected_salary;
    }
    if ([cell.textLabel.text isEqualToString:@"求职宣言"]) {
        cell.detailText = _userInfoDetail.Job_declaration;
    }
    if ([cell.textLabel.text isEqualToString:@"工作地点"]) {
        cell.detailText = _userInfoDetail.Place;
    }
    if ([cell.textLabel.text isEqualToString:@"邮箱"]) {
        cell.detailText = _userInfoDetail.mail;
    }
    if ([cell.textLabel.text isEqualToString:@"微信"]) {
        cell.detailText = _userInfoDetail.wechat;
    }
    if ([cell.textLabel.text isEqualToString:@"QQ"]) {
        cell.detailText = _userInfoDetail.qq;
    }

    cell.textLabel.textColor = kDMDefaultBlackStringColor;
    cell.textLabel.font = FONT(16);
    cell.detailTextLabel.textColor = kDMDefaultGrayStringColor;
    cell.detailTextLabel.font = FONT(12);
    cell.delegate = self;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark----------------UITableViewDelegate---------------------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return AUTOSIZE(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AUTOSIZE(50))];
    view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, AUTOSIZE(50))];
    label.textColor = kDMDefaultBlackStringColor;
    if (section == 1) {
        label.text = @"详细信息";
    } else  if (section == 2) {
        label.text = @"求职信息";
    } else {
        label.text = @"";
    }
    label.font = FONT(16);
    
    [view addSubview:label];

    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return AUTOSIZE(85);
    }
    return AUTOSIZE(50);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *key = [_tableViewScetion objectAtIndex:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"性别"]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择性别"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"男", @"女", nil];
        actionSheet.tag = kGenderSheet;
        [actionSheet showFromTabBar:self.tabBarController.tabBar];

    } else if ([cell.textLabel.text isEqualToString:@"毕业时间"]) {
        DMBirthdayPicker *picker = [[DMBirthdayPicker alloc] init];
        picker.completionHandler = ^(NSDate *date) {
            if (date) {
                //                self.userProfile.age = [self ageForDate:date];
                //                self.userProfile.birthday = date;
                //                [self uploadUserInfo];
            }
        };
        //        picker.currentDate = self.userProfile.birthday;
        [picker showFromViewController:self];
    } else if ([cell.textLabel.text isEqualToString:@"工作经历"]) {
        DMUserWorksViewController *controller = [[DMUserWorksViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
