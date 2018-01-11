//
//  NBUCurrenciesNetworking.m
//  currencies
//
//  Created by Joe Franc on 1/4/18.
//  Copyright © 2018 Joe Franc. All rights reserved.
//

#import "NBUCurrenciesNetworking.h"

@implementation NBUCurrenciesNetworking

- (void)loadCurrency:(NSString *)currencyBase requestCompletion:(NBUCompletionBlock)completion{
    NSDictionary *parametrs = @{@"base" : currencyBase};

    [self loadGETRequest:parametrs requestCompletion:^(id responseObject, NSError *error) {
        if (completion) {
            completion(responseObject, error);
        }
    }];
}

@end
