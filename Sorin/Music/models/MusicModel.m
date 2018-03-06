//
//  MusicModel.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/28.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel
+ (MusicModel *)objMoelWithData:(id)Datasource{
    if (Datasource != nil) {
        NSDictionary *musicData = (NSDictionary *)Datasource;
        MusicModel *musicModel = [[MusicModel alloc] init];
        musicModel.name = musicData[@"name"];
        musicModel.icon = musicData[@"singerIcon"];
        musicModel.lrcname = musicData[@"lrcname"];
        musicModel.singer = musicData[@"singer"];
        musicModel.filename = musicData[@"filename"];
        musicModel.singerIcon = musicData[@"icon"];
        return musicModel;
    }
    return nil;
}
@end
