//
//  UIColor+BE.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/4/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "UIColor+BE.h"

@implementation UIColor (BE)

+ (UIColor *)leafColor {
    return [UIColor colorWithHex:0x96ab4f];
}

+ (UIColor *)colorWithHex:(unsigned)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                           green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}

@end
