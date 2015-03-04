//
//  BEMenuViewController.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/4/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BEMenuViewController.h"

#import "Masonry.h"
#import "UIColor+BE.h"

@implementation BEMenuViewController

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:YES];

    self.view.backgroundColor = [UIColor leafColor];

    UILabel *title = [[UILabel alloc] init];
    [title sizeToFit];
    title.text = @"Badge Explorer";

    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
    }];
}

@end
