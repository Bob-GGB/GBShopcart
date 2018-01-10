//
//  GBShopcartFormat.m
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import "GBShopcartFormat.h"
#import "GBShopcartBrandModel.h"
#import "MJExtension.h"
#import <UIKit/UIKit.h>

@interface GBShopcartFormat ()

@property (nonatomic, strong) NSMutableArray *shopcartListArray;    /**< 购物车数据源 */

@end

@implementation GBShopcartFormat

- (void)requestShopcartProductList {
    //在这里请求数据 当然我直接用本地数据模拟的
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shopcart" ofType:@"plist"];
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    self.shopcartListArray = [GBShopcartBrandModel mj_objectArrayWithKeyValuesArray:dataArray];
    
    //成功之后回调
    [self.delegate shopcartFormatRequestProductListDidSuccessWithArray:self.shopcartListArray];
}

- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected {
    GBShopcartBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    GBShopcartProductModel *productModel = brandModel.products[indexPath.row];
    productModel.isSelected = isSelected;
    
    BOOL isBrandSelected = YES;
    
    for (GBShopcartProductModel *aProductModel in brandModel.products) {
        if (aProductModel.isSelected == NO) {
            isBrandSelected = NO;
        }
    }
    
    brandModel.isSelected = isBrandSelected;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
    
//    NSLog(@"---%@---%@---%@",brandModel.brandName,productModel.productName,productModel.productStyle);
}

- (void)selectBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected {
    GBShopcartBrandModel *brandModel = self.shopcartListArray[section];
    brandModel.isSelected = isSelected;
    
    for (GBShopcartProductModel *aProductModel in brandModel.products) {
        aProductModel.isSelected = brandModel.isSelected;
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count {
    GBShopcartBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    GBShopcartProductModel *productModel = brandModel.products[indexPath.row];
    if (count <= 0) {
        count = 1;
    } else if (count > productModel.productStocks) {
        count = productModel.productStocks;
    }
    
    //根据请求结果决定是否改变数据
    productModel.productQty = count;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath {
    GBShopcartBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    GBShopcartProductModel *productModel = brandModel.products[indexPath.row];
    
    //根据请求结果决定是否删除
    [brandModel.products removeObject:productModel];
    if (brandModel.products.count == 0) {
        [self.shopcartListArray removeObject:brandModel];
    } else {
        if (!brandModel.isSelected) {
            BOOL isBrandSelected = YES;
            for (GBShopcartProductModel *aProductModel in brandModel.products) {
                if (!aProductModel.isSelected) {
                    isBrandSelected = NO;
                    break;
                }
            }
            
            if (isBrandSelected) {
                brandModel.isSelected = YES;
            }
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
    
    if (self.shopcartListArray.count == 0) {
        [self.delegate shopcartFormatHasDeleteAllProducts];
    }
}

- (void)beginToDeleteSelectedProducts {
    NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
    for (GBShopcartBrandModel *brandModel in self.shopcartListArray) {
        for (GBShopcartProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                [selectedArray addObject:productModel];
            }
        }
    }
    
    [self.delegate shopcartFormatWillDeleteSelectedProducts:selectedArray];
}

- (void)deleteSelectedProducts:(NSArray *)selectedArray {
    //网络请求
    //根据请求结果决定是否批量删除
    NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
    for (GBShopcartBrandModel *brandModel in self.shopcartListArray) {
        [brandModel.products removeObjectsInArray:selectedArray];
        
        if (brandModel.products.count == 0) {
            [emptyArray addObject:brandModel];
        }
    }
    
    if (emptyArray.count) {
        [self.shopcartListArray removeObjectsInArray:emptyArray];
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
    
    if (self.shopcartListArray.count == 0) {
        [self.delegate shopcartFormatHasDeleteAllProducts];
    }
}

- (void)starProductAtIndexPath:(NSIndexPath *)indexPath {
    //这里写收藏的网络请求
    
}

- (void)starSelectedProducts {
    //这里写批量收藏的网络请求
    
}

//选中商品进行议价
-(void)BargainingSelectedProductsAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected{
    GBShopcartBrandModel *brandModel = self.shopcartListArray[indexPath.section];
    GBShopcartProductModel *productModel = brandModel.products[indexPath.row];
    
    
    productModel.isSelected = isSelected;

    BOOL isBrandSelected = YES;
    
    for (GBShopcartProductModel *aProductModel in brandModel.products) {
        if (aProductModel.isSelected == NO) {
            isBrandSelected = NO;
        }
    }

//    NSLog(@"%@",productModel.isSelected ?@"YES":@"NO");
    brandModel.isSelected = isBrandSelected;
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
    
    NSLog(@"---%@---%@---%@",brandModel.brandName,productModel.productName,productModel.productStyle);
    
    
}

- (void)selectAllProductWithStatus:(BOOL)isSelected {
    for (GBShopcartBrandModel *brandModel in self.shopcartListArray) {
        brandModel.isSelected = isSelected;
        for (GBShopcartProductModel *productModel in brandModel.products) {
            productModel.isSelected = isSelected;
        }
    }
    
    [self.delegate shopcartFormatAccountForTotalPrice:[self accountTotalPrice] totalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}

- (void)settleSelectedProducts {
    NSMutableArray *settleArray = [[NSMutableArray alloc] init];
    for (GBShopcartBrandModel *brandModel in self.shopcartListArray) {
        NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
        for (GBShopcartProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
//                [selectedArray removeAllObjects];
                [selectedArray addObject:productModel];
            }
        }
    
        brandModel.selectedArray = selectedArray;
        
        if (selectedArray.count) {
            [settleArray addObject:brandModel];
        }
        
    }
    for (GBShopcartBrandModel *brandModel in settleArray) {
        
         NSLog(@"%@",brandModel.brandName);
        for (GBShopcartProductModel *productModel in brandModel.products) {
           NSLog(@"%@",productModel.brandName);
        }
    }
    
    [self.delegate shopcartFormatSettleForSelectedProducts:settleArray];
}

#pragma mark private methods

- (float)accountTotalPrice {
    float totalPrice = 0.f;
    for (GBShopcartBrandModel *brandModel in self.shopcartListArray) {
        for (GBShopcartProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                totalPrice += productModel.productPrice * productModel.productQty;
            }
        }
    }
    
    return totalPrice;
}

- (NSInteger)accountTotalCount {
    NSInteger totalCount = 0;
    
    for (GBShopcartBrandModel *brandModel in self.shopcartListArray) {
        for (GBShopcartProductModel *productModel in brandModel.products) {
            if (productModel.isSelected) {
                totalCount += productModel.productQty;
            }
        }
    }
    
    return totalCount;
}

- (BOOL)isAllSelected {
    if (self.shopcartListArray.count == 0) return NO;
    
    BOOL isAllSelected = YES;
    
    for (GBShopcartBrandModel *brandModel in self.shopcartListArray) {
        if (brandModel.isSelected == NO) {
            isAllSelected = NO;
        }
    }
    
    return isAllSelected;
}

@end
