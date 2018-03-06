//
//  LrcModel.h
//  Sorin
//
//  Created by 邵亮亮 on 2018/3/3.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrcModel : NSObject
@property (nonatomic,assign) NSTimeInterval startTime;
@property (nonatomic,assign) NSTimeInterval endTime;
@property (nonatomic,copy)   NSString *lrcLabel;
@end
