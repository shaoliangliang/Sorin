//
//  MusicModel.h
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/28.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LrcModel.h"
@interface MusicModel : NSObject
/** 歌曲名称*/
@property (nonatomic, copy) NSString *name;

/** 演唱者*/
@property (nonatomic, strong) NSString *singer;

/** 歌手头像*/
@property (nonatomic, strong) NSString *singerIcon;

/** 歌词文件名称*/
@property (nonatomic, strong) NSString *lrcname;

/** 歌曲文件名称*/
@property (nonatomic, strong) NSString *filename;

/** 专辑图片*/
@property (nonatomic, strong) NSString *icon;

+ (MusicModel *)objMoelWithData:(id)Datasource;

@end
