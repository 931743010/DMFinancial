//
//  JFReminderSwitchController.m
//  OpenReminderController
//
//  Created by Joseph Fu on 15/1/5.
//  Copyright (c) 2015年 Joseph Fu. All rights reserved.
//

#import "JFReminderSwitchController.h"
#import "UIView+JFAddSeperator.h"

@interface JFReminderSwitchMainView : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) NSMutableArray *reminderSwitchViews;
@property (copy, nonatomic) dispatch_block_t confirmBlock;

@property (strong, nonatomic) CAShapeLayer *maskLayer;

- (void)addReminderSwitchViews:(JFReminderSwitchView *)reminderSwitchView;


@end

@implementation JFReminderSwitchMainView

+ (instancetype)reminderSwithMainViewWithTitle:(NSString *)title message:(NSString *)message
{
    JFReminderSwitchMainView *mainView = [[JFReminderSwitchMainView alloc] initWithFrame:CGRectZero];
    mainView.titleLabel.text = title;
    mainView.messageLabel.text = message;
    return mainView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *constraints = [NSMutableArray array];
        NSDictionary *views = nil;
        NSDictionary *metric = @{@"TitleHeight": @(21),
                                 @"ButtonHeight": @(34)};
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        _titleLabel.textColor = [UIColor colorWithRed:81.0/255 green:70.0/255 blue:71.0/255 alpha:1.0];
        [self addSubview:_titleLabel];
        
        views = NSDictionaryOfVariableBindings(self, _titleLabel);
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_titleLabel]|" options:0 metrics:nil views:views]];
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.font = [UIFont systemFontOfSize:14.f];
        _messageLabel.textColor = [UIColor colorWithRed:133.0/255 green:133.0/255 blue:133.0/255 alpha:1.0];
        _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_messageLabel];
        
        views = NSDictionaryOfVariableBindings(self, _messageLabel);
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_messageLabel]|" options:0 metrics:nil views:views]];

        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_containerView];
        
        views = NSDictionaryOfVariableBindings(self, _containerView);
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_containerView]|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
        
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_confirmButton setTitleColor:[UIColor colorWithRed:253.0/255 green:80.0/255 blue:86.0/255 alpha:1.0] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton addTarget:self
                           action:@selector(touchConfirmButton:)
                 forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_confirmButton];
        
        views = NSDictionaryOfVariableBindings(self, _confirmButton);
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_confirmButton]|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
        
        views = NSDictionaryOfVariableBindings(self, _titleLabel, _messageLabel, _containerView, _confirmButton);
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_titleLabel(TitleHeight)]-8-[_messageLabel]-8-[_containerView][_confirmButton(ButtonHeight)]-8-|" options:0 metrics:metric views:views]];
        
        [self addConstraints:constraints];
    }
    return self;
}

- (void)touchConfirmButton:(UIButton *)button
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!self.maskLayer) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:8.0];
        CAShapeLayer *shape = [CAShapeLayer layer];
        shape.path = bezierPath.CGPath;
        self.maskLayer = shape;
        self.layer.mask = shape;
    }
}

- (NSMutableArray *)reminderSwitchViews
{
    if (!_reminderSwitchViews) {
        _reminderSwitchViews = [[NSMutableArray alloc] init];
    }
    return _reminderSwitchViews;
}

- (void)addReminderSwitchViews:(JFReminderSwitchView *)reminderSwitchView
{
    if (![self.reminderSwitchViews count]) {
        [reminderSwitchView jf_addSeperatorToEdge:CGRectMinYEdge color:[UIColor lightGrayColor]];
    }
    
    [reminderSwitchView jf_addSeperatorToEdge:CGRectMaxYEdge color:[UIColor lightGrayColor]];
    
    [self.reminderSwitchViews addObject:reminderSwitchView];
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (UIView *view in self.reminderSwitchViews) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.containerView addSubview:view];
    }
    [self addConstraintsForViews:self.reminderSwitchViews containerView:self.containerView];
}

- (void)addConstraintsForViews:(NSArray *)views containerView:(UIView *)containerView
{
    for (int i = 0; i < views.count; i++) {
        UIView *view = views[i];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:containerView
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:0];
        
        NSLayoutConstraint *topConstraint;
        if (i == 0) {
            topConstraint = [NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:containerView
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:8];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:44];
            [containerView addConstraint:heightConstraint];
            
        } else {
            topConstraint = [NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:views[i-1]
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:1];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:views[0] attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
            [containerView addConstraint:heightConstraint];
        }
        
        NSLayoutConstraint *bottomConstraint;
        if (i == views.count - 1) {
            bottomConstraint = [NSLayoutConstraint constraintWithItem:view
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:containerView
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:-8];
        } else {
            bottomConstraint = [NSLayoutConstraint constraintWithItem:view
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:views[i+1]
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:-1];
        }
        
        [containerView addConstraints:@[topConstraint, bottomConstraint, leftConstraint, rightConstraint]];
    }
}

@end

@interface JFReminderSwitchController ()

@property (strong, nonatomic) JFReminderSwitchMainView *mainView;

@property (strong, nonatomic) NSMutableArray *reminderSwitchViews;

@end

@implementation JFReminderSwitchController

+ (instancetype)reminderSwitchControllerWithTitle:(NSString *)title message:(NSString *)message
{
    JFReminderSwitchController *controller = [[JFReminderSwitchController alloc] init];
    controller.mainView = [JFReminderSwitchMainView reminderSwithMainViewWithTitle:title
                                                                           message:message];
    __weak typeof(&*controller) weakController = controller;
    controller.mainView.confirmBlock = ^{
        [weakController willMoveToParentViewController:nil];
        [weakController.view removeFromSuperview];
        [weakController removeFromParentViewController];
//        [weakController dismissWithDuration:0.25];
    };
    
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.45];
    
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_mainView];
    
    NSMutableArray *constraints = [NSMutableArray array];

    float width = MIN(CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds));
    [constraints addObjectsFromArray:@[[NSLayoutConstraint constraintWithItem:_mainView
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1.0
                                                                     constant:0],
                                       [NSLayoutConstraint constraintWithItem:_mainView
                                                                    attribute:NSLayoutAttributeCenterX
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeCenterX
                                                                   multiplier:1.0
                                                                     constant:0],
                                       [NSLayoutConstraint constraintWithItem:_mainView
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:0
                                                                    attribute:NSLayoutAttributeWidth
                                                                   multiplier:1.0
                                                                     constant:width - 40]]];
    [self.view addConstraints:constraints];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self shakeOut:self.mainView duration:0.25];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self shakeOut:self.mainView duration:0.5];
}

- (void)shakeOut:(UIView *)view duration:(float)duration
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.keyTimes = @[@0, @0.68, @1.0];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)dismissWithDuration:(float)duration
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)addRemindSwitchView:(JFReminderSwitchView *)reminderSwitchView
{
    NSAssert([reminderSwitchView isKindOfClass:[JFReminderSwitchView class]], @"必须是JFReminderSwitchView");
    NSAssert(self.mainView, @"必须使用提供的实例化方法实例");
    
    [self.mainView addReminderSwitchViews:reminderSwitchView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches allObjects] lastObject];
    CGPoint location = [touch locationInView:self.view];
    UIView *hitView = [self.view hitTest:location withEvent:event];
    if (hitView && ([hitView isKindOfClass:[JFReminderSwitchMainView class]] || [hitView isKindOfClass:[JFReminderSwitchView class]])) {
    }
    else if (self.isOpenDismissWhenTouchBackground) {
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];

    }
}
@end
