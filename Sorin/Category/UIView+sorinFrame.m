//
//  UIView+sorinFrame.m
//  Sorin
//
//  Created by 邵亮亮 on 2018/2/28.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "UIView+sorinFrame.h"

@implementation UIView (sorinFrame)
- (CGFloat)sorin_width{
    return self.frame.size.width;
}
- (void)setSorin_width:(CGFloat)sorin_width{
    CGRect frame = self.frame;
    frame.size.width = sorin_width;
    self.frame = frame;
}
- (CGFloat)sorin_height{
    return self.frame.size.height;
}
- (void)setSorin_height:(CGFloat)sorin_height{
    CGRect frame = self.frame;
    frame.size.height = sorin_height;
    self.frame = frame;
}
- (CGRect)sorin_frame{
    return self.frame;
}
- (void)setSorin_frame:(CGRect)sorin_frame{
    CGRect frame = self.frame;
    frame = sorin_frame;
    self.frame = frame;
}
@end
