//
//  UIView+JFLayout.h
//  AddConstraints
//
//  Created by Joseph Fu on 15/3/12.
//  Copyright (c) 2015年 Joseph Fu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 轴
 */
typedef NS_ENUM(NSUInteger, JFAxis) {
    JFAxisHorizonal = 1,
    JFAxisVertical = 2
};

/**
 * 维度
 */
typedef NS_ENUM(NSUInteger, JFDimension) {
    JFDimensionWidth,   // 水平方向
    JFDimensionHeight     // 垂直方向
};

/**
 * 边缘
 */
typedef NS_ENUM(NSUInteger, JFEdge) {
    JFEdgeTop,          // 上边缘
    JFEdgeLeft,         // 左边缘
    JFEdgeBottom,       // 下边缘
    JFEdgeRight         // 右边缘
};

@interface UIView (JFLayout)

#pragma mark - 对齐

/**
 * 跟superview的x轴、y轴中心点对齐
 */
- (NSArray *)jf_alignCenterToSuperView;

/**
 * 跟superview的中心点以偏移量对齐
 */
- (NSArray *)jf_alignCenterToSuperViewWithOffset:(UIOffset)offset;


/**
 * 跟superview的某一轴中心对齐
 */
- (NSLayoutConstraint *)jf_alignAxisToSuperViewAxis:(JFAxis)axis;

/**
 * 跟superview的某一轴中心以偏移量对齐
 */
- (NSLayoutConstraint *)jf_alignAxisToSuperViewAxis:(JFAxis)axis withOffset:(CGFloat)offset;

/**
 * 跟其它view的x轴、y轴中心点对齐
 */
- (NSArray *)jf_alignBothAxisToView:(UIView *)otherView;

/**
 * 跟其它view的中心点以偏移量对齐
 */
- (NSArray *)jf_alignBothAxisToView:(UIView *)otherView offset:(UIOffset)offset;

/**
 * 跟其它view的某一轴中心对齐
 */
- (NSLayoutConstraint *)jf_alignAxis:(JFAxis)axis toSameAxisOfView:(UIView *)otherView;

/**
 * 跟其它view的某一轴中心偏移量对齐
 */
- (NSLayoutConstraint *)jf_alignAxis:(JFAxis)axis toSameAxisOfView:(UIView *)otherView withOffset:(CGFloat)offset;

/**
 * 跟其它view的某一轴中心以一定的比例对齐
 */
- (NSLayoutConstraint *)jf_alignAxis:(JFAxis)axis toSameAxisOfView:(UIView *)otherView withMultipier:(CGFloat)multipier;

/**
 * 跟其它view的某一轴中心以一定的比例、偏移量对齐
 */
- (NSLayoutConstraint *)jf_alignAxis:(JFAxis)axis toSameAxisOfView:(UIView *)otherView withMultipier:(CGFloat)multipier withOffset:(CGFloat)offset;

#pragma mark - 固定

/**
 * 对自身固定两个方向上的大小
 */
- (NSArray *)jf_pinDimensionsWithSize:(CGSize)size;

/**
 * 对自身固定某一方向上的大小
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension withSize:(CGFloat)size;

/**
 * 对自身固定某一方向上的大小及优先级
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension withSize:(CGFloat)size priority:(UILayoutPriority)priority;

/**
 * 对自身固定某一方向上的大小及关系
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension withSize:(CGFloat)size relation:(NSLayoutRelation)relation;

/**
 * 与另一个view的宽和高相同
 */
- (NSArray *)jf_pinDimensionsOfView:(UIView *)otherView;

/**
 * 在某一方向上，跟另一个view的大小相同
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toSameDemensionOfView:(UIView *)otherView;

/**
 * 自身某一方向与其它view某一方向上大小相等
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView;

/**
 * 自身某一方向与其它view某一方向上大小差距
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView difference:(CGFloat)difference;

/**
 * 自身某一方向与其它view某一方向上的比例
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier;

/**
 * 在某一方向上自身与另一个view的关系
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView relation:(NSLayoutRelation)relation;

/**
 * 在某一方向上自身与另一个view的比例及关系
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier relation:(NSLayoutRelation)relation;

/**
 * 在某一方向上自身与另一个view的比例及差距
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier withSize:(CGFloat)size;

/**
 * 在某一方向上自身与另一个view的比例、差距及优先级
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier withSize:(CGFloat)size priority:(UILayoutPriority)priority;

/**
 * 在某一方向上自身与另一个view的比例、差距及关系
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier withSize:(CGFloat)size relation:(NSLayoutRelation)relation;

/**
 * 在某一方向上自身与另一个view的比例、差距、关系及优先级
 */
- (NSLayoutConstraint *)jf_pinDimension:(JFDimension)dimension toDimension:(JFDimension)toDimension ofView:(UIView *)otherView withMultipier:(CGFloat)multipier withSize:(CGFloat)size relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority;

#pragma mark - Edges

/**
 * 与superview四边的距离
 */
- (NSArray *)jf_pinEdgesToSuperviewWithInsets:(UIEdgeInsets)insets;

/**
 * 除了某一边，与superview其它三边的距离
 */
- (NSArray *)jf_pinEdgesToSuperviewWithInsets:(UIEdgeInsets)insets exclude:(JFEdge)edge;

/**
 * 与superview某一边的距离
 */
- (NSLayoutConstraint *)jf_pinEdgeToSuperviewEdge:(JFEdge)edge withInset:(CGFloat)inset;

/**
 * 与superview某一边的距离及关系
 */
- (NSLayoutConstraint *)jf_pinEdgeToSuperviewEdge:(JFEdge)edge withInset:(CGFloat)inset relation:(NSLayoutRelation)relation;

/**
 * 与另一view四边的距离
 */
- (NSArray *)jf_pinEdgesToOtherView:(UIView *)otherView withInsets:(UIEdgeInsets)insets;

/**
 * 自身的某一边与另一view某一边挨着
 */
- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view;

/**
 * 自身的某一边与另一view某一边距离
 */
- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset;

/**
 * 自身的某一边与另一view某一边比例
 */
- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withMultipier:(CGFloat)multipier;

/**
 * 自身的某一边与另一view某一边比例、偏移
 */
- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withMultipier:(CGFloat)multipier withOffset:(CGFloat)offset;

/**
 * 自身的某一边与另一view某一边偏移以及优先级
 */
- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset priority:(UILayoutPriority)priority;

/**
 * 自身的某一边与另一view某一边距离及关系
 */
- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority;

/**
 * 自身的某一边与另一view某一边比例、距离及关系
 */
- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset withMultipier:(CGFloat)multipier relation:(NSLayoutRelation)relation;

- (NSLayoutConstraint *)jf_pinEdge:(JFEdge)edge toEdge:(JFEdge)toEdge ofView:(UIView *)view withOffset:(CGFloat)offset withMultipier:(CGFloat)multipier relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority;

#pragma mark - Layout Guider

#pragma mark - 创建constraint

- (NSLayoutConstraint *)jf_constraintAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)otherView;

- (NSLayoutConstraint *)jf_constraintAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)otherView withOffset:(CGFloat)offset;

- (NSLayoutConstraint *)jf_constraintAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)otherView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

- (NSLayoutConstraint *)jf_constraintAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)otherView withOffset:(CGFloat)offset withMultipier:(CGFloat)multipier relation:(NSLayoutRelation)relation;

- (NSLayoutConstraint *)jf_constraintAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)otherView withOffset:(CGFloat)offset withMultipier:(CGFloat)multipier relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority;

@end

@interface NSLayoutConstraint (JFLayout)

- (void)jf_install;

@end

@interface UIView (JFCommonSuperview)

- (UIView *)jf_commonSuperviewWithView:(UIView *)otherView;

@end