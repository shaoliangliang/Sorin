//
//  MusicInfoModel.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/25.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicInfoModel.h"

@implementation MusicInfoModel
+ (instancetype)shareInstance{
    static MusicInfoModel *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[MusicInfoModel alloc] init];
    });
    return info;
}
- (NSMutableArray <MusicModel *>*)musicList{
    if (!_musicList) {
        _musicList = [NSMutableArray array];
        NSString *list = [[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil];
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:list];
        for (int i = 0; i < array.count;i ++) {
            [_musicList addObject:[MusicModel objMoelWithData:array[i]]];
        }
    }
    return _musicList;
}
@end
