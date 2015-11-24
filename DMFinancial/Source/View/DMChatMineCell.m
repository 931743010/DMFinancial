//
//  DMChatMineCell.m
//  DamaiPlayPhone
//
//  Created by 付书炯 on 15/5/21.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMChatMineCell.h"
#import "DMChatDateTransformer.h"

@interface DMChatMineCell ()
{
    CGFloat _height;
}

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UIView *containTimeView;

@end
@implementation DMChatMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    
    UIView *containerView = self.contentView;
    
    _containTimeView = UIView.new;
    _containTimeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    _containTimeView.layer.borderColor = [UIColor clearColor].CGColor;
    _containTimeView.layer.borderWidth = 0.5;
    _containTimeView.layer.cornerRadius = 10;
    _containTimeView.layer.masksToBounds = YES;
    [containerView addSubview:_containTimeView];
    
    _timeLabel = UILabel.new;
    _timeLabel.font = FONT(12);
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [_containTimeView addSubview:_timeLabel];
    
    _timeLabel.frame = CGRectMake(0, 8, kScreenWidth, 12);
    
    _avatarImageView = [[UIImageView alloc] init];
    [containerView addSubview:_avatarImageView];
    _avatarImageView.frame = CGRectMake(kScreenWidth - 42 - 8 * 2, 8+12, 28, 28);
    
    _userNameLabel = UILabel.new;
    _userNameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _userNameLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _userNameLabel.font = [UIFont boldSystemFontOfSize:12];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    [containerView addSubview:_userNameLabel];
    
    _contentImageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"chat_pinglunkuang_red"];
    _contentImageView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 10)];
    [containerView addSubview:_contentImageView];
    
    _messageLabel = UILabel.new;
    _messageLabel.font = FONT(15);
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.numberOfLines = 0;
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [containerView addSubview:_messageLabel];
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _dateFormatter = dateFormatter;
    }
    return _dateFormatter;
}


- (void)blindModel:(DMRecords *)item loadImage:(BOOL)load previousDate:(NSDate *)previousDate
{
    if (load) {
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item.userImg] placeholderImage:[UIImage imageWithResourcesPathCompontent:@"detail_touxiang.png"]];
    }
    
    NSString *message = item.content;
    self.messageLabel.text = message;
    CGSize size = CGSizeMake(kScreenWidth - (7 + 36 + 14) * 2 - 5 - 13 * 2, MAXFLOAT);
    CGRect rect = [message boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.messageLabel.font} context:nil];
    
    
    BOOL hiddenTimeLabel = NO;

    
    // 判断是否需要隐藏时间
    // 创建时间
    NSDate *createTime = [self.dateFormatter dateFromString:item.createTime];
    if (previousDate) {
        // 距离上次创建的间隔
        NSTimeInterval timeInterval = [createTime timeIntervalSinceDate:previousDate];
        // 超过了60秒
        if (fabs(timeInterval) < 60) {
            hiddenTimeLabel = YES;
        }
    }
    
    DMChatDateTransformer *transformer = (DMChatDateTransformer *)[NSValueTransformer valueTransformerForName:DMChatDateTransformerName];
    self.timeLabel.text = [transformer transformedValue:createTime];
//    self.timeLabel.hidden = hiddenTimeLabel;
    self.containTimeView.hidden = hiddenTimeLabel;
    [self.timeLabel sizeToFit];
    CGFloat marginTop = hiddenTimeLabel? 15: 16+20+16;
    
    if (!hiddenTimeLabel) {
        CGRect frame = self.containTimeView.frame;
        frame.size.width = self.timeLabel.size.width + 30;
        frame.size.height = 20;
        frame.origin.x = floor((kScreenWidth - frame.size.width) / 2.0);
        frame.origin.y = 16;
        
        CGPoint point = CGPointMake(15, floor((20 - self.timeLabel.size.height) / 2.0));
        CGRect timeLabelFrame = self.timeLabel.frame;
        timeLabelFrame.origin = point;
        self.timeLabel.frame = timeLabelFrame;
        
        self.containTimeView.frame = frame;
    }
    
    self.avatarImageView.frame = CGRectMake(kScreenWidth - 36 - 14, marginTop, 36, 36);
    self.userNameLabel.text = item.userName;
    [self.userNameLabel sizeToFit];
    self.userNameLabel.frame = CGRectMake(kScreenWidth - 36 - 14 - 7 - 5 - self.userNameLabel.size.width, marginTop, self.userNameLabel.size.width, self.userNameLabel.size.height);
    self.contentImageView.frame = CGRectMake(kScreenWidth - (ceil(rect.size.width) + 13 * 2) - 36 - 14 - 7 - 5, marginTop + self.userNameLabel.size.height + 6, ceil(rect.size.width) + 13 * 2 + 5, ceil(rect.size.height) + 11 * 2);
    self.messageLabel.frame = CGRectMake(kScreenWidth - (ceil(rect.size.width) + 13 * 2) - 36 - 14 - 7 - 5 + 13, marginTop + 11 + self.userNameLabel.size.height + 6, ceil(rect.size.width), ceil(rect.size.height));
    
    
    _height = marginTop + MAX(42, ceil(rect.size.height ) + 12 * 2 + self.userNameLabel.size.height + 6);
}

- (CGFloat)height
{
    return _height;
}

@end
