//
//  MainTabbarController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/26.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MainTabbarController.h"

@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setControllerInfo];
    
    [self addChildController];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark 设置控制器信息
- (void)setControllerInfo{
    NSDictionary *mainInfoDic = @{SorinTabbarItemTitle:@"main",
                                  SorinTabbarItemImage:@"main",
                                  SorinTabbarItemSelectImage:@"main_click"};
    NSDictionary *musicInfoDic = @{SorinTabbarItemTitle:@"music",
                                  SorinTabbarItemImage:@"music",
                                  SorinTabbarItemSelectImage:@"music_click"};
    NSDictionary *newsInfoDic = @{SorinTabbarItemTitle:@"news",
                                  SorinTabbarItemImage:@"news",
                                  SorinTabbarItemSelectImage:@"news_click"};
    self.viewcontrollerInfo = @[mainInfoDic,musicInfoDic,newsInfoDic];
}
#pragma mark 添加子控制器
- (void)addChildController{
    SorinNavigationViewController *main = [[SorinNavigationViewController alloc] initWithRootViewController:[MainViewController new]];
   
    SorinNavigationViewController *music = [[SorinNavigationViewController alloc] initWithRootViewController:[MusicViewController new]];
   
    SorinNavigationViewController *news = [[SorinNavigationViewController alloc] initWithRootViewController:[NewsViewController new]];
    
    self.viewControllers = @[main,music,news];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
