//
//  MusicViewController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/25.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
}
- (NSMutableAttributedString *)sorinNavigationbarTitle:(SorinNavgationbar *)navigationBar{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Music"];
    return str;
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
