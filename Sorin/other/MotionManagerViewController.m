//
//  MotionManagerViewController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/3/7.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MotionManagerViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface MotionManagerViewController ()
@property (nonatomic,strong) CMMotionManager *motionManager;

@end

@implementation MotionManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.motionManager.gyroUpdateInterval = 1.0;
    
    // Do any additional setup after loading the view.
}
- (CMMotionManager *)motionManager{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}
- (NSMutableAttributedString *)sorinNavigationbarTitle:(SorinNavgationbar *)navigationBar{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:NSStringFromClass([self class])];
    return title;
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
