//
//  BEMenuViewController.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/4/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BEMenuViewController.h"

#import "BEBadge.h"
#import "BEBadgeTableViewController.h"
#import "BECategory.h"
#import "BECategoryButton.h"
#import "BEConnectionHelper.h"
#import "BEPrimaryButton.h"
#import "Masonry.h"
#import "UIColor+BE.h"

static NSString * const kBadgeAPIURL = @"http://www.khanacademy.org/api/v1/badges";
static NSString * const kCategoryAPIURL = @"http://www.khanacademy.org/api/v1/badges/categories";
static const CGFloat kVerticalPadding = 50.f;
static const CGFloat kHorizontalPadding = 60.f;
static const CGFloat kBadgeSize = 110.f;

@interface BEMenuViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic) NSMutableArray *badges;
@property (nonatomic) NSMutableArray *categories;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *viewAllButton;

@end

@implementation BEMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor navyColor];

    self.badges = [NSMutableArray array];
    self.categories = [NSMutableArray array];

    // scroll view
    self.scrollView = [[UIScrollView alloc] init];

    [self.view addSubview:self.scrollView];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    // logo image view
    UIImage *logo = [UIImage imageNamed:@"KALogo"];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];

    [self.scrollView addSubview:logoView];

    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(kVerticalPadding);
        make.centerX.equalTo(self.view);
    }];

    // title label
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = NSLocalizedString(@"Badge Explorer", nil);
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:38.f];
    [self.titleLabel sizeToFit];

    [self.scrollView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoView).offset(38.f);
        make.centerX.equalTo(self.view);
    }];

    // view all button
    self.viewAllButton = [[BEPrimaryButton alloc] init];
    [self.viewAllButton setTitle:NSLocalizedString(@"View All", nil)
                   forState:UIControlStateNormal];
    self.viewAllButton.hidden = YES;

    [self.viewAllButton addTarget:self
                      action:@selector(viewAll)
            forControlEvents:UIControlEventTouchUpInside];

    [self.scrollView addSubview:self.viewAllButton];

    [self.viewAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kHorizontalPadding);
        make.right.equalTo(self.view).offset(-kHorizontalPadding);
        make.bottom.equalTo(self.scrollView).offset(-40.f);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@45.f);
    }];

    UIActivityIndicatorView *loadingView =
        [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingView.hidesWhenStopped = YES;

    [self.view addSubview:loadingView];

    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];

    [loadingView startAnimating];

    // use connectionhelper to get categories
    BEConnectionHelper *categoryHelper = [[BEConnectionHelper alloc] initWithURLString:kCategoryAPIURL];

    categoryHelper.connectionFinished = ^(NSDictionary *results) {
        [self loadCategoryResults:results];

        // use connectionhelper to get badges
        BEConnectionHelper *badgeHelper = [[BEConnectionHelper alloc] initWithURLString:kBadgeAPIURL];

        badgeHelper.connectionFinished = ^(NSDictionary *results) {
            [self loadBadgeResults:results];
            [self displayButtons];

            [loadingView stopAnimating];
        };

        [badgeHelper sendRequest];
    };

    [categoryHelper sendRequest];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewDidDisappear:animated];
}

#pragma mark UICollectionViewDataSource, UICollectionViewDelegateFlowLayout Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"badgeCell"
                                                                           forIndexPath:indexPath];

    BECategoryButton *button = [[BECategoryButton alloc] initWithCategory:self.categories[indexPath.item]];
    [button addTarget:self action:@selector(viewCategory:) forControlEvents:UIControlEventTouchUpInside];

    [cell.contentView addSubview:button];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(kBadgeSize));
        make.center.equalTo(cell.contentView);
    }];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kBadgeSize, kBadgeSize);
}

#pragma mark Selectors

- (void)loadBadgeResults:(NSDictionary *)results {
    for (NSDictionary *dict in results) {
        BEBadge *badge = [[BEBadge alloc] init];
        badge.name = dict[@"description"];
        badge.blurb = dict[@"safe_extended_description"];
        badge.points = [dict[@"points"] integerValue];
        badge.smallIconURL = [NSURL URLWithString:dict[@"icons"][@"compact"]];
        badge.largeIconURL = [NSURL URLWithString:dict[@"icons"][@"large"]];

        NSUInteger categoryIndex = [dict[@"badge_category"] integerValue];
        BECategory *category = (BECategory *)self.categories[categoryIndex];
        [category.badges addObject:badge];
        badge.category = category.name;

        [self.badges addObject:badge];
    }
}

- (void)loadCategoryResults:(NSDictionary *)results {
    for (NSDictionary *dict in results) {
        BECategory *category = [[BECategory alloc] init];
        category.name = dict[@"type_label"];
        category.blurb = dict[@"description"];
        category.smallIconURL = [NSURL URLWithString:dict[@"compact_icon_src"]];
        category.largeIconURL = [NSURL URLWithString:dict[@"large_icon_src"]];

        [self.categories addObject:category];
    }
}

// display a collectionview of category buttons and the view all button
- (void)displayButtons {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                                          collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;

    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"badgeCell"];

    [self.scrollView addSubview:collectionView];

    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(30.f);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@240.f);
        make.height.equalTo(@350.f);
    }];

    [self.viewAllButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(collectionView.mas_bottom).offset(35.f);
    }];
    self.viewAllButton.hidden = NO;
}

- (void)viewAll {
    BEBadgeTableViewController *badgeTableVC =
        [[BEBadgeTableViewController alloc] initWithTitle:NSLocalizedString(@"All Badges", nil)
                                                andBadges:self.badges];

    [self.navigationController pushViewController:badgeTableVC animated:YES];
}

- (void)viewCategory:(BECategoryButton *)button {
    BEBadgeTableViewController *badgeTableVC =
    [[BEBadgeTableViewController alloc] initWithTitle:button.category.name
                                            andBadges:button.category.badges];

    [self.navigationController pushViewController:badgeTableVC animated:YES];
}

@end
