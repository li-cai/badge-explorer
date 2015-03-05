//
//  BEConnectionHelper.m
//  BadgeExplorer
//
//  Created by Cailin Li on 3/4/15.
//  Copyright (c) 2015 Cailin Li. All rights reserved.
//

#import "BEConnectionHelper.h"

@interface BEConnectionHelper () <NSURLConnectionDelegate>
@property (nonatomic) NSMutableData *returnedData;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic) NSURLConnection *connection;
@end

@implementation BEConnectionHelper

- (instancetype)initWithURLString:(NSString *)urlString {
    self = [super init];

    if (self) {
        self.urlString = urlString;
    }

    return self;
}

- (void)sendRequest {
    if (self.urlString) {
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];

        // Cancel current connection
        if (self.connection) {
            [self.connection cancel];
            self.connection = nil;
            self.returnedData = nil;
        }

        self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        self.returnedData = [NSMutableData data];

        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.returnedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.returnedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Request failed with error message: %@", error);
    self.connection = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"FINI");

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    NSError *jsonError;
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:self.returnedData
                                                            options:NSJSONReadingMutableLeaves
                                                              error:&jsonError];
    if (!jsonError) {
        NSLog(@"%@", results);
    }

}

@end
