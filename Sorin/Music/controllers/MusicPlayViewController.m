//
//  MusicPlayViewController.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/28.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicPlayViewController.h"
#import "LrcView.h"
#import <CoreFoundation/CoreFoundation.h>
@interface MusicPlayViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *backgroundIma;
@property (nonatomic,strong) UIImageView *singerIma;
@property (nonatomic,strong) LrcView *lrcView;
@property (nonatomic,strong) UIVisualEffectView *effectView;
@property (nonatomic,strong) UIButton *pauseBtn;
@property (nonatomic,strong) CADisplayLink *displayLink;
@end
enum {
    preMucic = 0,
    pauseMusic,
    nextMusic
};
@implementation MusicPlayViewController
- (UIImageView *)backgroundIma{
    if (!_backgroundIma) {
        _backgroundIma = [[UIImageView alloc] initWithFrame:self.view.frame];
        [_backgroundIma addSubview:self.effectView];
    }
    return _backgroundIma;
}
- (UIImageView *)singerIma{
    if (!_singerIma) {
        _singerIma = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _singerIma.center = self.view.center;
        _singerIma.layer.masksToBounds = YES;
        _singerIma.layer.cornerRadius = _singerIma.sorin_width / 2;
    }
    return _singerIma;
}
- (UIVisualEffectView *)effectView{
    if (!_effectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithFrame:self.backgroundIma.frame];
        _effectView.effect = effect;
    }
    return _effectView;
}
- (LrcView *)lrcView{
    if (!_lrcView) {
        _lrcView = [[LrcView alloc] initWithFrame:CGRectMake(0, 100, self.view.sorin_width, self.view.sorin_width)];
        _lrcView.contentSize = CGSizeMake(self.view.sorin_width * 2, 0);
        _lrcView.pagingEnabled = YES;
        _lrcView.showsHorizontalScrollIndicator = NO;
    }
    return _lrcView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat alpha = scrollView.contentOffset.x / self.view.sorin_width;
    self.singerIma.alpha = 1 - alpha;
    self.lrcView.lrcsList.alpha =  alpha;
}
- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updataLrc)];
    }
    return _displayLink;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backgroundIma];
    [self.view addSubview:self.singerIma];
    [self.view addSubview:self.lrcView];
    self.lrcView.delegate = self;
    UIButton *preBtn = [self creatBtnWithFrame:CGRectMake(50, self.view.sorin_height - 80, 30, 30) normalIma:@"上一首" hightIma:@"nil" selectIma:@"nil"];
    preBtn.tag = preMucic;
    [self.view addSubview:preBtn];
    
    UIButton *nextBtn = [self creatBtnWithFrame:CGRectMake(self.view.sorin_width - 80, self.view.sorin_height - 80, 30, 30) normalIma:@"下一首" hightIma:@"nil" selectIma:@"nil"];
    nextBtn.tag = nextMusic;
    [self.view addSubview:nextBtn];

    self.pauseBtn = [self creatBtnWithFrame:CGRectMake((self.view.sorin_width - 48) / 2, self.view.sorin_height - 89, 48, 48) normalIma:@"播放" hightIma:@"nil" selectIma:@"暂停"];
    self.pauseBtn.tag = pauseMusic;
    [self.view addSubview:self.pauseBtn];
    [self setUI];
}
- (void)clickMusicStatus:(UIButton *)sender{
    if (sender.tag == preMucic) {
        [[MusicToolInstance shareInstance] playPrevious];
        [self refreshMusicData];
    }if (sender.tag == nextMusic) {
        [[MusicToolInstance shareInstance] playNext];
        [self refreshMusicData];
    }if (sender.tag == pauseMusic) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            [[MusicToolInstance shareInstance] playMusic];
            [self resumeAnimation];
        }else{
            [[MusicToolInstance shareInstance] pauseMusic];
            [self pauseAnimation];
        }
    }
}
- (UIButton *)creatBtnWithFrame:(CGRect)frame normalIma:(NSString *)imaName hightIma:(NSString *)hightName selectIma:(NSString *)selectName{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:imaName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hightName] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:selectName] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(clickMusicStatus:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)refreshMusicData{
    [[MusicToolInstance shareInstance] changePlayData];
    [self setUI];
}
- (void)setUI{
    self.backgroundIma.image = [UIImage imageNamed:[MusicInfoModel shareInstance].musicModel.icon];
    self.singerIma.image = [UIImage imageNamed:[MusicInfoModel shareInstance].musicModel.singerIcon];
    self.sorinNavigationbar.title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[MusicInfoModel shareInstance].musicModel.name,[MusicInfoModel shareInstance].musicModel.singer]];
    [self.lrcView setLrcArray:[MusicInfoModel shareInstance].LrcList];
    self.pauseBtn.selected = [MusicToolInstance shareInstance].isPlaying;
    [self startAnimation];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}
- (void)updataLrc{
    NSTimeInterval currentTime = CMTimeGetSeconds([MusicToolInstance shareInstance].musicPlayer.currentTime);
    [MusicToolInstance getLrcInfo:currentTime LrcsData:[MusicInfoModel shareInstance].LrcList complete:^(LrcModel *model, NSInteger currentRow) {
        self.lrcView.row = currentRow;
    }];
}
- (void)startAnimation{
    [self.singerIma.layer removeAnimationForKey:@"key"];
    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    transform.fromValue = 0;
    transform.toValue = @(M_PI * 2);
    transform.duration = 60;
    transform.repeatCount = MAXFLOAT;
    transform.removedOnCompletion = NO;
    self.singerIma.layer.speed = 1;
    [self.singerIma.layer addAnimation:transform forKey:@"key"];
}
- (void)pauseAnimation{
    CFTimeInterval pauseTime = [self.singerIma.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.singerIma.layer.timeOffset = pauseTime;
    self.singerIma.layer.speed = 0;
}
-(void)resumeAnimation{
    CFTimeInterval pauseTime = self.singerIma.layer.timeOffset;
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    [self.singerIma.layer setTimeOffset:0];
    [self.singerIma.layer setBeginTime:begin];
    self.singerIma.layer.speed = 1;
}
- (UIView *)sorinNavagationbarLeftView:(SorinNavgationbar *)navigationBar{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    btn.backgroundColor = [UIColor redColor];
    return btn;
}
-(void)leftClickEvent:(UIButton *)eventBtn navigationbar:(SorinNavgationbar *)navigationbar{
    [_displayLink invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSMutableAttributedString *)sorinNavigationbarTitle:(SorinNavgationbar *)navigationBar{
    return [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[MusicInfoModel shareInstance].musicModel.name,[MusicInfoModel shareInstance].musicModel.singer]];
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
