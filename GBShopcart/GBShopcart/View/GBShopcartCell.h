//
//  GBShopcartCell.h
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartCellBlock)(BOOL isSelected);
typedef void(^ShopcartCellEditBlock)(NSInteger count);
typedef void(^BargingBlock)(BOOL isSelected);
@interface GBShopcartCell : UITableViewCell

@property (nonatomic, copy) ShopcartCellBlock shopcartCellBlock;
@property (nonatomic, copy) ShopcartCellEditBlock shopcartCellEditBlock;
@property (nonatomic,copy)  BargingBlock bargingBlock;


- (void)configureShopcartCellWithProductURL:(NSString *)productURL
                                productName:(NSString *)productName
                               productPrice:(NSInteger)productPrice
                               productCount:(NSInteger)productCount
                               productStock:(NSInteger)productStock
                            productSelected:(BOOL)productSelected;

@end
