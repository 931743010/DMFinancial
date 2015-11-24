//
//  DMSelectorButton.m
//  DamaiIphone
//
//  Created by lixiang on 13-12-30.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMSelectorButton.h"

#define kSelectedColor RGBA(255, 255, 255, 1)
#define kDefaultColor RGBA(218, 210, 208, 1)

@implementation DMSelectorButton

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"selected"];
}

- (id)init {
    self = [super init];
    if (self) {
        [self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew
                  context:NULL];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (self.selected) {
            self.layer.borderColor = kDMPinkColor.CGColor;
            self.backgroundColor = kDMPinkColor;
        } else {
            self.layer.borderColor = kDefaultColor.CGColor;
            self.backgroundColor = [UIColor whiteColor];
        }
        [self.titleLabel setFont:BOLDFONT(12)];
        [self setTitleColor:[UIColor colorWithHexString:@"514647"] forState:UIControlStateNormal];
        [self setTitleColor:kSelectedColor forState:UIControlStateSelected];
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew
                  context:NULL];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = kDefaultColor.CGColor;
        self.layer.cornerRadius = 4.5;

    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selected"]) {
        BOOL selected = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (selected) {
            self.backgroundColor = kDMPinkColor;
            self.layer.borderColor = kDMPinkColor.CGColor;
        } else {
            self.backgroundColor = [UIColor whiteColor];
            self.layer.borderColor = kDefaultColor.CGColor;
        }
    }
}

@end
