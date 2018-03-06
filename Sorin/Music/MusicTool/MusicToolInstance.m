//
//  MusicToolInstance.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/25.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicToolInstance.h"
@interface MusicToolInstance();
@property (nonatomic,assign)NSInteger musicIdx;
@end;
@implementation MusicToolInstance
+ (instancetype)shareInstance{
    static MusicToolInstance *ToolInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ToolInstance = [[MusicToolInstance alloc] init];
    });
    return ToolInstance;
}
- (void)playMusicMdel:(MusicModel *)model{
    self.musicIdx = [[MusicInfoModel shareInstance].musicList indexOfObject:model];
    NSString *path = [[NSBundle mainBundle] pathForResource:model.name ofType:@"mp3"];
    NSURL *locaPath = [NSURL fileURLWithPath:path];
    
    if ([locaPath isEqual:[self urlOfCurrentlyPlayingInPlayer:self.musicPlayer]]) {
        [self.musicPlayer play];
    }else{
        self.musicPlayer = nil;
        self.musicPlayer = [[AVPlayer alloc] initWithURL:locaPath];
        [self.musicPlayer play];
    }
}
- (void)playMusic{
    [self.musicPlayer play];
}
- (void)pauseMusic{
    [self.musicPlayer pause];
}
- (void)setMusicIdx:(NSInteger)musicIdx{
    _musicIdx = musicIdx;
    if (musicIdx < 0) {
        _musicIdx = [MusicInfoModel shareInstance].musicList.count - 1;
    }else if( musicIdx > [MusicInfoModel shareInstance].musicList.count - 1){
        _musicIdx = 0;
    }
}
- (void)playPrevious{
    self.musicIdx --;
    [self playMusicMdel:[MusicInfoModel shareInstance].musicList[self.musicIdx]];
}
- (void)playNext{
    self.musicIdx ++;
    [self playMusicMdel:[MusicInfoModel shareInstance].musicList[self.musicIdx]];
}
- (void)changePlayData{
    [MusicInfoModel shareInstance].musicModel = [MusicInfoModel shareInstance].musicList[self.musicIdx];
    [MusicInfoModel shareInstance].LrcList = [[MusicToolInstance shareInstance] getLrcData:[MusicInfoModel shareInstance].musicModel.name];
}
- (BOOL)isPlaying{
    if ((self.musicPlayer.rate = 1.000000)) {
        _isPlaying = YES;
    }else{
        _isPlaying = NO;
    }
    return _isPlaying;
}
-(NSURL *)urlOfCurrentlyPlayingInPlayer:(AVPlayer *)player{
    
    AVAsset *currentPlayerAsset = player.currentItem.asset;
    
    if (![currentPlayerAsset isKindOfClass:AVURLAsset.class]){
        return nil;
    }
    
    return [(AVURLAsset *)currentPlayerAsset URL];
}
- (NSArray <LrcModel *> *)getLrcData:(NSString *)lrcName{
    NSString *lrcPath = [[NSBundle mainBundle] pathForResource:lrcName ofType:@"lrc"];
    NSString *lrcStr = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
    __block NSArray *tempArr = [lrcStr componentsSeparatedByString:@"\n"];
    __block NSMutableArray <LrcModel *>*lrcModelArray = [NSMutableArray array];
    [tempArr enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL contains = [str containsString:@"[ti"] || [str containsString:@"[ar"] || [str containsString:@"[al"];
        if (!contains) {
            LrcModel *lrcModel = [[LrcModel alloc] init];
            NSString *resultStr = [str stringByReplacingOccurrencesOfString:@"[" withString:@""];
            tempArr = [resultStr componentsSeparatedByString:@"]"];
            if (tempArr.count  == 2) {
                lrcModel.lrcLabel = tempArr[1];
                lrcModel.startTime = [self getTimewithStr:tempArr[0]];
                [lrcModelArray addObject:lrcModel];
            }
        }
    }];
    NSInteger count = lrcModelArray.count;
    [lrcModelArray enumerateObjectsUsingBlock:^(LrcModel  *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != count - 1) {
            lrcModelArray[idx].endTime = lrcModelArray[idx + 1].startTime;
        }
    }];
    return lrcModelArray;
}
+ (void)getLrcInfo:(NSTimeInterval)currentTime LrcsData:(NSArray<LrcModel *> *)modelData complete:(void (^)(LrcModel *, NSInteger))complete{
    __block LrcModel *model = [[LrcModel alloc] init];
    __block NSInteger row = 0;
    [modelData enumerateObjectsUsingBlock:^(LrcModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (currentTime >= obj.startTime && currentTime <= obj.endTime) {
            row = idx;
            model = obj;
            *stop = YES;
        }
    }];
    complete(model,row);
}
- (NSTimeInterval)getTimewithStr:(NSString *)timeStr{
    NSArray *timeArr = [timeStr componentsSeparatedByString:@":"];
    if (timeArr.count == 2) {
        NSTimeInterval S = [timeArr[0] doubleValue];
        NSTimeInterval M = [timeArr[1] doubleValue];
        return S * 60 + M;
    }
    return 0;
}
@end
