//
//  MusicToolInstance.h
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/25.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "LrcModel.h"
//音乐的播放工具
@interface MusicToolInstance : NSObject
@property (nonatomic,strong) AVPlayer *musicPlayer;
@property (nonatomic,assign) BOOL isPlaying;
+ (instancetype)shareInstance;
- (void)playMusicMdel:(MusicModel *)model;
- (void)playPrevious;
- (void)playNext;
- (void)pauseMusic;
- (void)playMusic;
- (void)changePlayData;
//歌词
- (NSArray <LrcModel *> *)getLrcData:(NSString *)lrcName;
+ (void)getLrcInfo:(NSTimeInterval)currentTime LrcsData:(NSArray <LrcModel *>*)modelData complete:(void(^)(LrcModel *model,NSInteger currentRow))complete;
@end
