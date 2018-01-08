//
//  GBShopcartCountView.h
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartCountViewEditBlock)(NSInteger count);

@interface GBShopcartCountView : UIView

@property (nonatomic, copy) ShopcartCountViewEditBlock shopcartCountViewEditBlock;

- (void)configureShopcartCountViewWithProductCount:(NSInteger)productCount
                                      productStock:(NSInteger)productStock;

@end
