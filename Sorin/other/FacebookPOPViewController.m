//
//  FacebookPOPViewController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/4/3.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "FacebookPOPViewController.h"
#import <POP.h>
@interface FacebookPOPViewController ()
@property (nonatomic,strong)UIView *pop_view;
@end

@implementation FacebookPOPViewController
- (void)viewWillAppear:(BOOL)animated{
    self.pop_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.pop_view.center = CGPointMake(self.view.frame.size.width / 2, 40 + 70);
    self.pop_view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.pop_view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self POPSpring];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // Do any additional setup after loading the view.
}
- (void)leftClickEvent:(UIButton *)eventBtn navigationbar:(SorinNavgationbar *)navigationbar{
    [self.pop_view pop_removeAnimationForKey:@"center"];
    [self.pop_view removeFromSuperview];
    [self.sorinNavigationbar removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIView *)sorinNavagationbarLeftView:(SorinNavgationbar *)navigationBar{
    UIButton *v = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    v.backgroundColor = [UIColor redColor];
    return v;
}
- (void)dealloc{
    NSLog(@"xiaohui");
}
- (void)POPSpring{
    POPSpringAnimation *POPSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    POPSpring.springBounciness = 15;
    POPSpring.springSpeed = 10;
    POPSpring.toValue = [NSValue valueWithCGPoint:self.view.center];
    [self.pop_view pop_addAnimation:POPSpring forKey:@"center"];
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
