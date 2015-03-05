//
//  Badge.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/4/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BEBadge.h"

@implementation BEBadge

- (instancetype)init {
    self = [super init];

    if (self) {
        self.name = NSLocalizedString(@"No Name", nil);
        self.blurb = NSLocalizedString(@"No Description", nil);
        self.points = 0;
    }

    return self;
}

@end
