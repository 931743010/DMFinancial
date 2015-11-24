//
//  DMBarItem.m
//  DamaiHD
//
//  Created by lixiang on 13-10-21.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMBarItem.h"

@implementation DMBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    

}

@end
