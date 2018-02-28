//
//  SorinNavgationbar.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/26.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "SorinNavgationbar.h"

@implementation SorinNavgationbar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSorinNavigationBarUI];
    }
    return self;
}
- (void)layoutSubviews{
    self.leftView.frame = CGRectMake(0, kStatusBarHeight, self.leftView.sorin_width, self.leftView.sorin_height);
    self.rightView.frame = CGRectMake(KScreenWidth - self.rightView.sorin_width, kStatusBarHeight, self.rightView.sorin_width, self.rightView.sorin_height);
    self.titleView.frame = self.titleView.frame;
    self.titleView.center = CGPointMake(self.center.x, self.center.y + kStatusBarHeight / 2);
    self.bottomLine.frame = CGRectMake(0, self.sorin_height, self.sorin_width, 0.5);
}
#pragma mark set method
- (void)setLeftView:(UIView *)leftView{
    [_leftView removeFromSuperview];
    [self addSubview:leftView];
    _leftView = leftView;
    if ([leftView isKindOfClass:[UIButton class]]) {
        UIButton *left = (UIButton *)leftView;
        [left addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self layoutIfNeeded];
}
- (void)setRightView:(UIView *)rightView{
    [_rightView removeFromSuperview];
    [self addSubview:rightView];
    _rightView = rightView;
    if ([rightView isKindOfClass:[UIButton class]]) {
        UIButton *right = (UIButton *)rightView;
        [right addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self layoutIfNeeded];
}
- (void)setTitleView:(UIView *)titleView{
    [_titleView removeFromSuperview];
    [self addSubview:titleView];
    _titleView = titleView;
    __block BOOL haveTapGesture = NO;
    [titleView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            haveTapGesture = YES;
            *stop = YES;
        }
    }];
    if (!haveTapGesture) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTitle:)];
        [titleView addGestureRecognizer:tapGesture];
    }
    [self layoutIfNeeded];
}
- (void)setTitle:(NSMutableAttributedString *)title{
    if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarMiddleView:)]) {
        return;
    }
    UILabel *barTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.sorin_width * 0.5, 44)];
    barTitle.backgroundColor = [UIColor clearColor];
    barTitle.textAlignment = NSTextAlignmentCenter;
    barTitle.numberOfLines = 0;
    barTitle.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [barTitle setAttributedText:title];
    self.titleView = barTitle;
}
- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    self.layer.contents = (id)backgroundImage.CGImage;
}
#pragma mark get method
- (UIView *)bottomLine{
    if (!_bottomLine) {
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.sorin_height, self.sorin_width, 0.5)];
        [self addSubview:bottomLine];
        _bottomLine = bottomLine;
        bottomLine.backgroundColor = [UIColor redColor];
    }
    return _bottomLine;
}
#pragma mark dataSource
-(void)setupSorinNavigationBarUI{
    self.backgroundColor = [UIColor lightGrayColor];
}
- (void)setBarDataSource:(id<sorinNavigationbarDataSource>)barDataSource{
    _barDataSource = barDataSource;
    [self setDataSourceUI];
}
- (void)setDataSourceUI{
    if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarLeftView:)]) {
       self.leftView = [self.barDataSource sorinNavagationbarLeftView:self];
    }else if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarLeftBtn:navigationbar:)]){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [btn setImage:[self.barDataSource sorinNavagationbarLeftBtn:btn navigationbar:self] forState:UIControlStateNormal];
        self.leftView = btn;
    }
    if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarRightView:)]) {
        self.rightView = [self.barDataSource sorinNavagationbarRightView:self];
    }else if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarRightBtn:navigationbar:)]){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [btn setImage:[self.barDataSource sorinNavagationbarRightBtn:btn navigationbar:self] forState:UIControlStateNormal];
        self.rightView = btn;
    }
    if ([self.barDataSource respondsToSelector:@selector(sorinNavagationbarMiddleView:)]) {
        self.titleView = [self.barDataSource sorinNavagationbarMiddleView:self];
    }else if ([self.barDataSource respondsToSelector:@selector(sorinNavigationbarTitle:)]) {
        self.title = [self.barDataSource sorinNavigationbarTitle:self];
    }
    if ([self.barDataSource respondsToSelector:@selector(sorinNavigationbarHeight:)]) {
        self.sorin_height = [self.barDataSource sorinNavigationbarHeight:self];
    }else{
        self.sorin_height = kStatusBarHeight + 44;
    }
    if ([self.barDataSource respondsToSelector:@selector(isHiddenNavigationbarBottomline:)]) {
        self.bottomLine.hidden = [self.barDataSource isHiddenNavigationbarBottomline:self];
    }
    if ([self.barDataSource respondsToSelector:@selector(sorinNavigationbarBackgroundColor:)]) {
        self.backgroundColor = [self.barDataSource sorinNavigationbarBackgroundColor:self];
    }
    if ([self.barDataSource respondsToSelector:@selector(sorinNavigationbarBackgroundImage:)]) {
        self.backgroundImage = [self.barDataSource sorinNavigationbarBackgroundImage:self];
    }
}
#pragma mark delegate event
- (void)clickLeftBtn:(UIButton *)sender{
    if ([self.barDelegate respondsToSelector:@selector(leftClickEvent: navigationbar:)]) {
        [self.barDelegate leftClickEvent:sender navigationbar:self];
    }
}
- (void)clickRightBtn:(UIButton *)sender{
    if ([self.barDelegate respondsToSelector:@selector(rightClickEvent:navigationbar:)]) {
        [self.barDelegate rightClickEvent:sender navigationbar:self];
    }
}
- (void)clickTitle:(UITapGestureRecognizer *)tapGusture{
    UIButton *btn = (UIButton *)tapGusture.view;
    if ([self.barDelegate respondsToSelector:@selector(titleViewClickEvent:navigationbar:)]) {
        [self.barDelegate titleViewClickEvent:btn navigationbar:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
