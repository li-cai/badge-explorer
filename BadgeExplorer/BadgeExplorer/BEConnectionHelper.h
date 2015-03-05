//
//  BEConnectionHelper.h
//  BadgeExplorer
//
//  Created by Cailin Li on 3/4/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BEConnectionHelper : NSURLConnection

- (instancetype)initWithURLString:(NSString *)requestString;
- (void)sendRequest;

@end
