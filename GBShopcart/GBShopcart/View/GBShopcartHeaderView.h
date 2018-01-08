//
//  GBShopcartHeaderView.h
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartHeaderViewBlock)(BOOL isSelected);

@interface GBShopcartHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) ShopcartHeaderViewBlock shopcartHeaderViewBlock;    

- (void)configureShopcartHeaderViewWithBrandName:(NSString *)brandName
                                     brandSelect:(BOOL)brandSelect;

@end
