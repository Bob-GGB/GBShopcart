//
//  GBShopcartBottomView.h
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartBotttomViewAllSelectBlock)(BOOL isSelected);
typedef void(^ShopcartBotttomViewSettleBlock)(void);
typedef void(^ShopcartBotttomViewStarBlock)(void);
typedef void(^ShopcartBotttomViewDeleteBlock)(void);

@interface GBShopcartBottomView : UIView

@property (nonatomic, copy) ShopcartBotttomViewAllSelectBlock shopcartBotttomViewAllSelectBlock;
@property (nonatomic, copy) ShopcartBotttomViewSettleBlock shopcartBotttomViewSettleBlock;
@property (nonatomic, copy) ShopcartBotttomViewStarBlock shopcartBotttomViewStarBlock;
@property (nonatomic, copy) ShopcartBotttomViewDeleteBlock shopcartBotttomViewDeleteBlock;

- (void)configureShopcartBottomViewWithTotalPrice:(float)totalPrice
                                       totalCount:(NSInteger)totalCount
                                    isAllselected:(BOOL)isAllSelected;

- (void)changeShopcartBottomViewWithStatus:(BOOL)status;

@end
