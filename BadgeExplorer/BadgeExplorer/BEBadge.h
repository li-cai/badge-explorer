//
//  Badge.h
//  BadgeExplorer
//
//  Created by Cailin Li on 3/4/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BEBadge : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *blurb;
@property (nonatomic, assign) NSUInteger category;
@property (nonatomic, assign) NSUInteger points;
@property (nonatomic) NSURL *smallIconURL;
@property (nonatomic) NSURL *largeIconURL;

@end
