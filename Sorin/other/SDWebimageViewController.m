//
//  SDWebimageViewController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/4/10.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "SDWebimageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FLAnimatedImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>
@interface SDWebimageViewController ()

@end

@implementation SDWebimageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    NSURL *pic = [NSURL URLWithString:@"http://admin.lejurobot.cn/uploads/app/72920180223101947562.jpg"];
    //动画指示器要在加载图片之前添加
    [image sd_setShowActivityIndicatorView:YES];
    [image sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [image sd_setImageWithURL:pic];
//    [image sd_setImageWithPreviousCachedImageWithURL:pic placeholderImage:[UIImage imageNamed:@"te"] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//        [image sd_setShowActivityIndicatorView:YES];
//        [image sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
//
//        NSLog(@"%ld--%ld",receivedSize , expectedSize);
//    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
////        [image sd_setShowActivityIndicatorView:NO];
//
//    }];
     [self.view addSubview:image];
    
    
    
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
