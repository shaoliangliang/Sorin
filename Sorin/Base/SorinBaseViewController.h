//
//  SorinBaseViewController.h
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/25.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SorinNavgationbar.h"
@interface SorinBaseViewController : UIViewController<sorinNavigationbarDelegate,sorinNavigationbarDataSource>
//自定义的导航栏
@property (nonatomic,weak) SorinNavgationbar *sorinNavigationbar;

@end
