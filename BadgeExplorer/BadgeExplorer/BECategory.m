//
//  BECategory.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/5/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BECategory.h"

@implementation BECategory

- (instancetype)init {
    self = [super init];

    if (self) {
        self.name = NSLocalizedString(@"No Name", nil);
        self.blurb = NSLocalizedString(@"No Description", nil);
        self.badges = [NSMutableArray array];
    }

    return self;
}

@end
