//
//  NBUCurrenciesNetworking.h
//  currencies
//
//  Created by Joe Franc on 1/4/18.
//  Copyright © 2018 Joe Franc. All rights reserved.
//

#import "CurrenciesNetworking.h"
typedef void (^NBUCompletionBlock)(NSDictionary* responseDict, NSError *error);


@interface NBUCurrenciesNetworking : CurrenciesNetworking

- (void)loadCurrency:(NSString *)currencyBase requestCompletion:(NBUCompletionBlock)completion;

@end
