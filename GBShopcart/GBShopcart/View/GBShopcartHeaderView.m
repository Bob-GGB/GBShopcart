//
//  GBShopcartHeaderView.m
//  GBShopcart
//
//  Created by GGBShopCar on 18/1/03.
//  Copyright © 2018年 GGBShopCar. All rights reserved.
//

#import "GBShopcartHeaderView.h"
#import "Masonry.h"

@interface GBShopcartHeaderView ()

@property (nonatomic, strong) UIView *shopcartHeaderBgView;
@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UILabel *brandLable;

@end

@implementation GBShopcartHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.shopcartHeaderBgView];
    [self.shopcartHeaderBgView addSubview:self.allSelectButton];
    [self.shopcartHeaderBgView addSubview:self.brandLable];
}

- (void)configureShopcartHeaderViewWithBrandName:(NSString *)brandName brandSelect:(BOOL)brandSelect {
    self.allSelectButton.selected = brandSelect;
    self.brandLable.text = brandName;
}

- (void)allSelectButtonAction {
    self.allSelectButton.selected = !self.allSelectButton.isSelected;
    
    if (self.shopcartHeaderViewBlock) {
        self.shopcartHeaderViewBlock(self.allSelectButton.selected);
    }
}

- (UIView *)shopcartHeaderBgView {
    if (_shopcartHeaderBgView == nil){
        _shopcartHeaderBgView = [[UIView alloc] init];
        _shopcartHeaderBgView.backgroundColor = [UIColor whiteColor];
    }
    return _shopcartHeaderBgView;
}

- (UIButton *)allSelectButton {
    if (_allSelectButton == nil){
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_allSelectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_allSelectButton addTarget:self action:@selector(allSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectButton;
}

- (UILabel *)brandLable {
    if (_brandLable == nil){
        _brandLable = [[UILabel alloc] init];
        _brandLable.font = [UIFont systemFontOfSize:14];
        _brandLable.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
    }
    return _brandLable;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.shopcartHeaderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartHeaderBgView).offset(10);
        make.centerY.equalTo(self.shopcartHeaderBgView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.brandLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartHeaderBgView).offset(50);
        make.top.bottom.equalTo(self.shopcartHeaderBgView);
    }];
}

@end
