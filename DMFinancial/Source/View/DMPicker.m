//
//  DMPicker.m
//  DamaiPlayPhone
//
//  Created by Joseph Fu on 15/1/19.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMPicker.h"

@interface DMPicker ()

@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) UIView *mainView;

@end
@implementation DMPicker

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    
    [self createSubviews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect rect = self.mainView.frame;
    self.mainView.frame = CGRectOffset(rect, 0, CGRectGetHeight(rect));
    [UIView animateWithDuration:0.35
                     animations:^{
                         self.mainView.frame = CGRectOffset(rect, 0, 0);
                     } completion:^(BOOL finished) {
                     }];
}

- (void)showFromViewController:(UIViewController *)viewController
{
    NSAssert([viewController isKindOfClass:[UIViewController class]], @"必须是viewController");
    [viewController addChildViewController:self];
    
    UIView *superview = viewController.view;
    UIView *subview = self.view;
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addSubview:subview];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(superview, subview);
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[subview]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self didMoveToParentViewController:viewController];
}

- (void)removeFromScreen
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)cancel:(UIButton *)button
{
    [self removeFromScreen];
}

- (void)confirm:(UIButton *)button
{
    [self removeFromScreen];
}

- (void)createSubviews
{
    _mainView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_mainView];
    
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    _headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.mainView addSubview:_headerView];
    
    _containerView = [[UIView alloc] initWithFrame:CGRectZero];
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.mainView addSubview:_containerView];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
    cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithHexString:@"fd575d"] forState:UIControlStateNormal];
    [cancelButton addTarget:self
                     action:@selector(cancel:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:cancelButton];
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
    confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
    [confirmButton setTitle:@"完成" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor colorWithHexString:@"fd575d"] forState:UIControlStateNormal];
    [confirmButton addTarget:self
                      action:@selector(confirm:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:confirmButton];
    
    
    NSMutableArray *constraints = [NSMutableArray array];
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view, _mainView);
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_mainView]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_mainView(260)]|" options:0 metrics:nil views:views]];
    
    views = NSDictionaryOfVariableBindings(self.mainView, _headerView);
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_headerView]|" options:0 metrics:nil views:views]];
    
    views = NSDictionaryOfVariableBindings(self.mainView, _containerView);
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_containerView]|" options:0 metrics:nil views:views]];
    
    views = NSDictionaryOfVariableBindings(self.mainView, _headerView, _containerView);
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_headerView(44)][_containerView]-|" options:0 metrics:nil views:views]];
    
    views = NSDictionaryOfVariableBindings(self.headerView, cancelButton);
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-16-[cancelButton(44)]" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cancelButton]|" options:0 metrics:nil views:views]];
    
    views = NSDictionaryOfVariableBindings(self.headerView, confirmButton);
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[confirmButton(44)]-16-|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[confirmButton]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:constraints];
}

@end
