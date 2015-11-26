//
//  DMFeedBackViewController.m
//  DamaiIphone
//
//  Created by 陈彦岐 on 14-1-14.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMFeedBackViewController.h"
#import "DMFeedBackService.h"
#import "DMTextField.h"
#import "DMGlobalVar.h"
//#import "DMUserModel.h"
#import "UIView+JFLayout.h"

@interface DMFeedBackViewController ()<UITextViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UILabel *numberLabel;

@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UILabel *topnoticelabel;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *adviceView;
@property (nonatomic, strong) UIView *contactView;

@end

@implementation DMFeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(commitFeedback:)];
    self.navigationItem.rightBarButtonItems = @[rightBarButtonItem];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    self.tableView.sectionFooterHeight = 20.f;
    self.tableView.sectionHeaderHeight = 0.f;
    self.tableView.separatorColor = kSeperatorColor;
    
    [self.tableView jf_pinEdgesToSuperviewWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIView *)adviceView
{
    if (!_adviceView) {
        _adviceView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
        textView.backgroundColor = [UIColor clearColor];
        textView.delegate = self;
        textView.font = FONT(14);
        textView.returnKeyType = UIReturnKeyNext;
        textView.translatesAutoresizingMaskIntoConstraints = NO;
        [_adviceView addSubview:textView];
        self.textView = textView;
        
        UILabel *topnoticelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 54, self.view.width - 20, 0)];
        topnoticelabel.backgroundColor = [UIColor clearColor];
        topnoticelabel.text = @"请输入您的意见";
        topnoticelabel.textAlignment =  NSTextAlignmentLeft;
        topnoticelabel.textColor = [UIColor lightGrayColor];
        topnoticelabel.font = FONT(14);
        topnoticelabel.numberOfLines = 0;
        topnoticelabel.lineBreakMode = NSLineBreakByWordWrapping;
        topnoticelabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_adviceView addSubview:topnoticelabel];
        self.topnoticelabel = topnoticelabel;
        
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        numberLabel.backgroundColor = [UIColor clearColor];
        numberLabel.textColor = [UIColor lightGrayColor];
        numberLabel.font = FONT(14);
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.text = @"120";
        [_adviceView addSubview:numberLabel];
        [numberLabel jf_pinEdgesToSuperviewWithInsets:UIEdgeInsetsMake(0, 8, 16, 8) exclude:JFEdgeTop];
        
        self.numberLabel = numberLabel;
        
        NSMutableArray *constraints = [NSMutableArray array];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[textView]-8-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_adviceView, textView)]];
        
        [constraints addObjectsFromArray:@[[NSLayoutConstraint constraintWithItem:_textView
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_adviceView
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0
                                                                         constant:8],
                                           [NSLayoutConstraint constraintWithItem:_textView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:_adviceView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:-8]]];
        
        [constraints addObjectsFromArray:@[[NSLayoutConstraint constraintWithItem:self.topnoticelabel
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.textView
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1.0
                                                                         constant:8.f],
                                           [NSLayoutConstraint constraintWithItem:self.topnoticelabel
                                                                        attribute:NSLayoutAttributeRight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.textView
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1.0
                                                                         constant:-8.0f],
                                           [NSLayoutConstraint constraintWithItem:self.topnoticelabel
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.textView
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0
                                                                         constant:8.f]]];
        
        [_adviceView addConstraints:constraints];
    }
    return _adviceView;
}

- (UIView *)contactView
{
    if (!_contactView) {
        _contactView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textColor = kDMDefaultBlackStringColor;
        tipLabel.font = FONT(14);
        tipLabel.textAlignment = NSTextAlignmentRight;
        tipLabel.text = @"联系方式：";
        [_contactView addSubview:tipLabel];
        
        [tipLabel jf_alignAxisToSuperViewAxis:JFAxisVertical];
        [tipLabel jf_pinEdgeToSuperviewEdge:JFEdgeLeft withInset:8];
        [tipLabel jf_pinDimension:JFDimensionWidth withSize:80];

        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
        textField.font = FONT(14);
        textField.placeholder = @"请输入手机号(必填)";
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.returnKeyType = UIReturnKeySend;
        textField.backgroundColor = [UIColor clearColor];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        [_contactView addSubview:textField];
        
        [textField jf_pinEdge:JFEdgeLeft toEdge:JFEdgeRight ofView:tipLabel];
        [textField jf_pinEdgeToSuperviewEdge:JFEdgeRight withInset:8];
        [textField jf_alignAxisToSuperViewAxis:JFAxisVertical];
        
        self.textField = textField;
        
    }
    return _contactView;
}

#pragma mark - Configure Cell

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(&*self) weakself = self;
    if (indexPath.section == 0) {
        [cell.contentView addSubview:weakself.adviceView];
        [weakself.adviceView jf_pinEdgesToSuperviewWithInsets:UIEdgeInsetsZero];

    }else {
        [cell.contentView addSubview:weakself.contactView];
        [weakself.contactView jf_pinEdgesToSuperviewWithInsets:UIEdgeInsetsZero];
    }
}

#pragma mark - Tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - Tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 146;
    }
    else {
        return 44.0;
    }
}

#pragma mark - Override

- (NSString *)descForUmeng {
    return @"用户反馈页";
}

#pragma mark - Actions

- (void)commitFeedback:(id)sender
{
    [self sendButtonClicked];
}

- (void)sendButtonClicked {
    [self.view endEditing:YES];
    if ([self.textView.text length] != 0) {
        NSString *c= self.textView.text;
        c = [c stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([c isEqual:@""]) {
            [self showAlertViewWithText:@"提交的问题不能为空"];
            self.textView.text = nil;
            return;
        } else if ([self.textView.text length] <6) {
            [self showAlertViewWithText:@"问题描述至少需要6个字"];
            return;
        } else {
        }
    } else {
        [self showAlertViewWithText:@"提交的问题不能为空"];
        return;
    }
    
    if ([self.textField.text length] != 0) {
        NSString *c=[DMHelper removeSpace:self.textField.text];
        if ([c isEqual:@""]) {
            [self showAlertViewWithText:@"手机号不能为空"];
            self.textField.text = nil;
            return;
        }
    } else {
        [self showAlertViewWithText:@"手机号不能为空"];
        return;
    }
    
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
    [self sendFeedBackRequest];
}

- (void)sendFeedBackRequest {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.textView.text, @"content",
                           self.textField.text, @"contact", nil];
    [self showLoadingViewWithText:kLoadingText];
    [DMFeedBackService serviceWithParameters:param
                                     success:^(id returnData) {
                                         [self hideLoadingView];
                                         [self showAlertViewWithText:@"反馈发送成功"];
                                         [self performSelector:@selector(backButtonAction:) withObject:nil afterDelay:2.0f];
                                     } fail:^(NSError *error) {
                                         [self hideLoadingView];
                                         [self showErrorViewWithText:[error localizedDescription]];
                                     }];
}

#pragma mark - TextView Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
    if ([text isEqualToString:@"\n"]) {//按下return键
        //这里隐藏键盘，不做任何处理
        [self.textField becomeFirstResponder];
        return NO;
    }else {
        //判断加上输入的字符，是否超过界限
        
        NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
        if (str.length > 120)
        {
            textView.text = [str substringToIndex:120];
            self.numberLabel.text = [@(120 - textView.text.length) stringValue];
            return NO;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        self.topnoticelabel.hidden = NO;
    } else {
        self.topnoticelabel.hidden = YES;
    }
    if (textView.text.length > 120 && textView.markedTextRange == nil) {
        textView.text = [textView.text substringToIndex:120];
    }
    
    self.numberLabel.text = [@(120 - textView.text.length) stringValue];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    [self sendButtonClicked];
    return YES;
}


- (void)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"(^1[\\d]{10}$)|(^00(((852|853)[\\d]{8})|((88609)[\\d]{8}))$)";
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\d])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark - 监听键盘

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect frame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(frame), 0);
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.tableView.scrollIndicatorInsets = insets;
                         self.tableView.contentInset = insets;
                     } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.tableView.scrollIndicatorInsets = insets;
                         self.tableView.contentInset = insets;
                     } completion:nil];
}

@end
