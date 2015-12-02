//
//  DMBookkeepingCollectionView.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/2.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMBookkeepingItem : DMObject

@property (nonatomic, assign) NSUInteger itemId;
@property (nonatomic, strong) NSString *itemName;

@end

@interface DMBookkeepingCollectionView : UICollectionViewCell

@property (nonatomic, strong) DMBookkeepingItem *item;
@end

