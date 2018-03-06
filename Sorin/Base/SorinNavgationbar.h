//
//  SorinNavgationbar.h
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/26.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SorinNavgationbar;
//导航栏代理协议声明
@protocol sorinNavigationbarDelegate<NSObject>
@optional
//导航栏左边按钮点击代理事件
- (void)leftClickEvent:(UIButton *)eventBtn navigationbar:(SorinNavgationbar *)navigationbar;
//导航栏右边按钮点击代理事件
- (void)rightClickEvent:(UIButton *)eventBtn navigationbar:(SorinNavgationbar *)navigationbar;
//导航栏标题视图的点击代理事件
- (void)titleViewClickEvent:(UIButton *)eventBtn navigationbar:(SorinNavgationbar *)navigationbar;
@end

@protocol sorinNavigationbarDataSource<NSObject>
@optional
//导航栏左边视图的代理设置
- (UIView *)sorinNavagationbarLeftView:(SorinNavgationbar *)navigationBar;
//导航栏右边视图的代理设置
- (UIView *)sorinNavagationbarRightView:(SorinNavgationbar *)navigationBar;
//导航栏左边按钮的代理设置
- (UIImage *)sorinNavagationbarLeftBtn:(UIButton *)leftBtn navigationbar:(SorinNavgationbar *)navigationBar;
//导航栏右边按钮的代理设置
- (UIImage *)sorinNavagationbarRightBtn:(UIButton *)rightBtn navigationbar:(SorinNavgationbar *)navigationBar;
//导航栏中间视图的代理设置
- (UIView *)sorinNavagationbarMiddleView:(SorinNavgationbar *)navigationBar;
//是否隐藏导航栏底部线条
- (BOOL)isHiddenNavigationbarBottomline:(SorinNavgationbar *)navigationBar;
//导航栏背景色
- (UIColor *)sorinNavigationbarBackgroundColor:(SorinNavgationbar *)navigationBar;
//导航栏背景图片
- (UIImage *)sorinNavigationbarBackgroundImage:(SorinNavgationbar *)navigationBar;
//导航栏高度
- (CGFloat)sorinNavigationbarHeight:(SorinNavgationbar *)navigationBar;
//导航栏标题
- (NSMutableAttributedString*)sorinNavigationbarTitle:(SorinNavgationbar *)navigationBar;

@end
@interface SorinNavgationbar : UIView
//导航栏左边视图
@property (nonatomic,weak) UIView *leftView;
//导航栏右边视图
@property (nonatomic,weak) UIView *rightView;
//导航栏标题视图
@property (nonatomic,weak) UIView *titleView;
//导航栏背景图
@property (nonatomic,weak) UIImage *backgroundImage;
//导航栏分割线
@property (nonatomic,weak) UIView *bottomLine;
//导航栏标题
@property (nonatomic,copy) NSMutableAttributedString *title;
//导航栏代理
@property (nonatomic,weak) id<sorinNavigationbarDelegate> barDelegate;
//导航栏数据代理
@property (nonatomic,weak) id<sorinNavigationbarDataSource> barDataSource;

@end
