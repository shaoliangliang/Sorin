//
//  MusicInfoModel.h
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/25.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicModel.h"
@interface MusicInfoModel : NSObject
//当前歌曲信息
@property (nonatomic,strong) MusicModel *musicModel;
//当前歌曲歌词
@property (nonatomic,copy) NSArray <LrcModel *> *LrcList;
//所有歌曲列表
@property (nonatomic,copy) NSMutableArray <MusicModel *> *musicList;

+ (instancetype)shareInstance;
@end
