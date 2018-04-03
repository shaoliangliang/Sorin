//
//  SorinBaseViewController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/25.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "SorinBaseViewController.h"

@interface SorinBaseViewController ()

@end

@implementation SorinBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.view bringSubviewToFront:self.sorinNavigationbar];
}
- (SorinNavgationbar *)sorinNavigationbar{
    if (!_sorinNavigationbar) {
        SorinNavgationbar *sorinNavigationbar = [[SorinNavgationbar alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kStatusBarHeight + 44)];
        [self.view addSubview:sorinNavigationbar];
        _sorinNavigationbar = sorinNavigationbar;
        sorinNavigationbar.barDelegate = self;
        sorinNavigationbar.barDataSource = self;
    }
    return _sorinNavigationbar;
}
- (void)dealloc{
    NSLog(@"dealloc");
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
