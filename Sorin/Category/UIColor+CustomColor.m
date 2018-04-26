//
//  UIColor+CustomColor.m
//  Sorin
//
//  Created by carlos on 2018/4/25.
//  Copyright © 2018年 shaoliangliang. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)
+ (UIColor *)RandomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}
@end
