//
//  BEBadgeTableViewController.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/5/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BEBadgeTableViewController.h"

#import "BEBadge.h"

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
    }

    return self;
}

//- (void)viewDidLoad {
//    self.navigationController.navigationBarHidden = NO;
//}

#pragma mark TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.badges.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];

    BEBadge *badge = self.badges[indexPath.row];

    cell.textLabel.text = badge.name;

    return cell;
}

@end
