//
//  UIView+JFLayout.m
//  AddConstraints
//
//  Created by Joseph Fu on 15/3/12.
//  Copyright (c) 2015年 Joseph Fu. All rights reserved.
//

#import "UIView+JFLayout.h"

@implementation UIView (JFLayout)


- (NSLayoutAttribute)jf_attributeForAxis:(JFAxis)axis
{
    NSLayoutAttribute attribute;
    switch (axis) {
        case JFAxisHorizonal:
            attribute = NSLayoutAttributeCenterX;
            break;
        case JFAxisVertical:
            attribute = NSLayoutAttributeCenterY;
            break;
        default:
            NSAssert(NO, @"参数错误");
            break;
    }
    return attribute;
}

- (NSLayoutAttribute)jf_attributeForDimension:(JFDimension)dimension
{
    NSLayoutAttribute attribute;
    switch (dimension) {
        case JFDimensionWidth:
            attribute = NSLayoutAttributeWidth;
            break;
        case JFDimensionHeight:
            attribute = NSLayoutAttributeHeight;
            break;
        default:
            NSAssert(NO, @"参数错误");
            break;
    }
    return attribute;
}

- (NSLayoutAttribute)jf_attributeForEdge:(JFEdge)edge
{
    NSLayoutAttribute attribute;
    switch (edge) {
        case JFEdgeTop:
            attribute = NSLayoutAttributeTop;
            break;
        case JFEdgeLeft:
            attribute = NSLayoutAttributeLeft;
            break;
        case JFEdgeBottom:
            attribute = NSLayoutAttributeBottom;
            break;
        case JFEdgeRight:
            attribute = NSLayoutAttributeRight;
            break;
        default:
            NSAssert(NO, @"参数错误");
            break;
    }
    return attribute;
}

#pragma mark - Align

- (NSArray *)jf_alignCenterToSuperView
{
    return [self jf_alignCenterToSuperViewWithOffset:UIOffsetZero];
}

- (NSArray *)jf_alignCenterToSuperViewWithOffset:(UIOffset)offset
{
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObject:[self jf_alignAxisToSuperViewAxis:JFAxisHorizonal withOffset:offset.horizontal]];
    [constraints addObject:[self jf_alignAxisToSuperViewAxis:JFAxisVertical withOffset:offset.vertical]];
    return constraints;
}

- (NSLayoutConstraint *)jf_alignAxisToSuperViewAxis:(JFAxis)axis
{
    return [self jf_alignAxisToSuperViewAxis:axis withOffset:0.];
}

- (NSLayoutConstraint *)jf_alignAxisToSuperViewAxis:(JFAxis)axis withOffset:(CGFloat)offset
{
    NSAssert(self.superview, @"该view没有添加到superview");
    return [self jf_alignAxis:axis toSameAxisOfView:self.superview withOffset:offset];
}

- (NSArray *)jf_alignBothAxisToView:(UIView *)otherView
{
    return [self jf_alignBothAxisToView:otherView offset:UIOffsetZero];
}

- (NSArray *)jf_alignBothAxisToView:(UIView *)otherView offset:(UIOffset)offset
{
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObject:[self jf_alignAxis:JFAxisHorizonal toSameAxisOfView:otherView withOffset:offset.horizontal]];
    [constraints addObject:[self jf_alignAxis:JFAxisVertical toSameAxisOfView:otherView withOffset:offset.vertical]];
    return constraints;
}

- (NSLayoutConstraint *)jf_alignAxis:(JFAxis)axis toSameAxisOfView:(UIView *)otherView
{
    return [self jf_alignAxis:axis toSameAxisOfView:otherView withOffset:0.0];
}

- (NSLayoutConstraint *)jf_alignAxis:(JFAxis)axis toSameAxisOfView:(UIView *)otherView withOffset:(CGFloat)offset
{
    return [self jf_alignAxis:axis toSameAxisOfView:otherView withMultipier:1.0 withOffset:offset];
}

- (NSLayoutConstraint *)jf_alignAxis:(JFAxis)axis toSameAxisOfView:(UIView *)otherView withMultipier:(CGFloat)multipier
{
    return [self jf_alignAxis:axis toSameAxisOfView:otherView withMultipier:multipier withOffset:0];
}

- (NSLayoutConstraint *)jf_alignAxis:(JFAxis)axis toSameAxisOfView:(UIView *)otherView withMultipier:(CGFloat)multipier withOffset:(CGFloat)offset
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutAttribute atttibute = [self jf_attributeForAxis:axis];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:atttibute relatedBy:NSLayoutRelationEqual toItem:otherView attribute:atttibute multiplier:multipier constant:offset];
    [constraint jf_install];
    return constraint;
}

#pragma mark - Pin

- (NSArray *)jf_pinDimensionsWithSize:(CGSize)size
{
    NSMutableArray *constraints = [NSMutableArray new];
    [constraints addObject:[self jf_pinDimension:JFDimensionWidth withSize:size.width]];
    [constraints addObject:[self jf_pinDimension:JFDimensionHeight withSize:size.height]];
    return constraints;
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension withSize:(CGFloat)size
{
    return  [self jf_pinDimension:dimension toDimension:dimension ofView:nil withMultipier:1.0 withSize:size];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension withSize:(CGFloat)size priority:(UILayoutPriority)priority
{
    return [self jf_pinDimension:dimension toDimension:dimension ofView:nil withMultipier:1.0 withSize:size priority:priority];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension withSize:(CGFloat)size relation:(NSLayoutRelation)relation
{
    return [self jf_pinDimension:dimension toDimension:dimension ofView:nil withMultipier:1.0 withSize:size relation:relation];
}

- (NSArray *)jf_pinDimensionsOfView:(UIView *)otherView
{
    NSMutableArray *constraints = [NSMutableArray new];
    [constraints addObject:[self jf_pinDimension:JFDimensionWidth toSameDemensionOfView:otherView]];
    [constraints addObject:[self jf_pinDimension:JFDimensionHeight toSameDemensionOfView:otherView]];
    return constraints;
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toSameDemensionOfView:(UIView *)otherView
{
    return [self jf_pinDimension:dimension toDimension:dimension ofView:otherView withMultipier:1.0];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView
{
    return [self jf_pinDimension:dimension toDimension:toDimension ofView:otherView difference:0];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView difference:(CGFloat)difference;
{
    return [self jf_pinDimension:dimension toDimension:toDimension ofView:otherView withMultipier:1.0 withSize:difference];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView relation:(NSLayoutRelation)relation
{
    return [self jf_pinDimension:dimension toDimension:toDimension ofView:otherView withMultipier:1.0 relation:relation];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier
{
    return [self jf_pinDimension:dimension toDimension:toDimension ofView:otherView withMultipier:multipier withSize:0];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier relation:(NSLayoutRelation)relation
{
   return [self jf_pinDimension:dimension toDimension:toDimension ofView:otherView withMultipier:multipier withSize:0.0 relation:relation];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier withSize:(CGFloat)size
{
    return [self jf_pinDimension:dimension toDimension:toDimension ofView:otherView withMultipier:multipier withSize:size priority:UILayoutPriorityRequired];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier withSize:(CGFloat)size priority:(UILayoutPriority)priority
{
    return [self jf_pinDimension:dimension toDimension:toDimension ofView:otherView withMultipier:multipier withSize:size relation:NSLayoutRelationEqual priority:priority];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier withSize:(CGFloat)size relation:(NSLayoutRelation)relation
{
    return [self jf_pinDimension:dimension toDimension:toDimension ofView:otherView withMultipier:multipier withSize:size relation:relation priority:UILayoutPriorityRequired];
}

- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier withSize:(CGFloat)size relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority

{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutAttribute attribute = [self jf_attributeForDimension:dimension];
    NSLayoutAttribute toAttribute = NSLayoutAttributeNotAnAttribute;
    if (otherView) {
        toAttribute = [self jf_attributeForDimension:toDimension];;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:relation toItem:otherView attribute:toAttribute multiplier:multipier constant:size];
    constraint.priority = priority;
    [constraint jf_install];
    return constraint;
}

- (NSArray *)jf_pinEdgesToSuperviewWithInsets:(UIEdgeInsets)insets
{
    UIView *superview = self.superview;
    NSAssert(superview, @"该view的superview不应该为nil");
    return [self jf_pinEdgesToOtherView:superview withInsets:insets];
}

- (NSArray *)jf_pinEdgesToSuperviewWithInsets:(UIEdgeInsets)insets exclude:(JFEdge)edge
{
    NSMutableArray *constraints = [NSMutableArray new];
    if (edge != JFEdgeTop) {
        [constraints addObject:[self jf_pinEdgeToSuperviewEdge:JFEdgeTop withInset:insets.top]];
    }
    
    if (edge != JFEdgeLeft) {
        [constraints addObject:[self jf_pinEdgeToSuperviewEdge:JFEdgeLeft withInset:insets.left]];
    }
    
    if (edge != JFEdgeBottom) {
        [constraints addObject:[self jf_pinEdgeToSuperviewEdge:JFEdgeBottom withInset:insets.bottom]];
    }
    
    if (edge != JFEdgeRight) {
        [constraints addObject:[self jf_pinEdgeToSuperviewEdge:JFEdgeRight withInset:insets.right]];
    }
    
    return constraints;
}

- (NSLayoutConstraint *)jf_pinEdgeToSuperviewEdge:(JFEdge)edge withInset:(CGFloat)inset
{
    return [self jf_pinEdgeToSuperviewEdge:edge withInset:inset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)jf_pinEdgeToSuperviewEdge:(JFEdge)edge withInset:(CGFloat)inset relation:(NSLayoutRelation)relation
{
    UIView *superview = self.superview;
    NSAssert(superview, @"该view的superview不应该为nil");
    if (edge == JFEdgeRight || edge == JFEdgeBottom) {
        inset = -inset;
        if (relation == NSLayoutRelationGreaterThanOrEqual) {
            relation = NSLayoutRelationLessThanOrEqual;
        }
        else if (relation == NSLayoutRelationLessThanOrEqual) {
            relation = NSLayoutRelationGreaterThanOrEqual;
        }
    }
    return [self jf_pinEdge:edge toEdge:edge ofView:superview withOffset:inset relation:relation];
}

- (NSArray *)jf_pinEdgesToOtherView:(UIView *)otherView withInsets:(UIEdgeInsets)insets
{
    NSMutableArray *constraints = [NSMutableArray new];
    [constraints addObject:[self jf_pinEdge:JFEdgeTop toEdge:JFEdgeTop ofView:otherView withOffset:insets.top]];
    [constraints addObject:[self jf_pinEdge:JFEdgeLeft toEdge:JFEdgeLeft ofView:otherView withOffset:insets.left]];
    [constraints addObject:[self jf_pinEdge:JFEdgeBottom toEdge:JFEdgeBottom ofView:otherView withOffset:-insets.bottom]];
    [constraints addObject:[self jf_pinEdge:JFEdgeRight toEdge:JFEdgeRight ofView:otherView withOffset:-insets.right]];
    return constraints;
}


- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view
{
    return [self jf_pinEdge:edge toEdge:toEdge ofView:view withOffset:.0];
}

- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset
{
    return [self jf_pinEdge:edge toEdge:toEdge ofView:view withMultipier:1.0 withOffset:offset];
}

- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withMultipier:(CGFloat)multipier
{
    return [self jf_pinEdge:edge toEdge:toEdge ofView:view withMultipier:multipier withOffset:0];
}

- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withMultipier:(CGFloat)multipier withOffset:(CGFloat)offset
{
    return [self jf_pinEdge:edge toEdge:toEdge ofView:view withOffset:offset withMultipier:multipier relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset priority:(UILayoutPriority)priority
{
    return [self jf_pinEdge:edge toEdge:toEdge ofView:view withOffset:offset relation:NSLayoutRelationEqual priority:priority];
}

- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self jf_pinEdge:edge toEdge:toEdge ofView:view withOffset:offset withMultipier:1.0 relation:relation];
}

- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority
{
    return [self jf_pinEdge:edge toEdge:toEdge ofView:view withOffset:offset withMultipier:1.0 relation:relation priority:priority];
}

- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset withMultipier:(CGFloat)multipier relation:(NSLayoutRelation)relation
{
    return [self jf_pinEdge:edge toEdge:toEdge ofView:view withOffset:offset withMultipier:1.0 relation:relation priority:UILayoutPriorityRequired];
}

- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset withMultipier:(CGFloat)multipier relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority
{
    NSLayoutAttribute attribute = [self jf_attributeForEdge:edge];
    NSLayoutAttribute toAttribute = [self jf_attributeForEdge:toEdge];
    
    return [self jf_constraintAttribute:attribute toAttribute:toAttribute ofView:view withOffset:offset withMultipier:multipier relation:relation priority:priority];
}

#pragma mark - Create

- (NSLayoutConstraint *)jf_constraintAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)otherView
{
    return [self jf_constraintAttribute:attribute toAttribute:toAttribute ofView:otherView withOffset:0.];
}

- (NSLayoutConstraint *)jf_constraintAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)otherView withOffset:(CGFloat)offset
{
    return [self jf_constraintAttribute:attribute toAttribute:toAttribute ofView:otherView withOffset:offset relation:NSLayoutRelationEqual];
}

- (NSLayoutConstraint *)jf_constraintAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)otherView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation
{
    return [self jf_constraintAttribute:attribute toAttribute:toAttribute ofView:otherView withOffset:offset withMultipier:1.0 relation:relation];
}

- (NSLayoutConstraint *)jf_constraintAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)otherView withOffset:(CGFloat)offset withMultipier:(CGFloat)multipier relation:(NSLayoutRelation)relation
{
    return [self jf_constraintAttribute:attribute toAttribute:toAttribute ofView:otherView withOffset:offset withMultipier:1.0 relation:relation priority:UILayoutPriorityRequired];
}

- (NSLayoutConstraint *)jf_constraintAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)otherView withOffset:(CGFloat)offset withMultipier:(CGFloat)multipier relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:relation toItem:otherView attribute:toAttribute multiplier:multipier constant:offset];
    constraint.priority = priority;
    [constraint jf_install];
    return constraint;
}
@end

@implementation NSLayoutConstraint (JFLayout)

- (void)jf_install
{
//    if (self.isActive) {
//        return;
//    }
    NSAssert(self.firstItem || self.secondItem, @"不能安装，因为它的firstItem和secondItme都为nil");
    if (self.firstItem) {
        if (self.secondItem) {
            UIView *commonSuperview = [self.firstItem jf_commonSuperviewWithView:self.secondItem];
            [commonSuperview addConstraint:self];
        } else {

            [self.firstItem addConstraint:self];
        }
    } else {
        [self.secondItem addConstraint:self];
    }
}

@end

@implementation UIView (JFCommonSuperview)

- (UIView *)jf_commonSuperviewWithView:(UIView *)otherView
{
    UIView *commonSuperview = nil;
    UIView *startView = self;
    do {
        if ([otherView isDescendantOfView:startView]) {
            commonSuperview = startView;
        }
        startView = startView.superview;
    } while (startView && !commonSuperview);
    
    return commonSuperview;
}

@end
