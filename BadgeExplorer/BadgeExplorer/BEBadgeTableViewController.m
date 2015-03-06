//
//  BEBadgeTableViewController.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/5/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BEBadgeTableViewController.h"

#import "BEBadge.h"
#import "BEBadgeDetailViewController.h"
#import "BEBadgeTableViewCell.h"
#import "Masonry.h"

static const CGFloat kRowHeight = 95.f;

@interface BEBadgeTableViewController ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic) NSArray *badges;

@end

@implementation BEBadgeTableViewController

- (instancetype)initWithTitle:(NSString *)title andBadges:(NSArray *)badges {
    self = [super init];

    if (self) {
        self.title = title;
        self.badges = badges;

        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }

    return self;
}

#pragma mark TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.badges.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BEBadge *badge = self.badges[indexPath.row];
    BEBadgeTableViewCell *cell = [[BEBadgeTableViewCell alloc] initWithBadge:badge];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BEBadge *badge = self.badges[indexPath.row];
    BEBadgeDetailViewController *badgeDetailVC = [[BEBadgeDetailViewController alloc] initWithBadge:badge];

    [self.navigationController pushViewController:badgeDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

@end
