//
//  BEMenuViewController.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/4/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BEMenuViewController.h"

#import "BEBadge.h"
#import "BECategory.h"
#import "BEConnectionHelper.h"
#import "Masonry.h"
#import "UIColor+BE.h"

static NSString * const kBadgeAPIURL = @"http://www.khanacademy.org/api/v1/badges";
static const NSString * const kCategoryAPIURL = @"http://www.khanacademy.org/api/v1/badges/categories";

@interface BEMenuViewController ()

@property (nonatomic) NSMutableArray *badges;
@property (nonatomic) NSMutableArray *categories;

@end

@implementation BEMenuViewController

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor navyColor];

    // logo image view
    UIImage *logo = [UIImage imageNamed:@"KALogo"];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];

    [self.view addSubview:logoView];

    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80.f);
        make.centerX.equalTo(self.view);
    }];

    // title label
    UILabel *title = [[UILabel alloc] init];
    title.text = NSLocalizedString(@"Badge Explorer", nil);
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:38.f];
    [title sizeToFit];

    [self.view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoView).offset(38.f);
        make.centerX.equalTo(self.view);
    }];

    self.badges = [NSMutableArray array];
    self.categories = [NSMutableArray array];

    BEConnectionHelper *badgeHelper = [[BEConnectionHelper alloc] initWithURLString:kBadgeAPIURL];

    badgeHelper.connectionFinished = ^(NSDictionary *results) {
        [self loadBadgeResults:results];
    };

    [badgeHelper sendRequest];
}

- (void)loadBadgeResults:(NSDictionary *)results {
    for (NSDictionary *dict in results) {
        BEBadge *badge = [[BEBadge alloc] init];
        badge.name = dict[@"description"];
        badge.blurb = dict[@"safe_extended_description"];
        badge.points = [dict[@"points"] integerValue];
        badge.category = [dict[@"category"] integerValue];
        badge.smallIconURL = [NSURL URLWithString:dict[@"icons"][@"compact"]];
        badge.largeIconURL = [NSURL URLWithString:dict[@"icons"][@"large"]];

        [self.badges addObject:badge];
    }
}

- (void)loadCategoryResults:(NSDictionary *)results {
    for (NSDictionary *dict in results) {
        BECategory *category = [[BECategory alloc] init];
        category.name = dict[@"type_label"];
        category.blurb = dict[@"description"];
        category.index = [dict[@"category"] integerValue];
        category.smallIconURL = [NSURL URLWithString:dict[@"compact_icon_src"]];
        category.largeIconURL = [NSURL URLWithString:dict[@"large_icon_src"]];

        [self.categories addObject:category];
    }
}

@end
