//
//  SorinTabbarController.h
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/26.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
//供外部调用 设置的参数
//tabbar标题
FOUNDATION_EXTERN NSString *const SorinTabbarItemTitle;
//tabbar图片
FOUNDATION_EXTERN NSString *const SorinTabbarItemImage;
//tabbar选中图片
FOUNDATION_EXTERN NSString *const SorinTabbarItemSelectImage;
@interface SorinTabbarController : UITabBarController
//子控制器数组
@property (nonatomic,copy) NSArray<NSDictionary *> *viewcontrollerInfo;

@end
