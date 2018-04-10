//
//  MainViewController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/22.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MainViewController.h"
static NSString *const cellID = @"cell";
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *ListTableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation MainViewController
- (UITableView *)ListTableView{
    if (!_ListTableView) {
        _ListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.sorinNavigationbar.sorin_height, self.view.sorin_width, self.view.sorin_height - 44) style:UITableViewStylePlain];
        _ListTableView.delegate = self;
        _ListTableView.dataSource = self;
        [_ListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        IOS_11_ADJUST(_ListTableView);
    }
    return _ListTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    }
    cell.textLabel.text = NSStringFromClass([self.dataSource[indexPath.row] class]);
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //当自定义返回按钮后 右划返回上一层的代理方法
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray arrayWithObjects:[MotionManagerViewController class],[GCDViewController class],[FacebookPOPViewController class], nil];
    [self.view addSubview:self.ListTableView];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController pushViewController:[self.dataSource[indexPath.row] new] animated:YES];
 
}
- (NSMutableAttributedString *)sorinNavigationbarTitle:(SorinNavgationbar *)navigationBar{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Main"];
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
