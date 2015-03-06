//
//  BECategoryButton.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/5/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BECategoryButton.h"

@implementation BECategoryButton

- (instancetype)initWithCategory:(BECategory *)category {
    self = [super init];

    if (self) {
        self.category = category;

        UIImage *icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:category.largeIconURL]];
        [self setImage:icon forState:UIControlStateNormal];
    }

    return self;
}

@end
