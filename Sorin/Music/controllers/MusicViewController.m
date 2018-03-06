//
//  MusicViewController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/25.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicInfoModel.h"
#import "MusicPlayViewController.h"
NSString  *const listCell = @"listCell";
@interface MusicViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *musicListTableview;
@end

@implementation MusicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.musicListTableview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [MusicInfoModel shareInstance].musicList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [MusicInfoModel shareInstance].musicList[indexPath.row].name;
    cell.detailTextLabel.text = [MusicInfoModel shareInstance].musicList[indexPath.row].singer;
    cell.imageView.image = [UIImage imageNamed:[MusicInfoModel shareInstance].musicList[indexPath.row].icon];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableView *)musicListTableview{
    if (!_musicListTableview) {
        _musicListTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.sorinNavigationbar.sorin_height, self.view.sorin_width, self.view.sorin_height - 44) style:UITableViewStylePlain];
        IOS_11_ADJUST(_musicListTableview);
        _musicListTableview.dataSource = self;
        _musicListTableview.delegate = self;
        _musicListTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_musicListTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:listCell];
    }
    return _musicListTableview;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MusicInfoModel shareInstance].musicModel = [MusicInfoModel shareInstance].musicList[indexPath.row];
    [MusicInfoModel shareInstance].LrcList = [[MusicToolInstance shareInstance] getLrcData:[MusicInfoModel shareInstance].musicModel.name];
    MusicPlayViewController *play = [MusicPlayViewController new];
    play.modalTransitionStyle = arc4random() % 4;
    [self presentViewController:play animated:YES completion:^{
        [[MusicToolInstance shareInstance] playMusicMdel:[MusicInfoModel shareInstance].musicModel];
    }];
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
