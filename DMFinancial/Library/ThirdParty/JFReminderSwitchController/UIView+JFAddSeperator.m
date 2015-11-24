//
//  UIView+JFAddSeperator.m
//  OpenReminderController
//
//  Created by Joseph Fu on 15/1/5.
//  Copyright (c) 2015年 Joseph Fu. All rights reserved.
//

#import "UIView+JFAddSeperator.h"

@implementation UIView (JFAddSeperator)

- (CGFloat)jf_hairlineWidth
{
    CGFloat scale = self.window ? self.window.screen.scale : UIScreen.mainScreen.scale;
    return 1 / scale;
}

- (UIView *)jf_addSeperatorToEdge:(CGRectEdge)edge color:(UIColor *)color paddingLeft:(CGFloat)left paddingRight:(CGFloat)right
{
    id constraintTarget = self;
    id oppositeLeadingItem = self;
    id oppositeTrailingItem = self;
    
    UIView *stripe = [[UIView alloc] initWithFrame:CGRectZero];
    stripe.backgroundColor = color;
    stripe.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:stripe];
    
    NSMutableArray *constraints = [NSMutableArray array];
    NSDictionary *views = NSDictionaryOfVariableBindings(stripe);
    NSDictionary *metrics = @{ @"length": @(self.jf_hairlineWidth)};
    switch (edge) {
        case CGRectMinXEdge:
        case CGRectMaxXEdge: {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:stripe attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:oppositeLeadingItem attribute:NSLayoutAttributeTop multiplier:1 constant:left]];
            [constraints addObject:[NSLayoutConstraint constraintWithItem:stripe attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:oppositeTrailingItem attribute:NSLayoutAttributeBottom multiplier:1 constant:-right]];
            if (edge == CGRectMinXEdge) {
                [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[stripe(length)]" options:0 metrics:metrics views:views]];
            } else {
                [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[stripe(length)]|" options:0 metrics:metrics views:views]];
            }
            [stripe setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [stripe setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
            break;
        }
        case CGRectMinYEdge:
        case CGRectMaxYEdge: {
            [constraints addObject:[NSLayoutConstraint constraintWithItem:stripe attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:oppositeLeadingItem attribute:NSLayoutAttributeLeading multiplier:1 constant:left]];
            [constraints addObject:[NSLayoutConstraint constraintWithItem:stripe attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:oppositeTrailingItem attribute:NSLayoutAttributeTrailing multiplier:1 constant:-right]];
            if (edge == CGRectMinYEdge) {
                [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[stripe(length)]" options:0 metrics:metrics views:views]];
            } else {
                [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[stripe(length)]|" options:0 metrics:metrics views:views]];
            }
            [stripe setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            [stripe setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
            break;
        }
    }
    [constraintTarget addConstraints:constraints];
    
    return stripe;
}

- (UIView *)jf_addSeperatorToEdge:(CGRectEdge)edge color:(UIColor *)color
{
    return [self jf_addSeperatorToEdge:edge color:color paddingLeft:0 paddingRight:0];
}

@end
