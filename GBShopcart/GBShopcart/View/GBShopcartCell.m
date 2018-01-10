//
//  GBShopcartCell.m
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import "GBShopcartCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "GBShopcartCountView.h"
#import "ViewController.h"
@interface GBShopcartCell ()

@property (nonatomic, strong) UIButton *productSelectButton;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productNameLable;

@property (nonatomic, strong) UILabel *productPriceLable;
@property (nonatomic, strong) GBShopcartCountView *shopcartCountView;
@property (nonatomic, strong) UILabel *productStockLable;
@property (nonatomic, strong) UIView *shopcartBgView;
@property (nonatomic, strong) UIView *topLineView;

@end

@implementation GBShopcartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.shopcartBgView];
    [self.shopcartBgView addSubview:self.productSelectButton];
    [self.shopcartBgView addSubview:self.productImageView];
    [self.shopcartBgView addSubview:self.productNameLable];
    [self.shopcartBgView addSubview:self.productPriceLable];
    [self.shopcartBgView addSubview:self.shopcartCountView];
    [self.shopcartBgView addSubview:self.productStockLable];
    [self.shopcartBgView addSubview:self.topLineView];
    [self.shopcartBgView addSubview:self.BargainingButton];
}

- (void)configureShopcartCellWithProductURL:(NSString *)productURL productName:(NSString *)productName  productPrice:(NSInteger)productPrice productCount:(NSInteger)productCount productStock:(NSInteger)productStock productSelected:(BOOL)productSelected {
    NSURL *encodingURL = [NSURL URLWithString:[productURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self.productImageView sd_setImageWithURL:encodingURL];
    self.productNameLable.text = productName;
    self.productPriceLable.text = [NSString stringWithFormat:@"￥%ld", productPrice];
    self.productSelectButton.selected = productSelected;
    [self.shopcartCountView configureShopcartCountViewWithProductCount:productCount productStock:productStock];
    self.productStockLable.text = [NSString stringWithFormat:@"库存:%ld", productStock];
}

- (void)productSelectButtonAction {
    self.productSelectButton.selected = !self.productSelectButton.isSelected;
    if (self.shopcartCellBlock) {
        self.shopcartCellBlock(self.productSelectButton.selected);
    }
}

- (UIButton *)productSelectButton
{
    if(_productSelectButton == nil)
    {
        _productSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_productSelectButton setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_productSelectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_productSelectButton addTarget:self action:@selector(productSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productSelectButton;
}


-(void)bargainingButtonAction:(UIButton *)sender{
    
      self.BargainingButton.selected = !self.BargainingButton.isSelected;
    
    if (self.bargingBlock) {
        self.bargingBlock(self.BargainingButton.selected);
    }
    
}


- (UIButton *)BargainingButton
{
    if(_BargainingButton == nil)
    {
        _BargainingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_BargainingButton setTitle:@"进行议价" forState:UIControlStateNormal];
        [_BargainingButton setTitleColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1] forState:UIControlStateNormal];
        [_BargainingButton addTarget:self action:@selector(bargainingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _BargainingButton.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    return _BargainingButton;
}



- (UIImageView *)productImageView {
    if (_productImageView == nil){
        _productImageView = [[UIImageView alloc] init];
        _productImageView.backgroundColor=[UIColor redColor];
    }
    return _productImageView;
}

- (UILabel *)productNameLable {
    if (_productNameLable == nil){
        _productNameLable = [[UILabel alloc] init];
        _productNameLable.font = [UIFont systemFontOfSize:14];
        _productNameLable.numberOfLines=0;
        _productNameLable.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
    }
    return _productNameLable;
}

//- (UILabel *)productSizeLable {
//    if (_productSizeLable == nil){
//        _productSizeLable = [[UILabel alloc] init];
//        _productSizeLable.font = [UIFont systemFontOfSize:13];
//        _productSizeLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
//    }
//    return _productSizeLable;
//}

- (UILabel *)productPriceLable {
    if (_productPriceLable == nil){
        _productPriceLable = [[UILabel alloc] init];
        _productPriceLable.font = [UIFont systemFontOfSize:14];
        _productPriceLable.textColor = [UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1];
    }
    return _productPriceLable;
}

- (GBShopcartCountView *)shopcartCountView {
    if (_shopcartCountView == nil){
        _shopcartCountView = [[GBShopcartCountView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _shopcartCountView.shopcartCountViewEditBlock = ^(NSInteger count){
            if (weakSelf.shopcartCellEditBlock) {
                weakSelf.shopcartCellEditBlock(count);
            }
        };
    }
    return _shopcartCountView;
}

- (UILabel *)productStockLable {
    if (_productStockLable == nil){
        _productStockLable = [[UILabel alloc] init];
        _productStockLable.font = [UIFont systemFontOfSize:13];
        _productStockLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _productStockLable;
}

- (UIView *)shopcartBgView {
    if (_shopcartBgView == nil){
        _shopcartBgView = [[UIView alloc] init];
        _shopcartBgView.backgroundColor = [UIColor whiteColor];
    }
    return _shopcartBgView;
}

- (UIView *)topLineView {
    if (_topLineView == nil){
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _topLineView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.productSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(10);
        make.centerY.equalTo(self.shopcartBgView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.BargainingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productNameLable.mas_top);
        make.right.equalTo(@-15);
        make.size.mas_equalTo(CGSizeMake(90, 30));
    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(50);
        make.centerY.equalTo(self.shopcartBgView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.productNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.top.equalTo(self.shopcartBgView).offset(10);
        make.right.equalTo(self.shopcartCountView.mas_left);
    }];
    
//    [self.productSizeLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.productImageView.mas_right).offset(10);
//        make.top.equalTo(self.productNameLable.mas_bottom);
//        make.right.equalTo(self.shopcartBgView).offset(-5);
//        make.height.equalTo(@20);
//    }];
    [self.productStockLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.centerY.equalTo(self.shopcartBgView);
        make.right.equalTo(self.shopcartBgView).offset(-5);
        make.height.equalTo(@20);
    }];
    [self.productPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.bottom.equalTo(self.shopcartBgView).offset(-15);
        make.right.equalTo(self.shopcartBgView).offset(-5);
        make.height.equalTo(@20);
    }];
    
    [self.shopcartCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.bottom.equalTo(self.shopcartBgView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    
   
    
    [self.shopcartBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(50);
        make.top.right.equalTo(self.shopcartBgView);
        make.height.equalTo(@1);
    }];
}





@end





