//
//  BEBadgeDetailViewController.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/5/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BEBadgeDetailViewController.h"

#import "Masonry.h"
#import "UIColor+BE.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface BEBadgeDetailViewController ()

@property (nonatomic) BEBadge *badge;

@end

@implementation BEBadgeDetailViewController

- (instancetype)initWithBadge:(BEBadge *)badge {
    self = [super init];

    if (self) {
        self.badge = badge;
        self.title = badge.name;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    // scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] init];

    [self.view addSubview:scrollView];

    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    // large icon
    UIImageView *iconView = [[UIImageView alloc] init];
    [iconView sd_setImageWithURL:self.badge.largeIconURL];

    [scrollView addSubview:iconView];

    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView).offset(40.f);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.6f);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.6f);
    }];

    // name label
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = self.badge.name;
    nameLabel.font = [UIFont fontWithName:@"Avenir" size:28.f];
    nameLabel.numberOfLines = 0;
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [nameLabel sizeToFit];

    [scrollView addSubview:nameLabel];

    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(20.f);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.8f);
        make.centerX.equalTo(self.view);
    }];

    // category label
    UILabel *categoryLabel = [[UILabel alloc] init];
    categoryLabel.text = self.badge.category;
    categoryLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18.f];
    categoryLabel.numberOfLines = 0;
    categoryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    categoryLabel.textAlignment = NSTextAlignmentCenter;
    [categoryLabel sizeToFit];

    [scrollView addSubview:categoryLabel];

    [categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(5.f);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.8f);
        make.centerX.equalTo(self.view);
    }];

    // blurb label
    UILabel *blurbLabel = [[UILabel alloc] init];
    blurbLabel.text = self.badge.blurb;
    blurbLabel.font = [UIFont fontWithName:@"Avenir-LightOblique" size:22.f];
    blurbLabel.numberOfLines = 0;
    blurbLabel.lineBreakMode = NSLineBreakByWordWrapping;
    blurbLabel.textAlignment = NSTextAlignmentCenter;
    [blurbLabel sizeToFit];

    [scrollView addSubview:blurbLabel];

    [blurbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(categoryLabel.mas_bottom).offset(25.f);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.8f);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(scrollView.mas_bottom).offset(-50.f);
    }];

    // points label
    UILabel *pointsLabel = [[UILabel alloc] init];
    pointsLabel.textColor = [UIColor whiteColor];
    pointsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.badge.points];
    pointsLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:14.f];
    pointsLabel.textAlignment = NSTextAlignmentCenter;
    pointsLabel.backgroundColor = [UIColor leafColor];
    pointsLabel.layer.cornerRadius = 6.f;
    pointsLabel.clipsToBounds = YES;

    [scrollView addSubview:pointsLabel];

    [pointsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView).offset(40.f);
        make.right.equalTo(self.view).offset(-30.f);
        make.height.equalTo(@32.f);
        make.width.greaterThanOrEqualTo(@60.f);
    }];

    if (self.badge.points == 0) {
        pointsLabel.hidden = YES;
    }
}

@end
