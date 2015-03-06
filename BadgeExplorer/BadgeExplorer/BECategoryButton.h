//
//  BECategoryButton.h
//  BadgeExplorer
//
//  Created by Cailin Li on 3/5/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BECategory.h"

@interface BECategoryButton : UIButton

@property (nonatomic) BECategory *category;

- (instancetype)initWithCategory:(BECategory *)category;

@end
