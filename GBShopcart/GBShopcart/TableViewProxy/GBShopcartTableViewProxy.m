//
//  GBShopcartTableViewProxy.m
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import "GBShopcartTableViewProxy.h"
#import "GBShopcartBrandModel.h"
#import "GBShopcartCell.h"
#import "GBShopcartHeaderView.h"

@implementation GBShopcartTableViewProxy

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GBShopcartBrandModel *brandModel = self.dataArray[section];
    NSArray *productArray = brandModel.products;
    return productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"GBShopcartCell";
    // 通过indexPath创建cell实例 每一个cell都是单独的
    GBShopcartCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[GBShopcartCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
//    GBShopcartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GBShopcartCell"];
    GBShopcartBrandModel *brandModel = self.dataArray[indexPath.section];
    NSArray *productArray = brandModel.products;
    if (productArray.count > indexPath.row) {
        GBShopcartProductModel *productModel = productArray[indexPath.row];
        NSString *productName = [NSString stringWithFormat:@"%@%@%@", brandModel.brandName, productModel.productStyle, productModel.productType];
        [cell configureShopcartCellWithProductURL:productModel.productPicUri productName:productName  productPrice:productModel.productPrice productCount:productModel.productQty productStock:productModel.productStocks productSelected:productModel.isSelected];
    }
    
    __weak __typeof(self) weakSelf = self;
    cell.shopcartCellBlock = ^(BOOL isSelected){
        if (weakSelf.shopcartProxyProductSelectBlock) {
            weakSelf.shopcartProxyProductSelectBlock(isSelected, indexPath);
        }
    };
    
    cell.shopcartCellEditBlock = ^(NSInteger count){
        if (weakSelf.shopcartProxyChangeCountBlock) {
            weakSelf.shopcartProxyChangeCountBlock(count, indexPath);
        }
    };
    //进行议价
    cell.bargingBlock = ^(BOOL isSelected){
        if (weakSelf.shopcartProxyBargainingBlock) {
            weakSelf.shopcartProxyBargainingBlock(isSelected,indexPath);
        }
    };
    
    return cell;
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GBShopcartHeaderView *shopcartHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"GBShopcartHeaderView"];
    if (self.dataArray.count > section) {
        GBShopcartBrandModel *brandModel = self.dataArray[section];
        [shopcartHeaderView configureShopcartHeaderViewWithBrandName:brandModel.brandName brandSelect:brandModel.isSelected];
    }
    
    __weak __typeof(self) weakSelf = self;
    shopcartHeaderView.shopcartHeaderViewBlock = ^(BOOL isSelected){
        if (weakSelf.shopcartProxyBrandSelectBlock) {
            weakSelf.shopcartProxyBrandSelectBlock(isSelected, section);
        }
    };
    return shopcartHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.shopcartProxyDeleteBlock) {
            self.shopcartProxyDeleteBlock(indexPath);
        }
    }];
    
    UITableViewRowAction *starAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.shopcartProxyStarBlock) {
            self.shopcartProxyStarBlock(indexPath);
        }
    }];
    
    return @[deleteAction, starAction];
}

@end
