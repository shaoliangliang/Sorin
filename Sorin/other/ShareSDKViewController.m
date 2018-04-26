//
//  ShareSDKViewController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/4/25.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "ShareSDKViewController.h"

@interface ShareSDKViewController ()

@end

@implementation ShareSDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *title = @[@"登录",@"分享"];
    NSMutableArray <UIButton *>*btnArr = [NSMutableArray array];
    for (int i = 0; i < title.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:title[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor RandomColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btnArr addObject:btn];
        [self.view addSubview:btn];
    }
//    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:100 leadSpacing:10 tailSpacing:10];
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:10];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(44);
        
    }];
    // Do any additional setup after loading the view.
}
- (void)clickBtn:(UIButton *)sender{
    if (sender.tag == 0) {
        [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess) {
                
            }else{
                
            }
        }];
    }else{
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        //shhare系统分享
        [shareParams SSDKSetupShareParamsByText:@"分享内容" images:[UIImage imageNamed:@"12422208"] url:nil title:@"title" type:SSDKContentTypeAuto];
        //设置单独的分享参数 微信举例
        [shareParams SSDKSetupWeChatParamsByText:@"wechat" title:@"wechattitle" url:nil thumbImage:[UIImage imageNamed:@"12422208"] image:[UIImage imageNamed:@"12422208"] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
        }];
    }
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
