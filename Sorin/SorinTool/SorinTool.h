//
//  SorinTool.h
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/27.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#ifndef SorinTool_h

#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:\n%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#define SorinTool_h
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#endif /* SorinTool_h */
