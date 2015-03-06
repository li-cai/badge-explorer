//
//  BEPrimaryButton.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/5/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BEPrimaryButton.h"

#import "UIColor+BE.h"

@implementation BEPrimaryButton

- (instancetype)init {
    self = [super init];

    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor leafColor];
        self.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.f];
        self.layer.cornerRadius = 25.f;
    }

    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted ? [UIColor darkGreenColor] : [UIColor leafColor];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    self.backgroundColor = enabled ? [UIColor leafColor] : [UIColor grayColor];
}

@end
