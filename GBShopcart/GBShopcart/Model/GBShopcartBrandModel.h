//
//  GBShopcartBrandModel.h
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBShopcartProductModel.h"

@interface GBShopcartBrandModel : NSObject

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, strong) NSMutableArray<GBShopcartProductModel *> *products;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, assign)BOOL isSelected; //记录相应section是否全选（自定义）

@property (nonatomic, strong) NSMutableArray *selectedArray;    //结算时筛选出选中的商品（自定义）

@end
