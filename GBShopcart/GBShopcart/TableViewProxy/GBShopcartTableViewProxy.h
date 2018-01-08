//
//  GBShopcartTableViewProxy.h
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^ShopcartProxyProductSelectBlock)(BOOL isSelected, NSIndexPath *indexPath);
typedef void(^ShopcartProxyBrandSelectBlock)(BOOL isSelected, NSInteger section);
typedef void(^ShopcartProxyChangeCountBlock)(NSInteger count, NSIndexPath *indexPath);
typedef void(^ShopcartProxyDeleteBlock)(NSIndexPath *indexPath);
typedef void(^ShopcartProxyStarBlock)(NSIndexPath *indexPath);
typedef void(^ShopcartProxyBargainingBlock)(BOOL isSelected,NSIndexPath *indexPath);//进行议价

@interface GBShopcartTableViewProxy : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) ShopcartProxyProductSelectBlock shopcartProxyProductSelectBlock;
@property (nonatomic, copy) ShopcartProxyBrandSelectBlock shopcartProxyBrandSelectBlock;
@property (nonatomic, copy) ShopcartProxyChangeCountBlock shopcartProxyChangeCountBlock;
@property (nonatomic, copy) ShopcartProxyDeleteBlock shopcartProxyDeleteBlock;
@property (nonatomic, copy) ShopcartProxyStarBlock shopcartProxyStarBlock;
@property (nonatomic,copy) ShopcartProxyBargainingBlock  shopcartProxyBargainingBlock;



@end
