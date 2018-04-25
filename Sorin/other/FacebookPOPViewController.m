//
//  FacebookPOPViewController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/4/3.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "FacebookPOPViewController.h"
#import <POP.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface FacebookPOPViewController ()
@property (nonatomic,strong)UIButton *pop_view;
@end

@implementation FacebookPOPViewController
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)pre{
    [self.navigationController pushViewController:[GCDViewController new] animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pop_view = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.pop_view.center = CGPointMake(self.view.frame.size.width / 2, 40 + 70);
    self.pop_view.backgroundColor = [UIColor purpleColor];
    [self.pop_view addTarget:self action:@selector(pre) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pop_view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self POPSpring];
    });
    // Do any additional setup after loading the view.
}
- (void)leftClickEvent:(UIButton *)eventBtn navigationbar:(SorinNavgationbar *)navigationbar{
    [self.pop_view pop_removeAnimationForKey:@"center"];
//    [self.navigationController popViewControllerAnimated:YES];
    NSArray* imageArray = @[[UIImage imageNamed:@"12422208.png"]];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}
- (UIView *)sorinNavagationbarLeftView:(SorinNavgationbar *)navigationBar{
    UIButton *v = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    v.backgroundColor = [UIColor redColor];
    return v;
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
