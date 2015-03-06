//
//  BEBadgeTableViewCell.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/5/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BEBadgeTableViewCell.h"

#import "BEBadge.h"
#import "Masonry.h"
#import "UIColor+BE.h"

#import <SDWebImage/UIImageView+WebCache.h>

static const CGFloat kHorizontalPadding = 20.f;
static const CGFloat kLeftPadding = 75.f;

@interface BEBadgeTableViewCell ()

@property UILabel *nameLabel;
@property UIImageView *imageIcon;

@end

@implementation BEBadgeTableViewCell

- (instancetype)initWithBadge:(BEBadge *)badge {
    self = [super init];

    if (self) {
        // image view
        self.imageIcon = [[UIImageView alloc] init];
        [self.imageView sd_setImageWithURL:badge.smallIconURL
                          placeholderImage:[UIImage imageNamed:@"Loading"]];

        [self.contentView addSubview:self.imageIcon];

        [self.imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kHorizontalPadding);
            make.centerY.equalTo(self.contentView);
        }];

        // name label
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.text = NSLocalizedString(badge.name, nil);
        self.nameLabel.font = [UIFont fontWithName:@"Avenir-Light" size:22.f];
        [self.nameLabel sizeToFit];

        [self.contentView addSubview:self.nameLabel];

        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageIcon).offset(kLeftPadding);
            make.right.equalTo(self.contentView).offset(-kHorizontalPadding);
            make.centerY.equalTo(self.contentView);
        }];

        // background view
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor leafColor];
        self.selectedBackgroundView = bgView;
    }

    return self;
}

@end
