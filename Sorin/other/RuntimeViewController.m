//
//  RuntimeViewController.m
//  Sorin
//
//  Created by carlos on 2018/4/26.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/runtime.h>
@interface RuntimeViewController ()
@property(nonatomic,strong)NSString *class_variable;
@property(nonatomic,strong)NSString *Instance_variable;
@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.class_variable = @"class_variable";
    self.Instance_variable = @"Instance_variable";
    self.view.backgroundColor = [UIColor RandomColor];
    
    // Do any additional setup after loading the view.
    NSArray *line1 = [NSArray arrayWithObjects:@"类名",@"父类名",@"元类否",@"类大小",@"实例变量",@"类变量", nil];
    NSMutableArray *btn1 = [NSMutableArray array];
    for (int i = 0; i < line1.count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        [btn setTitle:line1[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.backgroundColor = [UIColor RandomColor];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 addObject:btn];
        [self.view addSubview:btn];
    }
    [btn1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:0 tailSpacing:0];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sorinNavigationbar.sorin_height);
        make.height.mas_equalTo(30);
    }];
    
    
    NSArray *line2 = [NSArray arrayWithObjects:@"添加属性",@"父类名",@"元类否",@"类大小",@"实例变量",@"类变量", nil];
    NSMutableArray *btn2 = [NSMutableArray array];
    for (int i = 0; i < line2.count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i + btn1.count;
        [btn setTitle:line2[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor RandomColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addObject:btn];
        [self.view addSubview:btn];
    }
    [btn2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:0 tailSpacing:0];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sorinNavigationbar.sorin_height + 40);
        make.height.mas_equalTo(30);
    }];
    
    
}
- (void)clickBtn:(UIButton *)sender{
    //学而不思则罔 思而不学则殆
    //读万卷书 行万里路
    //天道酬勤
    //上善若水 厚德载物
    //博观而约取 厚积而薄发
    //善始者实繁 克终者盖寡
    //博施济众 广智求真
    //积一时之跬步 臻千里之遥程
    //获取类名
    const char *className = class_getName(self.class);
    //获取父类名
    Class superClass = class_getSuperclass(self.class);
    //是否为元类
    BOOL isMetaClass = class_isMetaClass(self.class);
    //类的大小
    size_t ClassSize = class_getInstanceSize(self.class);
    //获取具体的实例变量
    Ivar Instance_variable = class_getInstanceVariable(self.class, "_Instance_variable");
    //获取具体的类变量
    Ivar class_variable = class_getInstanceVariable(self.class, "_class_variable");
    unsigned int count ;
    Ivar va = *class_copyIvarList(self.class, &count);
    /* 注意 不能在已有的类添加方法
    NSUInteger size;
    NSUInteger alignment;
    NSGetSizeAndAlignment("*", &size, &alignment);
    BOOL addIvar = class_addIvar(self.class, "age", size, alignment, "*");
     */
    
    switch (sender.tag) {
        case 0:
            [self.view makeToast:[NSString stringWithFormat:@"class name is %s",className] duration:2 position:CSToastPositionCenter];
            break;
        case 1:
            [self.view makeToast:[NSString stringWithFormat:@"SuperClass name is %@",superClass] duration:2 position:CSToastPositionCenter];
            break;
        case 2:
            [self.view makeToast:[NSString stringWithFormat:@"%@",isMetaClass?@"is MetaClass":@"not MetaClass"] duration:2 position:CSToastPositionCenter];
            break;
        case 3:
            [self.view makeToast:[NSString stringWithFormat:@"class_Size is %zu bytes",ClassSize] duration:2 position:CSToastPositionCenter];
            break;
        case 4:
            [self.view makeToast:[NSString stringWithFormat:@"实例变量名%s,变量编码类型%s,变量类的大小%td", ivar_getName(Instance_variable),ivar_getTypeEncoding(Instance_variable),ivar_getOffset(Instance_variable)] duration:2 position:CSToastPositionCenter];
            break;
        case 5:
            [self.view makeToast:[NSString stringWithFormat:@"类变量名%s,变量编码类型%s,变量类的大小%td", ivar_getName(class_variable),ivar_getTypeEncoding(class_variable),ivar_getOffset(class_variable)] duration:2 position:CSToastPositionCenter];
            break;
        case 6:
//            [self.view makeToast:[NSString stringWithFormat:@"%@",addIvar?@"动态添加类属性成功":@"动态添加类属性失败"] duration:2 position:CSToastPositionCenter];
            break;
        case 7:
            
            break;
        case 8:
            
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableAttributedString *)sorinNavigationbarTitle:(SorinNavgationbar *)navigationBar{
    const char *ClassName = class_getName(self.class);
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%s",ClassName]];
    return titleStr;
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
