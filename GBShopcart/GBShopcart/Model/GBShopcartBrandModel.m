//
//  GBShopcartBrandModel.m
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import "GBShopcartBrandModel.h"

@implementation GBShopcartBrandModel

+ (NSDictionary *)objectClassInArray {
    return @{@"products":[GBShopcartProductModel class]};
}

@end
