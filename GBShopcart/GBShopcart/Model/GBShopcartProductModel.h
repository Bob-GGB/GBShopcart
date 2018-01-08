//
//  GBShopcartProductModel.h
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBShopcartProductModel : NSObject

@property (nonatomic, assign) NSInteger specWidth;      //宽

@property (nonatomic, assign) NSInteger specHeight;     //高

@property (nonatomic, assign) NSInteger specLength;     //长

@property (nonatomic, copy) NSString *productStyle;

@property (nonatomic, copy) NSString *brandPicUri;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *productType;

@property (nonatomic, copy) NSString *brandName;   //品牌名

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, assign) NSInteger productStocks;      //库存

@property (nonatomic, copy) NSString *productNum;

@property (nonatomic, copy) NSString *cartId;

@property (nonatomic, assign) NSInteger productQty;         //商品数

@property (nonatomic, assign) NSInteger originPrice;

@property (nonatomic, assign) NSInteger productPrice;       //价格

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *productPicUri;   //图片url

@property(nonatomic, assign)BOOL isSelected;    //记录相应row是否选中（自定义）

@end
